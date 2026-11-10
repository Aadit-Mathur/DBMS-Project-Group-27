-- =====================================================================
-- Remove ALL order data and give the stock back.  Dev/testing only.
--   python db_testing/run_sql.py db_testing/reset_order_data.sql
-- Stock held by orders that were not cancelled is added back to product,
-- then orders, order_item, payment, shipment and order_event are emptied
-- and their ids restart at 1. Customers, sellers and products are kept.
-- Works on the earlier draft too (order_event may not exist yet).
-- =====================================================================
BEGIN;
DO $$
DECLARE restored int; t text;
BEGIN
  UPDATE product p SET quantity_in_stock = p.quantity_in_stock + x.q
  FROM (SELECT oi.product_id, SUM(oi.quantity) AS q
        FROM order_item oi JOIN orders o USING (order_id)
        WHERE o.order_status <> 'Cancelled' GROUP BY oi.product_id) x
  WHERE p.product_id = x.product_id;
  GET DIAGNOSTICS restored = ROW_COUNT;
  RAISE NOTICE 'stock restored on % products', restored;

  FOREACH t IN ARRAY ARRAY['order_event','payment','shipment','order_item','orders'] LOOP
    IF to_regclass('public.' || t) IS NOT NULL THEN
      EXECUTE format('TRUNCATE TABLE %I RESTART IDENTITY CASCADE', t);
    END IF;
  END LOOP;
END $$;
COMMIT;
SELECT (SELECT count(*) FROM orders) AS orders_left, (SELECT count(*) FROM product) AS products_kept;
