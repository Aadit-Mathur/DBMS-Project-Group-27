-- =====================================================================
-- Ordering module (v2): ORDERS, ORDER_ITEM, PAYMENT, SHIPMENT, ORDER_EVENT
-- Target: PostgreSQL 14+ (Neon).  Safe to run more than once.
--
-- Run:   python db_testing/run_sql.py db_testing/order_schema.sql
-- Order: seller_product_schema.sql FIRST (order_item references product).
--
-- The whole file is ONE transaction: if any step fails, nothing changes.
-- It first checks for objects it does not know about (for example triggers
-- someone added directly in Neon) and stops with a clear message instead of
-- overwriting them.
--
-- What it does
--   1. adds the columns the lifecycle needs (delivery address, amount,
--      transaction/refund references, tracking number, cancel reason)
--   2. re-states the status CHECKs; payment gains 'Refunded'
--   3. TRIGGERS: total_amount maintained from the order lines; order lines
--      frozen once placed; status flow enforced (state machines) for orders,
--      payment and shipment; a timeline row (order_event) written on every
--      status change
--   4. FUNCTIONS (each call is one atomic transaction):
--        place_order      validates, locks stock, snapshots prices, decrements stock
--        begin_payment    locks the order and checks it can be paid
--        record_payment   stores the gateway result; success confirms the order
--                         and creates the shipment
--        cancel_order     before shipping only: restocks, refunds if paid
--        advance_shipment Pending -> Shipped -> In Transit -> Delivered
--        expire_unpaid_orders  cancels orders left unpaid too long
--   5. VIEWS: v_paid_orders (revenue = successfully paid orders only),
--             v_order_summary
--
-- Status model
--   orders.order_status      Pending > Confirmed > Shipped > Delivered
--                            Pending/Confirmed > Cancelled
--   payment.payment_status   Pending > Successful > Refunded
--                            Pending > Failed > Successful   (retry)
--   shipment.shipment_status Pending > Shipped > In Transit > Delivered
--                            Pending > Cancelled
--
-- Error codes raised by the functions/triggers (custom SQLSTATE; the API
-- layer maps them to HTTP statuses, see backend/app/routers/orders.py):
--   ORD01 customer not found           404     ORD08 order not found        404
--   ORD02 address not the customer's   400     ORD09 not your order         403
--   ORD03 bad items / quantity / method 400    ORD10 order not payable      409
--   ORD04 product not found            404     ORD11 order not cancellable  409
--   ORD05 product not available        409     ORD12 order lines are fixed  409
--   ORD06 insufficient stock           409     ORD13 field cannot be edited 409
--   ORD07 invalid status change        409
-- =====================================================================

BEGIN;

-- ---------------------------------------------------------------------
-- 0. Pre-flight: refuse to overwrite things this script does not know
-- ---------------------------------------------------------------------
DO $$
DECLARE
    unknown_triggers text;
    unknown_funcs    text;
BEGIN
    IF to_regclass('public.orders') IS NULL OR to_regclass('public.order_item') IS NULL
       OR to_regclass('public.payment') IS NULL OR to_regclass('public.shipment') IS NULL THEN
        RAISE EXCEPTION 'The tables orders, order_item, payment and shipment must exist first.';
    END IF;
    IF to_regclass('public.product') IS NULL OR to_regclass('public.address') IS NULL THEN
        RAISE EXCEPTION 'Run seller_product_schema.sql (and load customers/addresses) first.';
    END IF;

    IF EXISTS (SELECT 1 FROM orders)
       AND NOT EXISTS (SELECT 1 FROM information_schema.columns
                       WHERE table_schema = 'public' AND table_name = 'payment' AND column_name = 'amount') THEN
        RAISE EXCEPTION 'STOP: orders already contains sample data from the earlier version. '
                        'Run db_testing/reset_order_data.sql first, then run this file again.';
    END IF;

    SELECT string_agg(c.relname || '.' || t.tgname, ', ' ORDER BY c.relname, t.tgname)
    INTO   unknown_triggers
    FROM   pg_trigger t
    JOIN   pg_class c ON c.oid = t.tgrelid
    WHERE  NOT t.tgisinternal
      AND  c.relnamespace = 'public'::regnamespace
      AND  c.relname IN ('orders', 'order_item', 'payment', 'shipment')
      AND  t.tgname NOT IN ('trg_order_item_total', 'trg_order_item_frozen', 'trg_orders_guard',
                            'trg_payment_flow', 'trg_shipment_flow',
                            'trg_orders_event', 'trg_payment_event', 'trg_shipment_event',
                            'trg_recalculate_order_total');      -- replaced below by trg_order_item_total
    IF unknown_triggers IS NOT NULL THEN
        RAISE EXCEPTION 'STOP: unexpected triggers exist (%). Someone added them directly in Neon. '
                        'Run db_testing/inspect_orders.py and send the report to Claude before migrating.',
                        unknown_triggers;
    END IF;

    -- not blocking: other user functions that may touch the order tables
    SELECT string_agg(p.proname, ', ' ORDER BY p.proname)
    INTO   unknown_funcs
    FROM   pg_proc p
    WHERE  p.pronamespace = 'public'::regnamespace
      AND  p.prokind = 'f'
      AND  NOT EXISTS (SELECT 1 FROM pg_depend d WHERE d.objid = p.oid AND d.deptype = 'e')
      AND  p.proname NOT IN ('place_order', 'pay_order', 'cancel_order', 'begin_payment',
                             'record_payment', 'advance_shipment', 'expire_unpaid_orders',
                             'fn_order_item_total', 'fn_order_item_frozen', 'fn_orders_guard',
                             'fn_payment_flow', 'fn_shipment_flow', 'fn_order_event',
                             'fn_product_touch', 'restock_product', 'recalculate_order_total');
    IF unknown_funcs IS NOT NULL THEN
        RAISE NOTICE 'Other functions exist (not touched): %', unknown_funcs;
    END IF;
END
$$;

-- keep a copy of any earlier version of the functions we are about to replace
CREATE TABLE IF NOT EXISTS order_fn_backup (
    backup_id          BIGINT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    backed_up_at       TIMESTAMP NOT NULL DEFAULT LOCALTIMESTAMP,
    function_signature TEXT NOT NULL,
    definition         TEXT NOT NULL
);
INSERT INTO order_fn_backup (function_signature, definition)
SELECT p.oid::regprocedure::text, pg_get_functiondef(p.oid)
FROM   pg_proc p
WHERE  p.pronamespace = 'public'::regnamespace
  AND  p.proname IN ('place_order', 'pay_order', 'cancel_order', 'recalculate_order_total')
  AND  pg_get_functiondef(p.oid) NOT LIKE '%ORD0%'          -- skip this version's own functions
  AND  NOT EXISTS (SELECT 1 FROM order_fn_backup b WHERE b.definition = pg_get_functiondef(p.oid));

-- a teammate's equivalent total trigger (saved above): replaced by trg_order_item_total in section 4a
DROP TRIGGER IF EXISTS trg_recalculate_order_total ON order_item;
DROP FUNCTION IF EXISTS recalculate_order_total();

-- old signatures that this version replaces (a leftover overload would make calls ambiguous)
DROP FUNCTION IF EXISTS pay_order(bigint);
DROP FUNCTION IF EXISTS cancel_order(bigint);

-- ---------------------------------------------------------------------
-- 1. Columns
-- ---------------------------------------------------------------------
-- delivery address; the composite FK makes the DATABASE guarantee that the
-- address belongs to the customer who placed the order
ALTER TABLE orders  ADD COLUMN IF NOT EXISTS address_id    BIGINT;
ALTER TABLE orders  ADD COLUMN IF NOT EXISTS cancelled_at  TIMESTAMP;
ALTER TABLE orders  ADD COLUMN IF NOT EXISTS cancel_reason VARCHAR(200);

ALTER TABLE payment ADD COLUMN IF NOT EXISTS amount          NUMERIC(12,2);
ALTER TABLE payment ADD COLUMN IF NOT EXISTS transaction_ref VARCHAR(100);   -- gateway's id for the charge
ALTER TABLE payment ADD COLUMN IF NOT EXISTS refund_ref      VARCHAR(100);   -- gateway's id for the refund
ALTER TABLE payment ADD COLUMN IF NOT EXISTS refunded_at     TIMESTAMP;
ALTER TABLE payment ADD COLUMN IF NOT EXISTS failure_reason  VARCHAR(200);
ALTER TABLE payment ADD COLUMN IF NOT EXISTS attempts        INT NOT NULL DEFAULT 0;

ALTER TABLE shipment ADD COLUMN IF NOT EXISTS carrier         VARCHAR(50);
ALTER TABLE shipment ADD COLUMN IF NOT EXISTS tracking_number VARCHAR(40);

-- rows from an earlier version (if any) need values before NOT NULL / CHECKs
DO $$
BEGIN
    IF EXISTS (SELECT 1 FROM orders WHERE address_id IS NULL) THEN
        RAISE EXCEPTION 'orders contains rows without a delivery address (from an earlier version). '
                        'Run db_testing/reset_order_data.sql first, then run this file again.';
    END IF;
END
$$;
ALTER TABLE orders ALTER COLUMN address_id SET NOT NULL;

UPDATE payment p SET amount = o.total_amount
FROM   orders o WHERE o.order_id = p.order_id AND p.amount IS NULL;
ALTER TABLE payment ALTER COLUMN amount SET NOT NULL;

UPDATE shipment
SET    tracking_number = 'TRK' || lpad(shipment_id::text, 9, '0')
WHERE  tracking_number IS NULL AND shipment_status IN ('Shipped', 'In Transit', 'Delivered');

-- ---------------------------------------------------------------------
-- 2. Constraints
-- ---------------------------------------------------------------------
ALTER TABLE orders   DROP CONSTRAINT IF EXISTS chk_order_status;
ALTER TABLE orders   ADD  CONSTRAINT chk_order_status
    CHECK (order_status IN ('Pending', 'Confirmed', 'Shipped', 'Delivered', 'Cancelled'));

ALTER TABLE payment  DROP CONSTRAINT IF EXISTS chk_payment_status;
ALTER TABLE payment  ADD  CONSTRAINT chk_payment_status
    CHECK (payment_status IN ('Pending', 'Successful', 'Failed', 'Refunded'));

ALTER TABLE shipment DROP CONSTRAINT IF EXISTS chk_shipment_status;
ALTER TABLE shipment ADD  CONSTRAINT chk_shipment_status
    CHECK (shipment_status IN ('Pending', 'Shipped', 'In Transit', 'Delivered', 'Cancelled'));

ALTER TABLE payment DROP CONSTRAINT IF EXISTS chk_payment_method;
ALTER TABLE payment ADD  CONSTRAINT chk_payment_method
    CHECK (payment_method IN ('UPI', 'Credit Card', 'Debit Card', 'Net Banking', 'Wallet'));

ALTER TABLE payment DROP CONSTRAINT IF EXISTS chk_payment_amount;
ALTER TABLE payment ADD  CONSTRAINT chk_payment_amount CHECK (amount >= 0);

ALTER TABLE payment DROP CONSTRAINT IF EXISTS chk_payment_attempts;
ALTER TABLE payment ADD  CONSTRAINT chk_payment_attempts CHECK (attempts >= 0);

-- a paid or refunded payment has a payment date; a refund has a refund time
ALTER TABLE payment DROP CONSTRAINT IF EXISTS chk_payment_dates;
ALTER TABLE payment ADD  CONSTRAINT chk_payment_dates CHECK (
    (payment_status IN ('Successful', 'Refunded')) = (payment_date IS NOT NULL)
    AND (payment_status = 'Refunded') = (refunded_at IS NOT NULL));

-- a shipment that has left the warehouse has a date and a tracking number
ALTER TABLE shipment DROP CONSTRAINT IF EXISTS chk_shipment_dispatched;
ALTER TABLE shipment ADD  CONSTRAINT chk_shipment_dispatched CHECK (
    shipment_status NOT IN ('Shipped', 'In Transit', 'Delivered')
    OR (shipment_date IS NOT NULL AND tracking_number IS NOT NULL));
ALTER TABLE shipment DROP CONSTRAINT IF EXISTS chk_shipment_delivered;
ALTER TABLE shipment ADD  CONSTRAINT chk_shipment_delivered CHECK (
    (shipment_status = 'Delivered') = (delivery_date IS NOT NULL));

ALTER TABLE orders DROP CONSTRAINT IF EXISTS chk_order_cancelled;
ALTER TABLE orders ADD  CONSTRAINT chk_order_cancelled CHECK (
    (order_status = 'Cancelled') = (cancelled_at IS NOT NULL));

-- composite FK: (address_id, customer_id) must be an existing address OF THAT customer
ALTER TABLE orders  DROP CONSTRAINT IF EXISTS fk_order_address;     -- depends on the UNIQUE below
ALTER TABLE address DROP CONSTRAINT IF EXISTS uq_address_id_customer;
ALTER TABLE address ADD  CONSTRAINT uq_address_id_customer UNIQUE (address_id, customer_id);
ALTER TABLE orders  ADD  CONSTRAINT fk_order_address
    FOREIGN KEY (address_id, customer_id) REFERENCES address (address_id, customer_id)
    ON DELETE RESTRICT;

-- ---------------------------------------------------------------------
-- 3. Timeline table + indexes
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS order_event (
    event_id    BIGINT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    order_id    BIGINT       NOT NULL,
    event_time  TIMESTAMP    NOT NULL DEFAULT LOCALTIMESTAMP,
    event_type  VARCHAR(40)  NOT NULL,          -- e.g. 'Order Confirmed', 'Payment Failed', 'Shipment In Transit'
    detail      VARCHAR(200),
    CONSTRAINT fk_order_event_order FOREIGN KEY (order_id) REFERENCES orders (order_id) ON DELETE RESTRICT
);

CREATE INDEX IF NOT EXISTS idx_orders_customer     ON orders (customer_id, order_date DESC);
CREATE INDEX IF NOT EXISTS idx_order_item_order    ON order_item (order_id);
CREATE INDEX IF NOT EXISTS idx_order_item_product  ON order_item (product_id);
CREATE INDEX IF NOT EXISTS idx_order_event_order   ON order_event (order_id, event_time, event_id);
-- expiry job: only Pending orders matter, so the index stays tiny
CREATE INDEX IF NOT EXISTS idx_orders_pending      ON orders (order_date) WHERE order_status = 'Pending';
-- revenue queries: only successful payments
CREATE INDEX IF NOT EXISTS idx_payment_successful  ON payment (payment_date) WHERE payment_status = 'Successful';
CREATE UNIQUE INDEX IF NOT EXISTS uq_shipment_tracking ON shipment (tracking_number) WHERE tracking_number IS NOT NULL;

-- ---------------------------------------------------------------------
-- 4. Triggers
-- ---------------------------------------------------------------------
-- 4a. orders.total_amount is always the sum of the order lines
CREATE OR REPLACE FUNCTION fn_order_item_total() RETURNS trigger
LANGUAGE plpgsql AS $$
DECLARE v_order bigint := COALESCE(NEW.order_id, OLD.order_id);
BEGIN
    UPDATE orders
    SET    total_amount = (SELECT COALESCE(SUM(subtotal), 0) FROM order_item WHERE order_id = v_order)
    WHERE  order_id = v_order;
    RETURN NULL;
END $$;

DROP TRIGGER IF EXISTS trg_order_item_total ON order_item;
CREATE TRIGGER trg_order_item_total
AFTER INSERT OR UPDATE OR DELETE ON order_item
FOR EACH ROW EXECUTE FUNCTION fn_order_item_total();

-- 4b. order lines can only be added while the order is Pending, and never changed
CREATE OR REPLACE FUNCTION fn_order_item_frozen() RETURNS trigger
LANGUAGE plpgsql AS $$
DECLARE v_status text;
BEGIN
    IF TG_OP = 'INSERT' THEN
        SELECT order_status INTO v_status FROM orders WHERE order_id = NEW.order_id;
        IF v_status IS DISTINCT FROM 'Pending' THEN
            RAISE EXCEPTION 'Cannot add items to order % (status %)', NEW.order_id, v_status
                USING ERRCODE = 'ORD12';
        END IF;
        RETURN NEW;
    END IF;
    RAISE EXCEPTION 'Order lines cannot be changed or removed once placed (order %)', OLD.order_id
        USING ERRCODE = 'ORD12';
END $$;

DROP TRIGGER IF EXISTS trg_order_item_frozen ON order_item;
CREATE TRIGGER trg_order_item_frozen
BEFORE INSERT OR UPDATE OR DELETE ON order_item
FOR EACH ROW EXECUTE FUNCTION fn_order_item_frozen();

-- 4c. orders: owner/address fixed, total only maintained by the trigger above, status flow
CREATE OR REPLACE FUNCTION fn_orders_guard() RETURNS trigger
LANGUAGE plpgsql AS $$
BEGIN
    IF NEW.customer_id <> OLD.customer_id OR NEW.address_id <> OLD.address_id THEN
        RAISE EXCEPTION 'The customer and delivery address of order % cannot be changed', OLD.order_id
            USING ERRCODE = 'ORD13';
    END IF;
    -- depth 1 = a direct UPDATE; depth 2 = the order_item trigger doing its job
    IF NEW.total_amount <> OLD.total_amount AND pg_trigger_depth() < 2 THEN
        RAISE EXCEPTION 'total_amount is maintained from the order lines and cannot be edited'
            USING ERRCODE = 'ORD13';
    END IF;
    IF NEW.order_status <> OLD.order_status
       AND (OLD.order_status, NEW.order_status) NOT IN
           (('Pending', 'Confirmed'), ('Pending', 'Cancelled'), ('Confirmed', 'Shipped'),
            ('Confirmed', 'Cancelled'), ('Shipped', 'Delivered')) THEN
        RAISE EXCEPTION 'Order % cannot go from % to %', OLD.order_id, OLD.order_status, NEW.order_status
            USING ERRCODE = 'ORD07';
    END IF;
    RETURN NEW;
END $$;

DROP TRIGGER IF EXISTS trg_orders_guard ON orders;
CREATE TRIGGER trg_orders_guard
BEFORE UPDATE ON orders
FOR EACH ROW EXECUTE FUNCTION fn_orders_guard();

-- 4d. payment status flow
CREATE OR REPLACE FUNCTION fn_payment_flow() RETURNS trigger
LANGUAGE plpgsql AS $$
BEGIN
    IF NEW.order_id <> OLD.order_id THEN
        RAISE EXCEPTION 'A payment cannot be moved to another order' USING ERRCODE = 'ORD13';
    END IF;
    IF NEW.payment_status <> OLD.payment_status
       AND (OLD.payment_status, NEW.payment_status) NOT IN
           (('Pending', 'Successful'), ('Pending', 'Failed'), ('Failed', 'Successful'),
            ('Successful', 'Refunded')) THEN
        RAISE EXCEPTION 'Payment for order % cannot go from % to %',
                        OLD.order_id, OLD.payment_status, NEW.payment_status
            USING ERRCODE = 'ORD07';
    END IF;
    RETURN NEW;
END $$;

DROP TRIGGER IF EXISTS trg_payment_flow ON payment;
CREATE TRIGGER trg_payment_flow
BEFORE UPDATE ON payment
FOR EACH ROW EXECUTE FUNCTION fn_payment_flow();

-- 4e. shipment status flow
CREATE OR REPLACE FUNCTION fn_shipment_flow() RETURNS trigger
LANGUAGE plpgsql AS $$
BEGIN
    IF NEW.order_id <> OLD.order_id THEN
        RAISE EXCEPTION 'A shipment cannot be moved to another order' USING ERRCODE = 'ORD13';
    END IF;
    IF NEW.shipment_status <> OLD.shipment_status
       AND (OLD.shipment_status, NEW.shipment_status) NOT IN
           (('Pending', 'Shipped'), ('Pending', 'Cancelled'), ('Shipped', 'In Transit'),
            ('Shipped', 'Delivered'), ('In Transit', 'Delivered')) THEN
        RAISE EXCEPTION 'Shipment for order % cannot go from % to %',
                        OLD.order_id, OLD.shipment_status, NEW.shipment_status
            USING ERRCODE = 'ORD07';
    END IF;
    RETURN NEW;
END $$;

DROP TRIGGER IF EXISTS trg_shipment_flow ON shipment;
CREATE TRIGGER trg_shipment_flow
BEFORE UPDATE ON shipment
FOR EACH ROW EXECUTE FUNCTION fn_shipment_flow();

-- 4f. timeline: one order_event row per status change (the functions below put a
--     human-readable note in the transaction-local setting app.event_note)
CREATE OR REPLACE FUNCTION fn_order_event() RETURNS trigger
LANGUAGE plpgsql AS $$
DECLARE
    v_note   text := NULLIF(current_setting('app.event_note', true), '');
    v_type   text;
BEGIN
    IF TG_TABLE_NAME = 'orders' THEN
        IF TG_OP = 'INSERT' THEN
            v_type := 'Order Pending'; v_note := COALESCE(v_note, 'Order placed');
        ELSIF NEW.order_status <> OLD.order_status THEN
            v_type := 'Order ' || NEW.order_status;
        END IF;
    ELSIF TG_TABLE_NAME = 'payment' THEN
        IF TG_OP = 'UPDATE' AND (NEW.payment_status <> OLD.payment_status
                                 OR NEW.attempts <> OLD.attempts) THEN
            v_type := 'Payment ' || NEW.payment_status;
            IF NEW.payment_status = 'Failed' THEN v_note := COALESCE(NEW.failure_reason, v_note); END IF;
        END IF;
    ELSE  -- shipment
        IF TG_OP = 'INSERT' THEN
            v_type := 'Shipment ' || NEW.shipment_status;
        ELSIF NEW.shipment_status <> OLD.shipment_status THEN
            v_type := 'Shipment ' || NEW.shipment_status;
        END IF;
    END IF;

    IF v_type IS NOT NULL THEN
        INSERT INTO order_event (order_id, event_time, event_type, detail)
        VALUES (NEW.order_id, clock_timestamp()::timestamp, v_type, left(v_note, 200));
    END IF;
    RETURN NULL;
END $$;

DROP TRIGGER IF EXISTS trg_orders_event ON orders;
CREATE TRIGGER trg_orders_event AFTER INSERT OR UPDATE ON orders
FOR EACH ROW EXECUTE FUNCTION fn_order_event();
DROP TRIGGER IF EXISTS trg_payment_event ON payment;
CREATE TRIGGER trg_payment_event AFTER INSERT OR UPDATE ON payment
FOR EACH ROW EXECUTE FUNCTION fn_order_event();
DROP TRIGGER IF EXISTS trg_shipment_event ON shipment;
CREATE TRIGGER trg_shipment_event AFTER INSERT OR UPDATE ON shipment
FOR EACH ROW EXECUTE FUNCTION fn_order_event();

-- ---------------------------------------------------------------------
-- 5. Lifecycle functions
-- ---------------------------------------------------------------------
-- 5a. place_order(customer, address, items, method) -> order_id
--     p_items: JSON array, e.g. [{"product_id": 12, "quantity": 2}, ...]
--     One atomic transaction: validate, lock products IN ID ORDER (two
--     concurrent orders cannot deadlock), check stock, copy the current
--     price into the order line, decrement stock, create the Pending payment.
CREATE OR REPLACE FUNCTION place_order(
    p_customer_id bigint, p_address_id bigint, p_items jsonb, p_method varchar)
RETURNS bigint
LANGUAGE plpgsql AS $$
DECLARE
    v_order_id bigint;
    v_line     record;
    v_price    numeric;
    v_stock    integer;
    v_active   boolean;
    v_total    numeric;
BEGIN
    IF NOT EXISTS (SELECT 1 FROM customer WHERE customer_id = p_customer_id) THEN
        RAISE EXCEPTION 'Customer % not found', p_customer_id USING ERRCODE = 'ORD01';
    END IF;
    IF NOT EXISTS (SELECT 1 FROM address WHERE address_id = p_address_id AND customer_id = p_customer_id) THEN
        RAISE EXCEPTION 'Address % does not belong to customer %', p_address_id, p_customer_id
            USING ERRCODE = 'ORD02';
    END IF;
    IF p_items IS NULL OR jsonb_typeof(p_items) <> 'array' OR jsonb_array_length(p_items) = 0 THEN
        RAISE EXCEPTION 'An order needs at least one item' USING ERRCODE = 'ORD03';
    END IF;
    IF p_method IS NULL OR p_method NOT IN ('UPI', 'Credit Card', 'Debit Card', 'Net Banking', 'Wallet') THEN
        RAISE EXCEPTION 'Unsupported payment method: %', COALESCE(p_method, 'NULL') USING ERRCODE = 'ORD03';
    END IF;

    INSERT INTO orders (customer_id, address_id) VALUES (p_customer_id, p_address_id)
    RETURNING order_id INTO v_order_id;

    FOR v_line IN
        SELECT product_id, SUM(quantity)::int AS quantity            -- same product listed twice = one line
        FROM  (SELECT (e->>'product_id')::bigint AS product_id, (e->>'quantity')::int AS quantity
               FROM jsonb_array_elements(p_items) AS e) x
        GROUP BY product_id
        ORDER BY product_id
    LOOP
        IF v_line.product_id IS NULL OR v_line.quantity IS NULL OR v_line.quantity <= 0 THEN
            RAISE EXCEPTION 'Each item needs a product_id and a quantity greater than 0'
                USING ERRCODE = 'ORD03';
        END IF;

        SELECT price, quantity_in_stock, is_active INTO v_price, v_stock, v_active
        FROM   product WHERE product_id = v_line.product_id FOR UPDATE;
        IF NOT FOUND THEN
            RAISE EXCEPTION 'Product % not found', v_line.product_id USING ERRCODE = 'ORD04';
        END IF;
        IF NOT v_active THEN
            RAISE EXCEPTION 'Product % is no longer available', v_line.product_id USING ERRCODE = 'ORD05';
        END IF;
        IF v_stock < v_line.quantity THEN
            RAISE EXCEPTION 'Only % unit(s) of product % in stock (requested %)',
                            v_stock, v_line.product_id, v_line.quantity USING ERRCODE = 'ORD06';
        END IF;

        INSERT INTO order_item (order_id, product_id, quantity, unit_price)       -- subtotal is GENERATED
        VALUES (v_order_id, v_line.product_id, v_line.quantity, v_price);
        UPDATE product SET quantity_in_stock = quantity_in_stock - v_line.quantity
        WHERE  product_id = v_line.product_id;
    END LOOP;

    SELECT total_amount INTO v_total FROM orders WHERE order_id = v_order_id;   -- kept by trigger 4a
    INSERT INTO payment (order_id, payment_method, amount) VALUES (v_order_id, p_method, v_total);
    RETURN v_order_id;
END $$;

-- 5b. begin_payment: lock the order, check it can be paid, return the amount to charge.
--     The row lock is held until the transaction ends, so a cancel cannot slip in
--     between the gateway charge and record_payment.
CREATE OR REPLACE FUNCTION begin_payment(
    p_order_id bigint, p_customer_id bigint DEFAULT NULL, p_method varchar DEFAULT NULL)
RETURNS numeric
LANGUAGE plpgsql AS $$
DECLARE
    v_status   text;
    v_customer bigint;
    v_pstatus  text;
    v_amount   numeric;
BEGIN
    SELECT order_status, customer_id INTO v_status, v_customer
    FROM orders WHERE order_id = p_order_id FOR UPDATE;
    IF NOT FOUND THEN
        RAISE EXCEPTION 'Order % not found', p_order_id USING ERRCODE = 'ORD08';
    END IF;
    IF p_customer_id IS NOT NULL AND v_customer <> p_customer_id THEN
        RAISE EXCEPTION 'Order % does not belong to customer %', p_order_id, p_customer_id
            USING ERRCODE = 'ORD09';
    END IF;
    IF v_status <> 'Pending' THEN
        RAISE EXCEPTION 'Order % cannot be paid (status %)', p_order_id, v_status USING ERRCODE = 'ORD10';
    END IF;

    SELECT payment_status, amount INTO v_pstatus, v_amount
    FROM payment WHERE order_id = p_order_id FOR UPDATE;
    IF v_pstatus NOT IN ('Pending', 'Failed') THEN
        RAISE EXCEPTION 'Order % has already been paid', p_order_id USING ERRCODE = 'ORD10';
    END IF;

    IF p_method IS NOT NULL THEN
        IF p_method NOT IN ('UPI', 'Credit Card', 'Debit Card', 'Net Banking', 'Wallet') THEN
            RAISE EXCEPTION 'Unsupported payment method: %', p_method USING ERRCODE = 'ORD03';
        END IF;
        UPDATE payment SET payment_method = p_method WHERE order_id = p_order_id;
    END IF;
    RETURN v_amount;
END $$;

-- 5c. record_payment: store the gateway's answer.
--     success: payment Successful, order Confirmed, shipment row created (Pending)
--     failure: payment Failed (the customer may try again), order stays Pending
CREATE OR REPLACE FUNCTION record_payment(
    p_order_id bigint, p_success boolean, p_transaction_ref text, p_failure_reason text DEFAULT NULL)
RETURNS text
LANGUAGE plpgsql AS $$
DECLARE v_status text;
BEGIN
    SELECT order_status INTO v_status FROM orders WHERE order_id = p_order_id FOR UPDATE;
    IF NOT FOUND THEN
        RAISE EXCEPTION 'Order % not found', p_order_id USING ERRCODE = 'ORD08';
    END IF;
    IF v_status <> 'Pending' THEN
        RAISE EXCEPTION 'Order % cannot be paid (status %)', p_order_id, v_status USING ERRCODE = 'ORD10';
    END IF;

    IF p_success THEN
        UPDATE payment
        SET    payment_status = 'Successful', payment_date = LOCALTIMESTAMP,
               transaction_ref = p_transaction_ref, failure_reason = NULL, attempts = attempts + 1
        WHERE  order_id = p_order_id AND payment_status IN ('Pending', 'Failed');
        IF NOT FOUND THEN
            RAISE EXCEPTION 'Order % has already been paid', p_order_id USING ERRCODE = 'ORD10';
        END IF;
        UPDATE orders SET order_status = 'Confirmed' WHERE order_id = p_order_id;
        INSERT INTO shipment (order_id) VALUES (p_order_id) ON CONFLICT (order_id) DO NOTHING;
        RETURN 'Successful';
    END IF;

    UPDATE payment
    SET    payment_status = 'Failed', failure_reason = left(COALESCE(p_failure_reason, 'Payment declined'), 200),
           attempts = attempts + 1
    WHERE  order_id = p_order_id AND payment_status IN ('Pending', 'Failed');
    IF NOT FOUND THEN
        RAISE EXCEPTION 'Order % has already been paid', p_order_id USING ERRCODE = 'ORD10';
    END IF;
    RETURN 'Failed';
END $$;

-- 5d. cancel_order: only before shipping. Restocks, refunds a successful payment,
--     marks an unpaid payment Failed, cancels the shipment placeholder.
--     p_customer_id: pass the caller's id to check ownership; NULL = admin/system.
--     Returns 'CANCELLED' or 'CANCELLED_REFUNDED' (the API then asks the gateway
--     to refund, inside the same transaction).
CREATE OR REPLACE FUNCTION cancel_order(
    p_order_id bigint, p_customer_id bigint DEFAULT NULL, p_reason text DEFAULT NULL)
RETURNS text
LANGUAGE plpgsql AS $$
DECLARE
    v_status   text;
    v_customer bigint;
    v_pstatus  text;
    v_result   text := 'CANCELLED';
BEGIN
    SELECT order_status, customer_id INTO v_status, v_customer
    FROM orders WHERE order_id = p_order_id FOR UPDATE;
    IF NOT FOUND THEN
        RAISE EXCEPTION 'Order % not found', p_order_id USING ERRCODE = 'ORD08';
    END IF;
    IF p_customer_id IS NOT NULL AND v_customer <> p_customer_id THEN
        RAISE EXCEPTION 'Order % does not belong to customer %', p_order_id, p_customer_id
            USING ERRCODE = 'ORD09';
    END IF;
    IF v_status NOT IN ('Pending', 'Confirmed') THEN
        RAISE EXCEPTION 'Order % cannot be cancelled (status %)', p_order_id, v_status
            USING ERRCODE = 'ORD11';
    END IF;

    PERFORM set_config('app.event_note', COALESCE(left(p_reason, 200), 'Cancelled by customer'), true);

    -- give the stock back; products locked in id order (no deadlock between two cancels)
    PERFORM 1 FROM product
    WHERE  product_id IN (SELECT product_id FROM order_item WHERE order_id = p_order_id)
    ORDER  BY product_id FOR UPDATE;
    UPDATE product p
    SET    quantity_in_stock = p.quantity_in_stock + oi.qty
    FROM  (SELECT product_id, SUM(quantity) AS qty FROM order_item
           WHERE order_id = p_order_id GROUP BY product_id) oi
    WHERE  p.product_id = oi.product_id;

    UPDATE orders SET order_status = 'Cancelled', cancelled_at = LOCALTIMESTAMP,
                      cancel_reason = left(p_reason, 200)
    WHERE  order_id = p_order_id;

    SELECT payment_status INTO v_pstatus FROM payment WHERE order_id = p_order_id FOR UPDATE;
    IF v_pstatus = 'Successful' THEN
        UPDATE payment SET payment_status = 'Refunded', refunded_at = LOCALTIMESTAMP
        WHERE order_id = p_order_id;
        v_result := 'CANCELLED_REFUNDED';
    ELSIF v_pstatus = 'Pending' THEN
        UPDATE payment SET payment_status = 'Failed', failure_reason = 'Order cancelled before payment'
        WHERE order_id = p_order_id;
    END IF;

    UPDATE shipment SET shipment_status = 'Cancelled'
    WHERE  order_id = p_order_id AND shipment_status = 'Pending';

    PERFORM set_config('app.event_note', '', true);      -- the note must not leak into later events
    RETURN v_result;
END $$;

-- 5e. advance_shipment(order, new_status[, carrier]):
--     Shipped (sets date, tracking number, order -> Shipped), In Transit,
--     Delivered (sets delivery date, order -> Delivered). The shipment trigger
--     rejects any other jump.
CREATE OR REPLACE FUNCTION advance_shipment(
    p_order_id bigint, p_new_status varchar, p_carrier varchar DEFAULT NULL)
RETURNS text
LANGUAGE plpgsql AS $$
DECLARE
    v_status text;
    v_ship   bigint;
BEGIN
    SELECT order_status INTO v_status FROM orders WHERE order_id = p_order_id FOR UPDATE;
    IF NOT FOUND THEN
        RAISE EXCEPTION 'Order % not found', p_order_id USING ERRCODE = 'ORD08';
    END IF;
    SELECT shipment_id INTO v_ship FROM shipment WHERE order_id = p_order_id FOR UPDATE;
    IF NOT FOUND THEN
        RAISE EXCEPTION 'Order % has no shipment yet (status %)', p_order_id, v_status USING ERRCODE = 'ORD10';
    END IF;

    IF p_new_status = 'Shipped' THEN
        UPDATE shipment
        SET    shipment_status = 'Shipped', shipment_date = LOCALTIMESTAMP,
               carrier = COALESCE(p_carrier, carrier, 'Standard Courier'),
               tracking_number = 'TRK' || lpad(v_ship::text, 9, '0')
        WHERE  shipment_id = v_ship;
        UPDATE orders SET order_status = 'Shipped' WHERE order_id = p_order_id;
    ELSIF p_new_status = 'In Transit' THEN
        UPDATE shipment SET shipment_status = 'In Transit' WHERE shipment_id = v_ship;
    ELSIF p_new_status = 'Delivered' THEN
        UPDATE shipment SET shipment_status = 'Delivered', delivery_date = LOCALTIMESTAMP
        WHERE  shipment_id = v_ship;
        UPDATE orders SET order_status = 'Delivered' WHERE order_id = p_order_id;
    ELSE
        RAISE EXCEPTION 'Shipment status must be Shipped, In Transit or Delivered (got %)', p_new_status
            USING ERRCODE = 'ORD07';
    END IF;
    RETURN p_new_status;
END $$;

-- 5f. expire_unpaid_orders: cancel Pending orders older than p_older_than.
--     Returns how many were cancelled. Meant for a periodic admin call.
CREATE OR REPLACE FUNCTION expire_unpaid_orders(p_older_than interval DEFAULT interval '30 minutes')
RETURNS integer
LANGUAGE plpgsql AS $$
DECLARE
    r record;
    n integer := 0;
BEGIN
    FOR r IN SELECT order_id FROM orders
             WHERE order_status = 'Pending' AND order_date < LOCALTIMESTAMP - p_older_than
             ORDER BY order_id FOR UPDATE SKIP LOCKED
    LOOP
        PERFORM cancel_order(r.order_id, NULL, 'Payment not received in time');
        n := n + 1;
    END LOOP;
    RETURN n;
END $$;

-- ---------------------------------------------------------------------
-- 6. Views
-- ---------------------------------------------------------------------
-- REVENUE = orders whose payment was Successful. A refunded payment is no longer
-- 'Successful', so cancelled-and-refunded orders drop out by themselves.
-- The admin dashboard should read revenue from this view.
DROP VIEW IF EXISTS v_paid_orders;
CREATE VIEW v_paid_orders AS
SELECT o.order_id, o.customer_id, o.order_date, o.order_status, o.total_amount,
       p.payment_id, p.payment_method, p.payment_date, p.amount AS paid_amount
FROM   orders o
JOIN   payment p ON p.order_id = o.order_id
WHERE  p.payment_status = 'Successful';

DROP VIEW IF EXISTS v_order_summary;
CREATE VIEW v_order_summary AS
SELECT o.order_id, o.customer_id, o.order_date, o.order_status, o.total_amount,
       (SELECT COUNT(*)::int FROM order_item oi WHERE oi.order_id = o.order_id) AS item_count,
       p.payment_status, p.payment_method,
       s.shipment_status, s.tracking_number
FROM   orders o
LEFT   JOIN payment  p ON p.order_id = o.order_id
LEFT   JOIN shipment s ON s.order_id = o.order_id;

COMMIT;
