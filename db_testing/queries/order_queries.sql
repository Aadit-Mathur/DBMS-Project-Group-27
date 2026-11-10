-- =====================================================================
-- Ordering module: analytical queries (for the demo / report)
-- Run one at a time in the Neon SQL Editor, or all:
--   python db_testing/run_sql.py db_testing/queries/order_queries.sql   (prints the last one)
-- Revenue always means orders whose payment is 'Successful' (view v_paid_orders).
-- =====================================================================

-- Q1. Monthly revenue with month-over-month growth (view + window function LAG)
SELECT month, orders, revenue,
       round(100.0 * (revenue - LAG(revenue) OVER (ORDER BY month))
             / NULLIF(LAG(revenue) OVER (ORDER BY month), 0), 1) AS growth_pct
FROM (SELECT date_trunc('month', payment_date)::date AS month,
             count(*) AS orders, sum(paid_amount) AS revenue
      FROM v_paid_orders GROUP BY 1) m
ORDER BY month;

-- Q2. Top 10 customers by money spent, with rank and share of all revenue (JOIN, GROUP BY, window SUM)
SELECT RANK() OVER (ORDER BY SUM(v.paid_amount) DESC) AS rnk,
       c.customer_id, c.name, count(*) AS paid_orders, sum(v.paid_amount) AS spent,
       round(100.0 * SUM(v.paid_amount) / SUM(SUM(v.paid_amount)) OVER (), 2) AS pct_of_revenue
FROM v_paid_orders v JOIN customer c USING (customer_id)
GROUP BY c.customer_id, c.name
ORDER BY rnk LIMIT 10;

-- Q3. Best-selling products from paid orders: units, revenue, seller, category (4-table JOIN)
SELECT p.product_id, p.product_name, s.name AS seller, c.category_name,
       SUM(oi.quantity) AS units_sold, SUM(oi.subtotal) AS revenue
FROM v_paid_orders v
JOIN order_item oi ON oi.order_id = v.order_id
JOIN product   p  ON p.product_id = oi.product_id
JOIN seller    s  ON s.seller_id  = p.seller_id
JOIN category  c  ON c.category_id = p.category_id
GROUP BY p.product_id, p.product_name, s.name, c.category_name
ORDER BY units_sold DESC, revenue DESC LIMIT 10;

-- Q4. Revenue per seller and per category with share of total (GROUP BY ROLLUP-style via two levels + window)
SELECT s.name AS seller, c.category_name, SUM(oi.subtotal) AS revenue,
       round(100.0 * SUM(oi.subtotal) / SUM(SUM(oi.subtotal)) OVER (PARTITION BY s.seller_id), 1) AS pct_of_seller
FROM v_paid_orders v
JOIN order_item oi ON oi.order_id = v.order_id
JOIN product p ON p.product_id = oi.product_id
JOIN seller s ON s.seller_id = p.seller_id
JOIN category c ON c.category_id = p.category_id
GROUP BY s.seller_id, s.name, c.category_id, c.category_name
ORDER BY s.name, revenue DESC;

-- Q5. Order funnel: how many orders end in each state, and the payment success rate (conditional aggregation)
SELECT count(*) AS orders_placed,
       count(*) FILTER (WHERE payment_status IN ('Successful','Refunded'))              AS ever_paid,
       count(*) FILTER (WHERE order_status IN ('Confirmed','Shipped','Delivered'))      AS active_paid,
       count(*) FILTER (WHERE order_status = 'Delivered')                               AS delivered,
       count(*) FILTER (WHERE payment_status = 'Refunded')                              AS refunded,
       count(*) FILTER (WHERE order_status = 'Cancelled' AND payment_status = 'Failed') AS cancelled_unpaid,
       round(100.0 * count(*) FILTER (WHERE payment_status IN ('Successful','Refunded')) / count(*), 1) AS paid_pct
FROM v_order_summary;

-- Q6. Delivery performance per carrier: average days from dispatch to delivery (JOIN, AVG on intervals)
SELECT s.carrier, count(*) AS delivered,
       round(avg(EXTRACT(EPOCH FROM (s.delivery_date - s.shipment_date)) / 86400)::numeric, 1) AS avg_days_in_transit,
       round(avg(EXTRACT(EPOCH FROM (s.shipment_date - o.order_date)) / 86400)::numeric, 1)   AS avg_days_to_dispatch
FROM shipment s JOIN orders o USING (order_id)
WHERE s.shipment_status = 'Delivered'
GROUP BY s.carrier ORDER BY avg_days_in_transit;

-- Q7. Customers who cancel a lot: cancellation rate, only customers with 3+ orders (GROUP BY ... HAVING)
SELECT c.customer_id, c.name, count(*) AS orders,
       count(*) FILTER (WHERE o.order_status = 'Cancelled') AS cancelled,
       round(100.0 * count(*) FILTER (WHERE o.order_status = 'Cancelled') / count(*), 0) AS cancel_pct
FROM orders o JOIN customer c USING (customer_id)
GROUP BY c.customer_id, c.name
HAVING count(*) >= 3 AND count(*) FILTER (WHERE o.order_status = 'Cancelled') > 0
ORDER BY cancel_pct DESC, orders DESC LIMIT 10;

-- Q8. Payment methods: usage, success rate and failed attempts (GROUP BY with FILTER)
SELECT payment_method, count(*) AS orders,
       count(*) FILTER (WHERE payment_status IN ('Successful','Refunded')) AS paid,
       count(*) FILTER (WHERE attempts > 1 OR (payment_status = 'Failed' AND attempts > 0)) AS had_failed_attempt,
       sum(amount) FILTER (WHERE payment_status = 'Successful') AS revenue
FROM payment GROUP BY payment_method ORDER BY revenue DESC NULLS LAST;

-- Q9. Products that are selling faster than they are being restocked: paid units in the last 30 days vs stock left
--     (CTE + JOIN to the low-stock view from the seller module)
WITH recent AS (
  SELECT oi.product_id, SUM(oi.quantity) AS sold_30d
  FROM v_paid_orders v JOIN order_item oi ON oi.order_id = v.order_id
  WHERE v.payment_date >= LOCALTIMESTAMP - interval '30 days'
  GROUP BY oi.product_id)
SELECT p.product_id, p.product_name, r.sold_30d, p.quantity_in_stock,
       round(p.quantity_in_stock::numeric / NULLIF(r.sold_30d / 30.0, 0), 0) AS days_of_stock_left,
       (l.product_id IS NOT NULL) AS already_flagged_low_stock
FROM recent r JOIN product p USING (product_id)
LEFT JOIN v_low_stock_products l ON l.product_id = p.product_id
ORDER BY days_of_stock_left NULLS LAST LIMIT 10;

-- Q10. Unpaid orders waiting longer than 30 minutes, oldest first (partial index idx_orders_pending)
SELECT o.order_id, c.name, o.total_amount, p.payment_status, p.attempts,
       round(EXTRACT(EPOCH FROM (LOCALTIMESTAMP - o.order_date)) / 60) AS minutes_waiting
FROM orders o JOIN customer c USING (customer_id) JOIN payment p USING (order_id)
WHERE o.order_status = 'Pending' AND o.order_date < LOCALTIMESTAMP - interval '30 minutes'
ORDER BY o.order_date LIMIT 10;
