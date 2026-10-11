-- =====================================================================
-- Seller & Products module: non-trivial queries
-- Q3 needs the ordering module's order_item table.
-- Q4 is shown with sample values; the API runs it with parameters.
-- =====================================================================

-- Q1. Seller dashboard: catalog size, stock, inventory value and
--     low-stock count per seller (LEFT JOIN + GROUP BY + FILTER)
SELECT s.seller_id,
       s.name,
       COUNT(p.product_id) FILTER (WHERE p.is_active)                    AS active_products,
       COALESCE(SUM(p.quantity_in_stock) FILTER (WHERE p.is_active), 0)  AS units_in_stock,
       COALESCE(SUM(p.price * p.quantity_in_stock)
                FILTER (WHERE p.is_active), 0)                           AS inventory_value,
       COUNT(p.product_id) FILTER (WHERE p.is_active
                                     AND p.quantity_in_stock <= p.reorder_level) AS low_stock_products
FROM   seller s
LEFT JOIN product p ON p.seller_id = s.seller_id
GROUP  BY s.seller_id, s.name
ORDER  BY inventory_value DESC;

-- Q2. Products priced above the average of their own category
--     (correlated subquery)
SELECT p.product_id, p.product_name, c.category_name, p.price,
       ROUND((SELECT AVG(p2.price)
              FROM   product p2
              WHERE  p2.category_id = p.category_id
                AND  p2.is_active), 2)                    AS category_avg
FROM   product p
JOIN   category c ON c.category_id = p.category_id
WHERE  p.is_active
  AND  p.price > (SELECT AVG(p2.price)
                  FROM   product p2
                  WHERE  p2.category_id = p.category_id
                    AND  p2.is_active)
ORDER  BY c.category_name, p.price DESC;

-- Q3. Top 3 best-selling products in each category
--     (CTE + window function; joins with order_item)
WITH product_sales AS (
    SELECT p.product_id,
           p.product_name,
           p.category_id,
           SUM(oi.quantity)                 AS units_sold,
           SUM(oi.quantity * oi.unit_price) AS revenue
    FROM   product p
    JOIN   order_item oi ON oi.product_id = p.product_id
    GROUP  BY p.product_id, p.product_name, p.category_id
),
ranked AS (
    SELECT ps.*,
           RANK() OVER (PARTITION BY ps.category_id
                        ORDER BY ps.units_sold DESC) AS rank_in_category
    FROM   product_sales ps
)
SELECT c.category_name, r.rank_in_category, r.product_name, r.units_sold, r.revenue
FROM   ranked r
JOIN   category c ON c.category_id = r.category_id
WHERE  r.rank_in_category <= 3
ORDER  BY c.category_name, r.rank_in_category;

-- Q4. Search and filter (used by GET /products): keyword, category,
--     price range, active products only. Sample values: 'shoe', any
--     category, Rs 500 to 3000. The API passes these as parameters.
SELECT p.product_id, p.product_name, p.brand, p.price,
       p.quantity_in_stock > 0 AS in_stock,
       c.category_name, s.name AS seller_name
FROM   product p
JOIN   category c ON c.category_id = p.category_id
JOIN   seller   s ON s.seller_id   = p.seller_id
WHERE  p.is_active
  AND  (p.product_name ILIKE '%' || 'shoe' || '%' OR p.brand ILIKE '%' || 'shoe' || '%')
  AND  (NULL::BIGINT IS NULL OR p.category_id = NULL::BIGINT)
  AND  p.price BETWEEN 500 AND 3000
ORDER  BY p.price;
