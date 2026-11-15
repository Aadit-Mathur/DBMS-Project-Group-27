from fastapi import APIRouter
from .. import db

router = APIRouter(prefix="/reports", tags=["reports"])


@router.get("/dashboard")
def dashboard():
    with db.transaction() as cur:
        cur.execute("""
            SELECT
                (SELECT COUNT(*) FROM customer) AS total_customers,
                (SELECT COUNT(*) FROM seller) AS total_sellers,
                (SELECT COUNT(*) FROM product) AS total_products,
                (SELECT COUNT(*) FROM orders) AS total_orders,
                (SELECT COALESCE(SUM(paid_amount), 0)
                 FROM v_paid_orders) AS total_order_value   -- revenue = successfully paid orders only
        """)
        return cur.fetchone()


@router.get("/top-products")
def top_products():
    with db.transaction() as cur:
        cur.execute("""
            SELECT
                p.product_id,
                p.product_name,
                SUM(oi.quantity) AS units_sold,
                SUM(oi.subtotal) AS revenue
            FROM order_item oi
            JOIN product p
                ON p.product_id = oi.product_id
            JOIN v_paid_orders o
                ON o.order_id = oi.order_id            -- paid orders only
            GROUP BY p.product_id, p.product_name
            ORDER BY units_sold DESC
            LIMIT 10
        """)
        return cur.fetchall()


@router.get("/categories")
def category_sales():
    with db.transaction() as cur:
        cur.execute("""
            SELECT
                c.category_id,
                c.category_name,
                SUM(oi.quantity) AS units_sold,
                SUM(oi.subtotal) AS revenue
            FROM order_item oi
            JOIN product p
                ON p.product_id = oi.product_id
            JOIN category c
                ON c.category_id = p.category_id
            JOIN v_paid_orders o
                ON o.order_id = oi.order_id            -- paid orders only
            GROUP BY c.category_id, c.category_name
            ORDER BY revenue DESC
        """)
        return cur.fetchall()


@router.get("/order-status")
def order_status_summary():
    with db.transaction() as cur:
        cur.execute("""
            SELECT
                order_status,
                COUNT(*) AS order_count
            FROM orders
            GROUP BY order_status
            ORDER BY order_count DESC
        """)
        return cur.fetchall()