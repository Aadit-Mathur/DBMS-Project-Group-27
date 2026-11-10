-- =====================================================================
-- Ordering module: SQL tests (constraints, triggers, lifecycle functions)
--
-- Run:  python db_testing/run_sql.py db_testing/tests/order_constraint_tests.sql
--
-- Safe on any database that has the schema: the tests create their own
-- customers, sellers and products, and EVERYTHING is rolled back at the end
-- (nothing is left behind and real stock is untouched).
-- Output: one "PASS name" notice per check, then "ALL TESTS PASSED".
-- If any check fails the script stops with "FAILED n of m: <names>".
-- =====================================================================
DO $test$
DECLARE
    s        record;
    ctx      jsonb := '{}';
    k        text;
    q        text;
    val      text;
    b        boolean;
    n_pass   int := 0;
    n_fail   int := 0;
    failed   text := '';
    got      text;
BEGIN
  BEGIN   -- everything in here is rolled back by the exception raised at the end
    FOR s IN
      SELECT * FROM (VALUES
        -- ---------- fixtures --------------------------------------------------
        (  1,'set','c1',  $q$INSERT INTO customer(name,email,phone) VALUES ('T One','ordtest_'||md5(random()::text)||'@t.com','9'||lpad((random()*1e9)::bigint::text,9,'0')) RETURNING customer_id$q$, ''),
        (  2,'set','c2',  $q$INSERT INTO customer(name,email,phone) VALUES ('T Two','ordtest_'||md5(random()::text)||'@t.com','9'||lpad((random()*1e9)::bigint::text,9,'0')) RETURNING customer_id$q$, ''),
        (  3,'set','a1',  $q$INSERT INTO address(customer_id,address_type,house_no,street,locality,city,district,state,pin_code) VALUES ({c1},'Home','1','S','L','C','D','ST','560001') RETURNING address_id$q$, ''),
        (  4,'set','a2',  $q$INSERT INTO address(customer_id,address_type,house_no,street,locality,city,district,state,pin_code) VALUES ({c2},'Home','2','S','L','C','D','ST','560002') RETURNING address_id$q$, ''),
        (  5,'set','sl',  $q$INSERT INTO seller(name,email,phone) VALUES ('T Seller','ordtest_'||md5(random()::text)||'@t.com','8'||lpad((random()*1e9)::bigint::text,9,'0')) RETURNING seller_id$q$, ''),
        (  6,'set','cat', $q$INSERT INTO category(category_name) VALUES ('ordtest_'||md5(random()::text)) RETURNING category_id$q$, ''),
        (  7,'set','p1',  $q$INSERT INTO product(seller_id,category_id,product_name,price,quantity_in_stock) VALUES ({sl},{cat},'T p1',100,10) RETURNING product_id$q$, ''),
        (  8,'set','p2',  $q$INSERT INTO product(seller_id,category_id,product_name,price,quantity_in_stock) VALUES ({sl},{cat},'T p2',250,5) RETURNING product_id$q$, ''),
        (  9,'set','p3',  $q$INSERT INTO product(seller_id,category_id,product_name,price,quantity_in_stock,is_active) VALUES ({sl},{cat},'T p3 inactive',10,5,false) RETURNING product_id$q$, ''),
        ( 10,'set','p4',  $q$INSERT INTO product(seller_id,category_id,product_name,price,quantity_in_stock) VALUES ({sl},{cat},'T p4',50,2) RETURNING product_id$q$, ''),

        -- ---------- place_order: happy path -----------------------------------
        ( 20,'set','o1',  $q$SELECT place_order({c1},{a1},'[{"product_id":{p1},"quantity":2},{"product_id":{p2},"quantity":1}]'::jsonb,'UPI')$q$, ''),
        ( 21,'ok','place: status Pending',            $q$(SELECT order_status FROM orders WHERE order_id={o1})='Pending'$q$, ''),
        ( 22,'ok','place: total maintained by trigger (2x100 + 1x250 = 450)', $q$(SELECT total_amount FROM orders WHERE order_id={o1})=450$q$, ''),
        ( 23,'ok','place: stock decremented (p1 10->8, p2 5->4)', $q$(SELECT quantity_in_stock FROM product WHERE product_id={p1})=8 AND (SELECT quantity_in_stock FROM product WHERE product_id={p2})=4$q$, ''),
        ( 24,'ok','place: two order lines, generated subtotals add up', $q$(SELECT count(*) FROM order_item WHERE order_id={o1})=2 AND (SELECT sum(subtotal) FROM order_item WHERE order_id={o1})=450$q$, ''),
        ( 25,'ok','place: Pending payment row with amount and method', $q$EXISTS (SELECT 1 FROM payment WHERE order_id={o1} AND payment_status='Pending' AND amount=450 AND payment_method='UPI' AND attempts=0 AND payment_date IS NULL)$q$, ''),
        ( 26,'ok','place: timeline has "Order Pending"', $q$EXISTS (SELECT 1 FROM order_event WHERE order_id={o1} AND event_type='Order Pending')$q$, ''),
        ( 27,'run','price change after ordering',      $q$UPDATE product SET price=999 WHERE product_id={p1}$q$, ''),
        ( 28,'ok','place: order line keeps the price at order time (100, not 999)', $q$(SELECT unit_price FROM order_item WHERE order_id={o1} AND product_id={p1})=100$q$, ''),
        ( 29,'run','restore price',                    $q$UPDATE product SET price=100 WHERE product_id={p1}$q$, ''),

        -- ---------- place_order: validation ----------------------------------
        ( 30,'err','place: unknown customer -> ORD01', $q$SELECT place_order(-1,{a1},'[{"product_id":{p1},"quantity":1}]'::jsonb,'UPI')$q$, 'ORD01'),
        ( 31,'err','place: address of another customer -> ORD02', $q$SELECT place_order({c1},{a2},'[{"product_id":{p1},"quantity":1}]'::jsonb,'UPI')$q$, 'ORD02'),
        ( 32,'err','place: empty item list -> ORD03', $q$SELECT place_order({c1},{a1},'[]'::jsonb,'UPI')$q$, 'ORD03'),
        ( 33,'err','place: quantity 0 -> ORD03',       $q$SELECT place_order({c1},{a1},'[{"product_id":{p1},"quantity":0}]'::jsonb,'UPI')$q$, 'ORD03'),
        ( 34,'err','place: negative quantity -> ORD03',$q$SELECT place_order({c1},{a1},'[{"product_id":{p1},"quantity":-2}]'::jsonb,'UPI')$q$, 'ORD03'),
        ( 35,'err','place: unsupported payment method -> ORD03', $q$SELECT place_order({c1},{a1},'[{"product_id":{p1},"quantity":1}]'::jsonb,'Bitcoin')$q$, 'ORD03'),
        ( 36,'err','place: items not an array -> ORD03', $q$SELECT place_order({c1},{a1},'{"product_id":1}'::jsonb,'UPI')$q$, 'ORD03'),
        ( 37,'err','place: unknown product -> ORD04',  $q$SELECT place_order({c1},{a1},'[{"product_id":999999999,"quantity":1}]'::jsonb,'UPI')$q$, 'ORD04'),
        ( 38,'err','place: delisted product -> ORD05', $q$SELECT place_order({c1},{a1},'[{"product_id":{p3},"quantity":1}]'::jsonb,'UPI')$q$, 'ORD05'),
        ( 39,'err','place: not enough stock -> ORD06', $q$SELECT place_order({c1},{a1},'[{"product_id":{p4},"quantity":3}]'::jsonb,'UPI')$q$, 'ORD06'),
        ( 40,'err','place: second item short of stock fails the WHOLE order -> ORD06', $q$SELECT place_order({c1},{a1},'[{"product_id":{p1},"quantity":1},{"product_id":{p4},"quantity":3}]'::jsonb,'UPI')$q$, 'ORD06'),
        ( 41,'ok','atomic: failed order left stock of p1 untouched (still 8)', $q$(SELECT quantity_in_stock FROM product WHERE product_id={p1})=8$q$, ''),
        ( 42,'ok','atomic: failed orders left no order rows behind', $q$(SELECT count(*) FROM orders WHERE customer_id={c1})=1$q$, ''),
        ( 43,'set','o2',  $q$SELECT place_order({c1},{a1},'[{"product_id":{p1},"quantity":1},{"product_id":{p1},"quantity":2}]'::jsonb,'Wallet')$q$, ''),
        ( 44,'ok','place: same product listed twice becomes one line of 3', $q$(SELECT count(*) FROM order_item WHERE order_id={o2})=1 AND (SELECT quantity FROM order_item WHERE order_id={o2})=3$q$, ''),

        -- ---------- payment ---------------------------------------------------
        ( 50,'err','pay: unknown order -> ORD08',      $q$SELECT begin_payment(999999999)$q$, 'ORD08'),
        ( 51,'err','pay: another customer''s order -> ORD09', $q$SELECT begin_payment({o1},{c2})$q$, 'ORD09'),
        ( 52,'err','pay: unsupported method -> ORD03', $q$SELECT begin_payment({o1},{c1},'Bitcoin')$q$, 'ORD03'),
        ( 53,'ok','pay: begin_payment returns the amount to charge (450)', $q$begin_payment({o1},{c1},'Credit Card')=450$q$, ''),
        ( 54,'ok','pay: method changed to the one chosen at payment time', $q$(SELECT payment_method FROM payment WHERE order_id={o1})='Credit Card'$q$, ''),
        ( 55,'ok','pay: declined -> record_payment returns Failed', $q$record_payment({o1},false,NULL,'Card declined')='Failed'$q$, ''),
        ( 56,'ok','pay: declined -> payment Failed, attempts 1, reason stored, order still Pending', $q$EXISTS (SELECT 1 FROM payment p JOIN orders o USING(order_id) WHERE order_id={o1} AND payment_status='Failed' AND attempts=1 AND failure_reason='Card declined' AND order_status='Pending')$q$, ''),
        ( 57,'ok','pay: declined -> no shipment yet',  $q$NOT EXISTS (SELECT 1 FROM shipment WHERE order_id={o1})$q$, ''),
        ( 58,'ok','pay: declined order is NOT counted as revenue', $q$NOT EXISTS (SELECT 1 FROM v_paid_orders WHERE order_id={o1})$q$, ''),
        ( 59,'ok','pay: retry allowed after a failure', $q$begin_payment({o1},{c1})=450$q$, ''),
        ( 60,'ok','pay: retry succeeds -> Successful', $q$record_payment({o1},true,'SIM-TEST-1')='Successful'$q$, ''),
        ( 61,'ok','pay: order Confirmed',              $q$(SELECT order_status FROM orders WHERE order_id={o1})='Confirmed'$q$, ''),
        ( 62,'ok','pay: payment Successful with date, gateway ref, 2 attempts', $q$EXISTS (SELECT 1 FROM payment WHERE order_id={o1} AND payment_status='Successful' AND payment_date IS NOT NULL AND transaction_ref='SIM-TEST-1' AND attempts=2 AND failure_reason IS NULL)$q$, ''),
        ( 63,'ok','pay: shipment created in Pending',  $q$(SELECT shipment_status FROM shipment WHERE order_id={o1})='Pending'$q$, ''),
        ( 64,'err','pay: paying twice -> ORD10',       $q$SELECT begin_payment({o1},{c1})$q$, 'ORD10'),
        ( 65,'err','pay: recording a second result -> ORD10', $q$SELECT record_payment({o1},true,'again')$q$, 'ORD10'),
        ( 66,'ok','revenue: paid order is in v_paid_orders', $q$EXISTS (SELECT 1 FROM v_paid_orders WHERE order_id={o1} AND paid_amount=450)$q$, ''),
        ( 67,'ok','revenue: unpaid order is not in v_paid_orders', $q$NOT EXISTS (SELECT 1 FROM v_paid_orders WHERE order_id={o2})$q$, ''),

        -- ---------- cancel (unpaid) -------------------------------------------
        ( 70,'err','cancel: another customer''s order -> ORD09', $q$SELECT cancel_order({o2},{c2})$q$, 'ORD09'),
        ( 71,'ok','cancel unpaid order returns CANCELLED', $q$cancel_order({o2},{c1},'changed my mind')='CANCELLED'$q$, ''),
        ( 72,'ok','cancel: stock given back (p1 back to 8)', $q$(SELECT quantity_in_stock FROM product WHERE product_id={p1})=8$q$, ''),
        ( 73,'ok','cancel: order Cancelled with time and reason', $q$EXISTS (SELECT 1 FROM orders WHERE order_id={o2} AND order_status='Cancelled' AND cancelled_at IS NOT NULL AND cancel_reason='changed my mind')$q$, ''),
        ( 74,'ok','cancel: unpaid payment closed as Failed', $q$EXISTS (SELECT 1 FROM payment WHERE order_id={o2} AND payment_status='Failed' AND payment_date IS NULL AND refunded_at IS NULL)$q$, ''),
        ( 75,'ok','cancel: timeline records the reason', $q$EXISTS (SELECT 1 FROM order_event WHERE order_id={o2} AND event_type='Order Cancelled' AND detail='changed my mind')$q$, ''),
        ( 76,'err','cancel: already cancelled -> ORD11', $q$SELECT cancel_order({o2},{c1})$q$, 'ORD11'),
        ( 77,'err','pay: cancelled order cannot be paid -> ORD10', $q$SELECT begin_payment({o2},{c1})$q$, 'ORD10'),

        -- ---------- direct tampering is blocked by the database ---------------
        ( 80,'err','flow: Confirmed -> Delivered not allowed -> ORD07', $q$UPDATE orders SET order_status='Delivered' WHERE order_id={o1}$q$, 'ORD07'),
        ( 81,'err','flow: Confirmed -> Pending not allowed -> ORD07',   $q$UPDATE orders SET order_status='Pending' WHERE order_id={o1}$q$, 'ORD07'),
        ( 82,'err','total_amount cannot be edited by hand -> ORD13',    $q$UPDATE orders SET total_amount=1 WHERE order_id={o1}$q$, 'ORD13'),
        ( 83,'err','order cannot be moved to another customer -> ORD13',$q$UPDATE orders SET customer_id={c2} WHERE order_id={o1}$q$, 'ORD13'),
        ( 84,'err','order line cannot be edited -> ORD12',  $q$UPDATE order_item SET quantity=9 WHERE order_id={o1}$q$, 'ORD12'),
        ( 85,'err','order line cannot be deleted -> ORD12', $q$DELETE FROM order_item WHERE order_id={o1}$q$, 'ORD12'),
        ( 86,'err','items cannot be added to a placed order -> ORD12', $q$INSERT INTO order_item(order_id,product_id,quantity,unit_price) VALUES ({o1},{p4},1,50)$q$, 'ORD12'),
        ( 87,'err','payment Successful -> Pending not allowed -> ORD07', $q$UPDATE payment SET payment_status='Pending' WHERE order_id={o1}$q$, 'ORD07'),
        ( 88,'err','payment Successful -> Failed not allowed -> ORD07',  $q$UPDATE payment SET payment_status='Failed' WHERE order_id={o1}$q$, 'ORD07'),
        ( 89,'set','o3',  $q$SELECT place_order({c1},{a1},'[{"product_id":{p4},"quantity":1}]'::jsonb,'UPI')$q$, ''),
        ( 90,'err','CHECK: quantity 0 on an order line -> 23514', $q$INSERT INTO order_item(order_id,product_id,quantity,unit_price) VALUES ({o3},{p4},0,50)$q$, '23514'),
        ( 91,'err','CHECK: negative unit price -> 23514', $q$INSERT INTO order_item(order_id,product_id,quantity,unit_price) VALUES ({o3},{p4},1,-5)$q$, '23514'),
        ( 92,'err','generated subtotal cannot be written -> 428C9', $q$INSERT INTO order_item(order_id,product_id,quantity,unit_price,subtotal) VALUES ({o3},{p4},1,50,1)$q$, '428C9'),
        ( 93,'err','FK: delivery address must belong to the customer -> 23503', $q$INSERT INTO orders(customer_id,address_id) VALUES ({c1},{a2})$q$, '23503'),
        ( 94,'err','CHECK: Successful payment needs a payment date -> 23514', $q$UPDATE payment SET payment_status='Successful', payment_date=NULL WHERE order_id={o3}$q$, '23514'),
        ( 95,'err','CHECK: negative amount -> 23514',   $q$UPDATE payment SET amount=-5 WHERE order_id={o3}$q$, '23514'),
        ( 96,'err','CHECK: unknown payment method -> 23514', $q$UPDATE payment SET payment_method='Bitcoin' WHERE order_id={o3}$q$, '23514'),
        ( 97,'err','UNIQUE: one payment per order -> 23505', $q$INSERT INTO payment(order_id,payment_method,amount) VALUES ({o1},'UPI',1)$q$, '23505'),
        ( 98,'err','CHECK: stock cannot go below 0 -> 23514', $q$UPDATE product SET quantity_in_stock=-1 WHERE product_id={p4}$q$, '23514'),
        ( 99,'err','FK: an ordered product cannot be deleted (delist instead)', $q$DELETE FROM product WHERE product_id={p1}$q$, '23001|23503'),

        -- ---------- shipment: Pending > Shipped > In Transit > Delivered ------
        (100,'err','ship: Pending -> Delivered is a jump -> ORD07', $q$SELECT advance_shipment({o1},'Delivered')$q$, 'ORD07'),
        (101,'err','ship: unknown status -> ORD07',     $q$SELECT advance_shipment({o1},'Teleported')$q$, 'ORD07'),
        (102,'err','ship: unpaid order has no shipment -> ORD10', $q$SELECT advance_shipment({o3},'Shipped')$q$, 'ORD10'),
        (103,'ok','ship: Shipped', $q$advance_shipment({o1},'Shipped','BlueDart')='Shipped'$q$, ''),
        (104,'ok','ship: dispatch date, carrier and tracking number set; order Shipped', $q$EXISTS (SELECT 1 FROM shipment s JOIN orders o USING(order_id) WHERE order_id={o1} AND shipment_status='Shipped' AND shipment_date IS NOT NULL AND carrier='BlueDart' AND tracking_number LIKE 'TRK%' AND order_status='Shipped')$q$, ''),
        (105,'err','cancel: shipped order cannot be cancelled -> ORD11', $q$SELECT cancel_order({o1},{c1})$q$, 'ORD11'),
        (106,'ok','ship: In Transit', $q$advance_shipment({o1},'In Transit')='In Transit'$q$, ''),
        (107,'ok','ship: Delivered', $q$advance_shipment({o1},'Delivered')='Delivered'$q$, ''),
        (108,'ok','ship: delivery date set; order Delivered', $q$EXISTS (SELECT 1 FROM shipment s JOIN orders o USING(order_id) WHERE order_id={o1} AND shipment_status='Delivered' AND delivery_date IS NOT NULL AND delivery_date>=shipment_date AND order_status='Delivered')$q$, ''),
        (109,'err','ship: Delivered cannot go backwards -> ORD07', $q$SELECT advance_shipment({o1},'In Transit')$q$, 'ORD07'),
        (110,'err','cancel: delivered order cannot be cancelled -> ORD11', $q$SELECT cancel_order({o1},{c1})$q$, 'ORD11'),
        (111,'ok','timeline of o1 is complete and in order', $q$ARRAY(SELECT event_type::text FROM order_event WHERE order_id={o1} ORDER BY event_id) = ARRAY['Order Pending','Payment Failed','Payment Successful','Order Confirmed','Shipment Pending','Shipment Shipped','Order Shipped','Shipment In Transit','Shipment Delivered','Order Delivered']$q$, ''),

        -- ---------- cancel after payment: refund --------------------------------
        (120,'set','o4',  $q$SELECT place_order({c1},{a1},'[{"product_id":{p2},"quantity":2}]'::jsonb,'Net Banking')$q$, ''),
        (121,'run','pay o4',  $q$SELECT begin_payment({o4},{c1})$q$, ''),
        (122,'run','pay o4 ok', $q$SELECT record_payment({o4},true,'SIM-TEST-4')$q$, ''),
        (123,'ok','refund: stock p2 is 2 before the cancel (5 - 1 - 2)', $q$(SELECT quantity_in_stock FROM product WHERE product_id={p2})=2$q$, ''),
        (124,'ok','refund: cancelling a paid order returns CANCELLED_REFUNDED', $q$cancel_order({o4},{c1},'wrong item')='CANCELLED_REFUNDED'$q$, ''),
        (125,'ok','refund: payment Refunded, date and refund time kept', $q$EXISTS (SELECT 1 FROM payment WHERE order_id={o4} AND payment_status='Refunded' AND payment_date IS NOT NULL AND refunded_at IS NOT NULL)$q$, ''),
        (126,'ok','refund: shipment placeholder Cancelled', $q$(SELECT shipment_status FROM shipment WHERE order_id={o4})='Cancelled'$q$, ''),
        (127,'ok','refund: stock given back (p2 back to 4)', $q$(SELECT quantity_in_stock FROM product WHERE product_id={p2})=4$q$, ''),
        (128,'ok','refund: refunded order is NOT revenue', $q$NOT EXISTS (SELECT 1 FROM v_paid_orders WHERE order_id={o4})$q$, ''),
        (129,'ok','refund: timeline shows payment refunded, order and shipment cancelled', $q$(SELECT count(*) FROM order_event WHERE order_id={o4} AND event_type IN ('Payment Refunded','Order Cancelled','Shipment Cancelled'))=3$q$, ''),
        (130,'err','refund: Refunded -> Successful not allowed -> ORD07', $q$UPDATE payment SET payment_status='Successful' WHERE order_id={o4}$q$, 'ORD07'),
        (131,'err','refund: cancelled shipment cannot be revived -> ORD07', $q$UPDATE shipment SET shipment_status='Shipped' WHERE order_id={o4}$q$, 'ORD07'),
        (132,'ok','revenue: of o1..o4 only the delivered, paid o1 counts', $q$(SELECT array_agg(order_id) FROM v_paid_orders WHERE order_id IN ({o1},{o2},{o3},{o4}))=ARRAY[{o1}]::bigint[]$q$, ''),

        -- ---------- expiry of unpaid orders --------------------------------------
        (140,'run','age o3 by 3 hours', $q$UPDATE orders SET order_date = LOCALTIMESTAMP - interval '3 hours' WHERE order_id={o3}$q$, ''),
        (141,'set','o5',  $q$SELECT place_order({c1},{a1},'[{"product_id":{p4},"quantity":1}]'::jsonb,'UPI')$q$, ''),
        (142,'ok','expiry: cancels at least the old unpaid order', $q$expire_unpaid_orders(interval '30 minutes')>=1$q$, ''),
        (143,'ok','expiry: old unpaid order Cancelled with reason', $q$EXISTS (SELECT 1 FROM orders WHERE order_id={o3} AND order_status='Cancelled' AND cancel_reason='Payment not received in time')$q$, ''),
        (144,'ok','expiry: fresh unpaid order left alone', $q$(SELECT order_status FROM orders WHERE order_id={o5})='Pending'$q$, ''),
        (145,'ok','expiry: stock of expired order given back (p4: 2 - 1 held by o5 = 1)', $q$(SELECT quantity_in_stock FROM product WHERE product_id={p4})=1$q$, '')
      ) AS v(i, kind, name, sql, expect)
      ORDER BY i
    LOOP
      q := s.sql;
      FOR k IN SELECT jsonb_object_keys(ctx) LOOP
        q := replace(q, '{' || k || '}', ctx ->> k);
      END LOOP;

      IF s.kind = 'set' THEN
        EXECUTE q INTO val;
        ctx := ctx || jsonb_build_object(s.name, val);
      ELSIF s.kind = 'run' THEN
        EXECUTE q;
      ELSIF s.kind = 'ok' THEN
        EXECUTE 'SELECT COALESCE((' || q || '), false)' INTO b;
        IF b THEN n_pass := n_pass + 1; RAISE NOTICE 'PASS  %', s.name;
        ELSE n_fail := n_fail + 1; failed := failed || E'\n  - ' || s.name; RAISE NOTICE 'FAIL  %', s.name; END IF;
      ELSE  -- 'err': the statement must raise exactly this SQLSTATE
        got := NULL;
        BEGIN
          EXECUTE q;
        EXCEPTION WHEN OTHERS THEN
          got := SQLSTATE;
        END;
        IF got = ANY (string_to_array(s.expect, '|')) THEN n_pass := n_pass + 1; RAISE NOTICE 'PASS  %', s.name;
        ELSE n_fail := n_fail + 1; failed := failed || E'\n  - ' || s.name || ' (got ' || COALESCE(got, 'no error') || ')';
             RAISE NOTICE 'FAIL  % (expected %, got %)', s.name, s.expect, COALESCE(got, 'no error'); END IF;
      END IF;
    END LOOP;

    RAISE EXCEPTION 'rollback the test data' USING ERRCODE = 'ORD99';
  EXCEPTION WHEN SQLSTATE 'ORD99' THEN
    NULL;   -- expected: this undoes every fixture and order created above
  END;

  IF n_fail > 0 THEN
    RAISE EXCEPTION 'FAILED % of % checks:%', n_fail, n_pass + n_fail, failed;
  END IF;
  RAISE NOTICE 'ALL % CHECKS PASSED', n_pass;
END
$test$;

SELECT 'ALL ORDER TESTS PASSED' AS result;
