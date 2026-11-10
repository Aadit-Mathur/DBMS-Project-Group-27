-- =====================================================================
-- Sample orders: 300 orders through the real lifecycle functions
--   python db_testing/run_sql.py Populate_DB/orders_seed.sql
-- Run AFTER db_testing/order_schema.sql. Refuses to run if orders is not
-- empty (use db_testing/reset_order_data.sql first). One transaction.
-- Every order is made by place_order / begin_payment / record_payment /
-- advance_shipment / cancel_order, so totals, prices, stock, statuses,
-- payments and timelines are consistent. Dates are then spread over the
-- last 90 days. This REDUCES product stock, as real orders do.
-- Mix: ~6% pending, ~6% payment failed (retry possible), ~8% cancelled
-- unpaid, ~6% paid then cancelled + refunded, ~16% confirmed,
-- ~18% shipped, ~12% in transit, ~28% delivered.
-- =====================================================================
BEGIN;
DO $$
DECLARE
  i int; v_cust bigint; v_addr bigint; v_oid bigint; v_n int; v_items jsonb; r numeric;
  v_method text; v_made int := 0;
BEGIN
  IF EXISTS (SELECT 1 FROM orders) THEN
    RAISE EXCEPTION 'orders is not empty. Run db_testing/reset_order_data.sql first.';
  END IF;

  FOR i IN 1..300 LOOP
    SELECT customer_id, address_id INTO v_cust, v_addr FROM address ORDER BY random() LIMIT 1;
    v_n := 1 + floor(random() * 3)::int;
    SELECT jsonb_agg(jsonb_build_object('product_id', product_id, 'quantity', 1 + floor(random() * 3)::int))
    INTO v_items
    FROM (SELECT product_id FROM product WHERE is_active AND quantity_in_stock >= 3
          ORDER BY random() LIMIT v_n) p;
    CONTINUE WHEN v_items IS NULL;                       -- nothing in stock

    v_method := (ARRAY['UPI','Credit Card','Debit Card','Net Banking','Wallet'])[1 + floor(random() * 5)::int];
    v_oid := place_order(v_cust, v_addr, v_items, v_method);
    v_made := v_made + 1;

    r := random();
    IF r < 0.06 THEN
      NULL;                                                                   -- Pending, unpaid
    ELSIF r < 0.12 THEN
      PERFORM begin_payment(v_oid, v_cust);
      PERFORM record_payment(v_oid, false, NULL, 'Card declined by bank');    -- Failed, still Pending
    ELSIF r < 0.20 THEN
      PERFORM cancel_order(v_oid, v_cust, 'Cancelled by customer');           -- cancelled, never paid
    ELSE
      IF random() < 0.3 THEN                                                  -- first attempt declined, retry works
        PERFORM begin_payment(v_oid, v_cust);
        PERFORM record_payment(v_oid, false, NULL, 'Insufficient funds');
      END IF;
      PERFORM begin_payment(v_oid, v_cust);
      PERFORM record_payment(v_oid, true, 'SIM-' || v_oid || '-' || substr(md5(random()::text), 1, 8));
      IF r < 0.26 THEN
        PERFORM cancel_order(v_oid, v_cust, 'Ordered by mistake');            -- paid, then cancelled: Refunded
        UPDATE payment SET refund_ref = 'SIMREF-' || v_oid WHERE order_id = v_oid;
      ELSIF r < 0.42 THEN
        NULL;                                                                 -- Confirmed
      ELSE
        PERFORM advance_shipment(v_oid, 'Shipped', (ARRAY['BlueDart','Delhivery','DTDC','Ecom Express'])[1 + floor(random() * 4)::int]);
        IF r < 0.60 THEN NULL;                                                -- Shipped
        ELSIF r < 0.72 THEN PERFORM advance_shipment(v_oid, 'In Transit');    -- In Transit
        ELSE PERFORM advance_shipment(v_oid, 'In Transit'); PERFORM advance_shipment(v_oid, 'Delivered');
        END IF;
      END IF;
    END IF;
  END LOOP;

  -- spread the dates: unpaid-pending orders are recent, all others 5 to 90 days old
  UPDATE orders o SET order_date = LOCALTIMESTAMP - CASE
      WHEN o.order_status = 'Pending' THEN make_interval(mins => 1 + floor(random() * 600)::int)
      ELSE make_interval(days => 5 + floor(random() * 85)::int, hours => floor(random() * 24)::int) END;
  UPDATE orders   SET cancelled_at = order_date + interval '1 hour' WHERE order_status = 'Cancelled';
  UPDATE payment  p SET payment_date = o.order_date + interval '10 minutes' FROM orders o
         WHERE o.order_id = p.order_id AND p.payment_date IS NOT NULL;
  UPDATE payment  SET refunded_at = payment_date + interval '1 hour' WHERE refunded_at IS NOT NULL;
  UPDATE shipment s SET shipment_date = o.order_date + interval '1 day' FROM orders o
         WHERE o.order_id = s.order_id AND s.shipment_date IS NOT NULL;
  UPDATE shipment s SET delivery_date = o.order_date + interval '4 days' FROM orders o
         WHERE o.order_id = s.order_id AND s.delivery_date IS NOT NULL;
  UPDATE order_event e SET event_time = o.order_date + CASE
      WHEN e.event_type = 'Order Pending'                                         THEN interval '0'
      WHEN e.event_type = 'Payment Failed' AND e.detail LIKE 'Order cancelled%'   THEN interval '1 hour'
      WHEN e.event_type = 'Payment Failed'                                        THEN interval '5 minutes'
      WHEN e.event_type IN ('Payment Successful','Order Confirmed','Shipment Pending') THEN interval '10 minutes'
      WHEN e.event_type IN ('Shipment Shipped','Order Shipped')                   THEN interval '1 day'
      WHEN e.event_type = 'Shipment In Transit'                                   THEN interval '2 days'
      WHEN e.event_type IN ('Shipment Delivered','Order Delivered')               THEN interval '4 days'
      ELSE interval '1 hour' END                                                   -- cancel / refund events
  FROM orders o WHERE o.order_id = e.order_id;

  RAISE NOTICE '% orders created', v_made;
END $$;
COMMIT;

SELECT order_status, count(*) AS orders FROM orders GROUP BY order_status ORDER BY orders DESC;
