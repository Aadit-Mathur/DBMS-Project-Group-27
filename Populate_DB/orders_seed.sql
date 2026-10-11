-- =====================================================================
-- Populate_DB/orders_seed.sql   (sample data for orders, order_item, payment, shipment)
-- Run ONCE in the Neon SQL Editor, AFTER db/order_schema.sql.
--
-- Every order is created through place_order() / pay_order() / cancel_order(),
-- so totals, unit prices, stock and statuses are consistent by construction.
-- It is one transaction: if anything fails, nothing is inserted.
-- NOTE: it reduces product.quantity_in_stock (that is what real orders do).
-- Creates 300 orders: ~8% cancelled unpaid, ~6% paid then cancelled (refunded),
-- ~20% unpaid, ~20% confirmed, ~20% shipped, ~26% delivered.
-- =====================================================================
DO $$
DECLARE
  i int; v_cust bigint; v_addr bigint; v_oid bigint; v_n int; v_items jsonb;
  v_odate timestamp; v_ship timestamp; r numeric;
BEGIN
  IF EXISTS (SELECT 1 FROM orders) THEN
    RAISE EXCEPTION 'orders is not empty: seed already ran';
  END IF;

  FOR i IN 1..300 LOOP
    SELECT customer_id, address_id INTO v_cust, v_addr
    FROM address ORDER BY random() LIMIT 1;

    v_n := 1 + floor(random() * 3)::int;                       -- 1 to 3 products
    SELECT jsonb_agg(jsonb_build_object('product_id', product_id,
                                        'quantity', 1 + floor(random() * 3)::int))
    INTO v_items
    FROM (SELECT product_id FROM product
          WHERE quantity_in_stock >= 3                          -- ADD "AND is_active" here if product has that column
          ORDER BY random() LIMIT v_n) p;
    CONTINUE WHEN v_items IS NULL;                              -- no product with enough stock

    v_oid := place_order(v_cust, v_addr, v_items,
              (ARRAY['UPI','Credit Card','Debit Card','Net Banking','Cash on Delivery'])
              [1 + floor(random() * 5)::int]);

    -- order placed 5 to 90 days ago; later dates are derived from it
    v_odate := (now() - make_interval(days => 5 + floor(random() * 85)::int,
                                      hours => floor(random() * 24)::int))::timestamp;
    UPDATE orders SET order_date = v_odate WHERE order_id = v_oid;

    r := random();
    IF r < 0.08 THEN
      PERFORM cancel_order(v_oid);                              -- cancelled, never paid
    ELSIF r < 0.14 THEN
      PERFORM pay_order(v_oid);
      UPDATE payment SET payment_date = v_odate + interval '1 hour' WHERE order_id = v_oid;
      PERFORM cancel_order(v_oid);                              -- paid, then cancelled: Refunded
    ELSIF r < 0.34 THEN
      NULL;                                                     -- stays Pending, unpaid
    ELSE
      PERFORM pay_order(v_oid);
      UPDATE payment SET payment_date = v_odate + interval '1 hour' WHERE order_id = v_oid;
      IF r < 0.54 THEN
        NULL;                                                   -- Confirmed, shipment Pending
      ELSIF r < 0.74 THEN
        UPDATE shipment SET shipment_status = 'Shipped', shipment_date = v_odate + interval '1 day'
        WHERE order_id = v_oid;
        UPDATE orders SET order_status = 'Shipped' WHERE order_id = v_oid;
      ELSE
        v_ship := v_odate + interval '1 day';
        UPDATE shipment SET shipment_status = 'Delivered', shipment_date = v_ship,
                            delivery_date = v_ship + interval '3 days'
        WHERE order_id = v_oid;
        UPDATE orders SET order_status = 'Delivered' WHERE order_id = v_oid;
      END IF;
    END IF;
  END LOOP;
END $$;
