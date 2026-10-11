-- db/tests/order_smoke_test.sql: places, pays and cancels one order, reports the result as an error and rolls everything back.
-- Run in the Neon SQL Editor after db/order_schema.sql. Nothing is saved.
DO $$
DECLARE
  v_pid bigint; v_price numeric; v_stock0 int; v_cust bigint; v_addr bigint;
  v_oid bigint; v_total numeric; v_stock1 int; v_stock2 int; v_msg text;
BEGIN
  SELECT product_id, price, quantity_in_stock INTO v_pid, v_price, v_stock0
  FROM product WHERE quantity_in_stock >= 3 ORDER BY product_id LIMIT 1;
  SELECT customer_id, address_id INTO v_cust, v_addr FROM address ORDER BY address_id LIMIT 1;

  v_oid := place_order(v_cust, v_addr,
             jsonb_build_array(jsonb_build_object('product_id', v_pid, 'quantity', 2)), 'UPI');
  SELECT total_amount INTO v_total FROM orders WHERE order_id = v_oid;
  SELECT quantity_in_stock INTO v_stock1 FROM product WHERE product_id = v_pid;
  v_msg := format('place: total=%s (expected %s), stock %s -> %s', v_total, v_price*2, v_stock0, v_stock1);

  PERFORM pay_order(v_oid);
  v_msg := v_msg || format(' | pay: order=%s payment=%s shipment=%s',
    (SELECT order_status FROM orders WHERE order_id=v_oid),
    (SELECT payment_status FROM payment WHERE order_id=v_oid),
    (SELECT shipment_status FROM shipment WHERE order_id=v_oid));

  PERFORM cancel_order(v_oid);
  SELECT quantity_in_stock INTO v_stock2 FROM product WHERE product_id = v_pid;
  v_msg := v_msg || format(' | cancel: order=%s payment=%s stock back to %s',
    (SELECT order_status FROM orders WHERE order_id=v_oid),
    (SELECT payment_status FROM payment WHERE order_id=v_oid), v_stock2);

  RAISE EXCEPTION 'SMOKE TEST (rolled back, nothing saved): %', v_msg;   -- the error is the report
END $$;
