-- =============================================================================
-- admin_queries.sql  --  raw SQL behind every /admin/* endpoint
-- Author: Yash Agarwal (2024AAPS0294H) | Admin dashboard module
--
-- Each query below is the same SQL that backend/app/routers/admin.py runs
-- (psycopg2's %(name)s placeholders are written as psql :name variables here).
--
-- HOW TO RUN (from the repo root):
--   psql "$DATABASE_URL" -f db_testing/queries/admin_queries.sql
--
-- DEFINITIONS USED EVERYWHERE
--   * Revenue  = orders that have a payment row with payment_status = 'Successful'
--   * Date window filters orders.order_date; date_to is inclusive (< date_to + 1)
--   * Setting a bound to NULL means "no limit on that side"
-- =============================================================================

-- Parameters. Use NULL for "no bound", or a quoted date wrapped in single quotes:
--   \set date_from '''2026-01-01'''
\set date_from NULL
\set date_to   NULL
\set lim       10
-- period for Q1b and Q7: day | week | month
\set period    month

\echo '--- Q1a  /admin/summary  (revenue + order count) ---'
-- Uses: LEFT JOIN, FILTER (conditional aggregation), AVG, COALESCE
SELECT COUNT(*)                                                     AS total_orders,
       COUNT(*) FILTER (WHERE pay.payment_status = 'Successful')    AS paid_orders,
       COALESCE(SUM(o.total_amount)
                FILTER (WHERE pay.payment_status = 'Successful'), 0) AS revenue,
       COALESCE(ROUND(AVG(o.total_amount)
                FILTER (WHERE pay.payment_status = 'Successful'), 2), 0) AS avg_order_value,
       COALESCE(SUM(pay.amount)
                FILTER (WHERE pay.payment_status = 'Refunded'), 0)   AS refunded_amount
FROM   orders o
LEFT JOIN payment pay ON pay.order_id = o.order_id
WHERE  (:date_from::date IS NULL OR o.order_date >= :date_from::date)
  AND  (:date_to::date   IS NULL OR o.order_date <  :date_to::date + 1);

\echo '--- Q1b  /admin/revenue-trend  (revenue per day/week/month) ---'
-- Uses: JOIN, date_trunc, GROUP BY, ORDER BY
SELECT date_trunc(:'period', o.order_date)::date AS period,
       COUNT(*)                                  AS orders,
       SUM(o.total_amount)                       AS revenue
FROM   orders o
JOIN   payment pay ON pay.order_id = o.order_id AND pay.payment_status = 'Successful'
WHERE  (:date_from::date IS NULL OR o.order_date >= :date_from::date)
  AND  (:date_to::date   IS NULL OR o.order_date <  :date_to::date + 1)
GROUP  BY period
ORDER  BY period;

\echo '--- Q2  /admin/orders-by-status ---'
-- Uses: GROUP BY, array_position (custom lifecycle ordering)
SELECT o.order_status AS status, COUNT(*) AS orders
FROM   orders o
WHERE  (:date_from::date IS NULL OR o.order_date >= :date_from::date)
  AND  (:date_to::date   IS NULL OR o.order_date <  :date_to::date + 1)
GROUP  BY o.order_status
ORDER  BY array_position(
          ARRAY['Pending','Confirmed','Shipped','Delivered','Cancelled'], o.order_status::text);

\echo '--- Q3a  /admin/top-products ---'
-- Uses: 4-table JOIN (order_item, orders, payment, product, seller), GROUP BY, LIMIT
SELECT p.product_id, p.product_name, s.name AS seller_name,
       SUM(oi.quantity) AS units_sold,
       SUM(oi.subtotal) AS revenue
FROM   order_item oi
JOIN   orders  o ON o.order_id   = oi.order_id
JOIN   payment pay ON pay.order_id = o.order_id AND pay.payment_status = 'Successful'
JOIN   product p ON p.product_id = oi.product_id
JOIN   seller  s ON s.seller_id  = p.seller_id
WHERE  (:date_from::date IS NULL OR o.order_date >= :date_from::date)
  AND  (:date_to::date   IS NULL OR o.order_date <  :date_to::date + 1)
GROUP  BY p.product_id, p.product_name, s.name
ORDER  BY units_sold DESC, revenue DESC
LIMIT  :lim;

\echo '--- Q3b  /admin/top-sellers ---'
-- Uses: COUNT(DISTINCT), multi-table JOIN, GROUP BY
SELECT s.seller_id, s.name AS seller_name,
       COUNT(DISTINCT o.order_id) AS orders,
       SUM(oi.quantity)           AS units_sold,
       SUM(oi.subtotal)           AS revenue
FROM   order_item oi
JOIN   orders  o ON o.order_id   = oi.order_id
JOIN   payment pay ON pay.order_id = o.order_id AND pay.payment_status = 'Successful'
JOIN   product p ON p.product_id = oi.product_id
JOIN   seller  s ON s.seller_id  = p.seller_id
WHERE  (:date_from::date IS NULL OR o.order_date >= :date_from::date)
  AND  (:date_to::date   IS NULL OR o.order_date <  :date_to::date + 1)
GROUP  BY s.seller_id, s.name
ORDER  BY revenue DESC
LIMIT  :lim;

\echo '--- Q4  /admin/sales-by-category  (window function) ---'
-- Uses: WINDOW FUNCTION  SUM(SUM(x)) OVER ()  to get each category's % share
--       of total revenue without a second query or subquery
SELECT c.category_id, c.category_name,
       SUM(oi.quantity) AS units_sold,
       SUM(oi.subtotal) AS revenue,
       ROUND(100 * SUM(oi.subtotal) / SUM(SUM(oi.subtotal)) OVER (), 1) AS pct_of_revenue
FROM   order_item oi
JOIN   orders   o ON o.order_id    = oi.order_id
JOIN   payment pay ON pay.order_id = o.order_id AND pay.payment_status = 'Successful'
JOIN   product  p ON p.product_id  = oi.product_id
JOIN   category c ON c.category_id = p.category_id
WHERE  (:date_from::date IS NULL OR o.order_date >= :date_from::date)
  AND  (:date_to::date   IS NULL OR o.order_date <  :date_to::date + 1)
GROUP  BY c.category_id, c.category_name
ORDER  BY revenue DESC;

\echo '--- Q5  /admin/low-stock  (uses VIEW v_low_stock_products) ---'
-- The view = active products with quantity_in_stock <= reorder_level
SELECT product_id, product_name, seller_name, category_name,
       quantity_in_stock, reorder_level, shortfall
FROM   v_low_stock_products
ORDER  BY shortfall DESC, quantity_in_stock
LIMIT  50;

\echo '--- Q6  /admin/payments  (breakdown by method and status) ---'
SELECT pay.payment_method AS method, pay.payment_status AS status,
       COUNT(*)           AS payments,
       SUM(pay.amount)    AS amount
FROM   payment pay
JOIN   orders o ON o.order_id = pay.order_id
WHERE  (:date_from::date IS NULL OR o.order_date >= :date_from::date)
  AND  (:date_to::date   IS NULL OR o.order_date <  :date_to::date + 1)
GROUP  BY pay.payment_method, pay.payment_status
ORDER  BY pay.payment_method, pay.payment_status;

\echo '--- Q7  /admin/new-customers  (registrations over time) ---'
-- Filters customer.registration_date (not order_date)
SELECT date_trunc(:'period', c.registration_date)::date AS period,
       COUNT(*) AS new_customers
FROM   customer c
WHERE  (:date_from::date IS NULL OR c.registration_date >= :date_from::date)
   AND (:date_to::date   IS NULL OR c.registration_date <= :date_to::date)
GROUP  BY period
ORDER  BY period;

\echo '--- Q8  /admin/shipments  (status overview + avg delivery days) ---'
-- Uses: FILTER inside AVG, EXTRACT(EPOCH ...) date arithmetic
SELECT sh.shipment_status AS status,
       COUNT(*) AS shipments,
       ROUND(AVG(EXTRACT(EPOCH FROM (sh.delivery_date - sh.shipment_date)) / 86400)
             FILTER (WHERE sh.shipment_status = 'Delivered'), 1) AS avg_days_to_deliver
FROM   shipment sh
JOIN   orders o ON o.order_id = sh.order_id
WHERE  (:date_from::date IS NULL OR o.order_date >= :date_from::date)
  AND  (:date_to::date   IS NULL OR o.order_date <  :date_to::date + 1)
GROUP  BY sh.shipment_status
ORDER  BY array_position(
          ARRAY['Pending','Shipped','In Transit','Delivered','Cancelled'], sh.shipment_status::text);

\echo '--- Q9  /admin/overview  (headline counts, no date window) ---'
-- Uses: scalar subqueries, one round trip
SELECT (SELECT COUNT(*) FROM customer)                AS customers,
       (SELECT COUNT(*) FROM seller)                  AS sellers,
       (SELECT COUNT(*) FROM product)                 AS products,
       (SELECT COUNT(*) FROM product WHERE is_active) AS active_products;
