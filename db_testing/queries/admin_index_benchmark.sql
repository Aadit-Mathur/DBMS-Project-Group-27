
-- 1. Scale the data up so the planner has a reason to prefer an index.
--    Bulk load only: skip triggers; ids start at 100000 to avoid the real rows.
SET session_replication_role = replica;
INSERT INTO orders (order_id, customer_id, order_date, order_status, total_amount, address_id)
SELECT 100000 + g, 1 + (g % 600), TIMESTAMP '2024-01-01' + (g * interval '4 minutes'),
       'Delivered', 500 + (g % 9000), 1 + (g % 1560)
FROM   generate_series(1, 200000) g;
INSERT INTO payment (payment_id, order_id, payment_date, payment_method, payment_status, amount)
SELECT 100000 + g, 100000 + g, TIMESTAMP '2024-01-01' + (g * interval '4 minutes'),
       'UPI', 'Successful', 500 + (g % 9000)
FROM   generate_series(1, 200000) g;
SET session_replication_role = DEFAULT;
ANALYZE orders;
ANALYZE payment;

-- 2. BEFORE: expect "Seq Scan on orders" (run it 3 times, note Execution Time)
\echo '=== BEFORE ==='
EXPLAIN (ANALYZE, BUFFERS, COSTS OFF)
SELECT date_trunc('day', o.order_date)::date AS period, COUNT(*), SUM(o.total_amount)
FROM   orders o
JOIN   payment pay ON pay.order_id = o.order_id AND pay.payment_status = 'Successful'
WHERE  o.order_date >= DATE '2025-03-01' AND o.order_date < DATE '2025-03-07' + 1
GROUP  BY period ORDER BY period;

-- 3. Add the index
CREATE INDEX idx_orders_order_date ON orders (order_date);
ANALYZE orders;

-- 4. AFTER: expect "Index Scan using idx_orders_order_date on orders"
\echo '=== AFTER ==='
EXPLAIN (ANALYZE, BUFFERS, COSTS OFF)
SELECT date_trunc('day', o.order_date)::date AS period, COUNT(*), SUM(o.total_amount)
FROM   orders o
JOIN   payment pay ON pay.order_id = o.order_id AND pay.payment_status = 'Successful'
WHERE  o.order_date >= DATE '2025-03-01' AND o.order_date < DATE '2025-03-07' + 1
GROUP  BY period ORDER BY period;

-- 5. Index size (the cost side of the trade-off: extra disk + slower INSERTs)
\di+ idx_orders_order_date
