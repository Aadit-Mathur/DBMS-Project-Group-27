-- =====================================================================
-- db/order_schema.sql   (Ordering module: orders, order_item, payment, shipment)
-- Run in the Neon SQL Editor. Safe to re-run.
--
-- The tables, PK/FK, UNIQUE(order_id) on payment/shipment, the status CHECKs,
-- quantity/price CHECKs and the generated order_item.subtotal ALREADY EXIST,
-- so this file does not recreate them. It adds:
--   1. orders.address_id (delivery address) with a composite FK, so the
--      database itself guarantees the address belongs to the order's customer
--   2. indexes for the order queries
--   3. three transactional functions: place_order, pay_order, cancel_order
--
-- Status values used by the functions (verify with the Step 1 query):
--   orders.order_status     : Pending, Confirmed, Shipped, Delivered, Cancelled
--   payment.payment_status  : Pending, Successful, Refunded
--   shipment.shipment_status: Pending, Shipped, Delivered
-- Product columns used: product_id, price, quantity_in_stock
-- =====================================================================

-- 1. Delivery address on the order ------------------------------------
ALTER TABLE orders  DROP CONSTRAINT IF EXISTS fk_order_address;           -- drop the FK first: it depends on the UNIQUE below
ALTER TABLE address DROP CONSTRAINT IF EXISTS uq_address_id_customer;
ALTER TABLE address ADD  CONSTRAINT uq_address_id_customer UNIQUE (address_id, customer_id);

ALTER TABLE orders ADD COLUMN IF NOT EXISTS address_id bigint NOT NULL;   -- orders is empty, so NOT NULL is safe
ALTER TABLE orders ADD  CONSTRAINT fk_order_address
  FOREIGN KEY (address_id, customer_id)
  REFERENCES address (address_id, customer_id) ON DELETE RESTRICT;

-- 2. Indexes (payment.order_id and shipment.order_id are already indexed by their UNIQUE constraints)
CREATE INDEX IF NOT EXISTS idx_orders_customer     ON orders (customer_id);
CREATE INDEX IF NOT EXISTS idx_order_item_order    ON order_item (order_id);
CREATE INDEX IF NOT EXISTS idx_order_item_product  ON order_item (product_id);

-- 3a. Place an order: ONE transaction (a function call is atomic) -------
-- p_items is a JSON array, e.g. [{"product_id": 12, "quantity": 2}, ...]
CREATE OR REPLACE FUNCTION place_order(
  p_customer_id bigint, p_address_id bigint, p_items jsonb, p_method varchar)
RETURNS bigint
LANGUAGE plpgsql AS $$
DECLARE
  v_order_id bigint;
  v_item     record;
  v_price    numeric;
  v_stock    integer;
BEGIN
  IF NOT EXISTS (SELECT 1 FROM address
                 WHERE address_id = p_address_id AND customer_id = p_customer_id) THEN
    RAISE EXCEPTION 'ADDRESS_INVALID';
  END IF;
  IF p_items IS NULL OR jsonb_typeof(p_items) <> 'array' OR jsonb_array_length(p_items) = 0 THEN
    RAISE EXCEPTION 'EMPTY_ORDER';
  END IF;

  INSERT INTO orders (customer_id, address_id)
  VALUES (p_customer_id, p_address_id)
  RETURNING order_id INTO v_order_id;

  -- lock products in id order so two concurrent orders cannot deadlock
  FOR v_item IN
    SELECT (e->>'product_id')::bigint AS product_id, (e->>'quantity')::int AS quantity
    FROM jsonb_array_elements(p_items) AS e
    ORDER BY 1
  LOOP
    IF v_item.quantity IS NULL OR v_item.quantity <= 0 THEN
      RAISE EXCEPTION 'QTY_INVALID';
    END IF;

    SELECT price, quantity_in_stock INTO v_price, v_stock
    FROM product WHERE product_id = v_item.product_id FOR UPDATE;
    IF NOT FOUND THEN
      RAISE EXCEPTION 'PRODUCT_NOT_FOUND:%', v_item.product_id;
    END IF;
    IF v_stock < v_item.quantity THEN
      RAISE EXCEPTION 'INSUFFICIENT_STOCK:%', v_item.product_id;
    END IF;

    -- subtotal is a GENERATED column, so it is not inserted
    INSERT INTO order_item (order_id, product_id, quantity, unit_price)
    VALUES (v_order_id, v_item.product_id, v_item.quantity, v_price);

    UPDATE product SET quantity_in_stock = quantity_in_stock - v_item.quantity
    WHERE product_id = v_item.product_id;
  END LOOP;

  UPDATE orders
  SET total_amount = (SELECT COALESCE(SUM(subtotal), 0) FROM order_item WHERE order_id = v_order_id)
  WHERE order_id = v_order_id;

  INSERT INTO payment (order_id, payment_method) VALUES (v_order_id, p_method);  -- status defaults to Pending
  RETURN v_order_id;
END $$;

-- 3b. Pay: marks payment Successful, confirms the order, creates the shipment
CREATE OR REPLACE FUNCTION pay_order(p_order_id bigint) RETURNS void
LANGUAGE plpgsql AS $$
DECLARE v_status text;
BEGIN
  SELECT order_status INTO v_status FROM orders WHERE order_id = p_order_id FOR UPDATE;
  IF NOT FOUND THEN RAISE EXCEPTION 'ORDER_NOT_FOUND'; END IF;
  IF v_status <> 'Pending' THEN RAISE EXCEPTION 'NOT_PAYABLE:%', v_status; END IF;

  UPDATE payment SET payment_status = 'Successful', payment_date = now()
  WHERE order_id = p_order_id AND payment_status = 'Pending';
  IF NOT FOUND THEN RAISE EXCEPTION 'NOT_PAYABLE:no pending payment'; END IF;

  UPDATE orders SET order_status = 'Confirmed' WHERE order_id = p_order_id;
  INSERT INTO shipment (order_id) VALUES (p_order_id);                           -- status defaults to Pending
END $$;

-- 3c. Cancel: only before shipping; restores stock
CREATE OR REPLACE FUNCTION cancel_order(p_order_id bigint) RETURNS void
LANGUAGE plpgsql AS $$
DECLARE v_status text;
BEGIN
  SELECT order_status INTO v_status FROM orders WHERE order_id = p_order_id FOR UPDATE;
  IF NOT FOUND THEN RAISE EXCEPTION 'ORDER_NOT_FOUND'; END IF;
  IF v_status NOT IN ('Pending', 'Confirmed') THEN
    RAISE EXCEPTION 'NOT_CANCELLABLE:%', v_status;
  END IF;

  UPDATE product p SET quantity_in_stock = p.quantity_in_stock + oi.quantity
  FROM order_item oi
  WHERE oi.order_id = p_order_id AND oi.product_id = p.product_id;

  UPDATE orders  SET order_status = 'Cancelled' WHERE order_id = p_order_id;
  UPDATE payment SET payment_status = 'Refunded'
  WHERE order_id = p_order_id AND payment_status = 'Successful';
  DELETE FROM shipment WHERE order_id = p_order_id AND shipment_status = 'Pending';  -- unshipped placeholder
END $$;
