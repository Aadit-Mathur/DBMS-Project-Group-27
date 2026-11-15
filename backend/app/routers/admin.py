"""Admin dashboard: read-only analytics over the whole platform.

Every stat is one SQL aggregate query (GROUP BY / JOIN / SUM / COUNT) run in
Postgres; Python only passes parameters and returns the rows.

Definitions used everywhere (state these in the report):
  * "Revenue" = money from orders whose payment is 'Successful'.
    Refunded, failed and pending payments are NOT revenue, so a paid-then-
    cancelled order drops out automatically (its payment becomes 'Refunded').
  * Date filters apply to orders.order_date, so every stat uses the same
    window. Both ends are inclusive: date_from 00:00 .. date_to 23:59:59.
  * Product/category/seller sales use order_item.unit_price * quantity
    (order_item.subtotal), i.e. the price at purchase time, not today's price.
"""
import os
import secrets
from datetime import date
from typing import Optional

from fastapi import APIRouter, Depends, HTTPException, Query
from fastapi.security import APIKeyHeader

from .. import db


# Declaring the header as a security scheme makes /docs show an "Authorize" button.
admin_key_header = APIKeyHeader(name="X-Admin-Key", auto_error=False)


def require_admin(x_admin_key: Optional[str] = Depends(admin_key_header)) -> None:
    """Reject the request unless it carries the admin key in an X-Admin-Key header.

    The key lives in .env as ADMIN_API_KEY (never in git). There are no user
    accounts in this project, so a shared secret is the simplest gate; it is
    the same idea as the X-Seller-Id header the seller routes use, but secret.
    """
    expected = os.getenv("ADMIN_API_KEY")
    if not expected:
        raise HTTPException(status_code=503, detail="ADMIN_API_KEY is not configured on the server")
    if x_admin_key is None or not secrets.compare_digest(x_admin_key, expected):
        raise HTTPException(status_code=401, detail="Admin key missing or wrong")


# Every route in this router needs the key.
router = APIRouter(
    prefix="/admin",
    tags=["Admin dashboard"],
    dependencies=[Depends(require_admin)],
    # Lists these codes in /docs so they no longer show as "Undocumented".
    responses={
        401: {"description": "Admin key missing or wrong"},
        503: {"description": "ADMIN_API_KEY is not configured on the server"},
    },
)

# Reused in every query that has a date window. psycopg2 fills the named params.
DATE_FILTER = """
      (%(date_from)s::date IS NULL OR o.order_date >= %(date_from)s::date)
  AND (%(date_to)s::date   IS NULL OR o.order_date <  %(date_to)s::date + 1)
"""

# Only paid orders count as sales.
PAID_JOIN = "JOIN payment pay ON pay.order_id = o.order_id AND pay.payment_status = 'Successful'"

# date_trunc() unit is never taken from user input directly (whitelist below).
INTERVALS = {"day": "day", "week": "week", "month": "month"}


def _window(date_from: Optional[date], date_to: Optional[date]) -> dict:
    return {"date_from": date_from, "date_to": date_to}


def _rows(sql: str, params: dict) -> list:
    with db.transaction() as cur:
        cur.execute(sql, params)
        return cur.fetchall()


# --------------------------------------------------------------------------
# 1. Total revenue and number of orders (date range)
# --------------------------------------------------------------------------
@router.get("/summary")
def summary(date_from: Optional[date] = None, date_to: Optional[date] = None):
    sql = f"""
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
        WHERE  {DATE_FILTER}
    """
    return _rows(sql, _window(date_from, date_to))[0]


@router.get("/revenue-trend")
def revenue_trend(date_from: Optional[date] = None, date_to: Optional[date] = None,
                  interval: str = Query("day", pattern="^(day|week|month)$")):
    sql = f"""
        SELECT date_trunc('{INTERVALS[interval]}', o.order_date)::date AS period,
               COUNT(*)                                                AS orders,
               SUM(o.total_amount)                                     AS revenue
        FROM   orders o
        {PAID_JOIN}
        WHERE  {DATE_FILTER}
        GROUP  BY period
        ORDER  BY period
    """
    return _rows(sql, _window(date_from, date_to))


# --------------------------------------------------------------------------
# 2. Orders by status
# --------------------------------------------------------------------------
@router.get("/orders-by-status")
def orders_by_status(date_from: Optional[date] = None, date_to: Optional[date] = None):
    sql = f"""
        SELECT o.order_status AS status, COUNT(*) AS orders
        FROM   orders o
        WHERE  {DATE_FILTER}
        GROUP  BY o.order_status
        ORDER  BY array_position(
                  ARRAY['Pending','Confirmed','Shipped','Delivered','Cancelled'], o.order_status::text)
    """
    return _rows(sql, _window(date_from, date_to))


# --------------------------------------------------------------------------
# 3. Top-selling products and top sellers
# --------------------------------------------------------------------------
@router.get("/top-products")
def top_products(date_from: Optional[date] = None, date_to: Optional[date] = None,
                 limit: int = Query(10, ge=1, le=50)):
    sql = f"""
        SELECT p.product_id, p.product_name, s.name AS seller_name,
               SUM(oi.quantity) AS units_sold,
               SUM(oi.subtotal) AS revenue
        FROM   order_item oi
        JOIN   orders  o ON o.order_id   = oi.order_id
        {PAID_JOIN}
        JOIN   product p ON p.product_id = oi.product_id
        JOIN   seller  s ON s.seller_id  = p.seller_id
        WHERE  {DATE_FILTER}
        GROUP  BY p.product_id, p.product_name, s.name
        ORDER  BY units_sold DESC, revenue DESC
        LIMIT  %(limit)s
    """
    return _rows(sql, {**_window(date_from, date_to), "limit": limit})


@router.get("/top-sellers")
def top_sellers(date_from: Optional[date] = None, date_to: Optional[date] = None,
                limit: int = Query(10, ge=1, le=50)):
    sql = f"""
        SELECT s.seller_id, s.name AS seller_name,
               COUNT(DISTINCT o.order_id) AS orders,
               SUM(oi.quantity)           AS units_sold,
               SUM(oi.subtotal)           AS revenue
        FROM   order_item oi
        JOIN   orders  o ON o.order_id   = oi.order_id
        {PAID_JOIN}
        JOIN   product p ON p.product_id = oi.product_id
        JOIN   seller  s ON s.seller_id  = p.seller_id
        WHERE  {DATE_FILTER}
        GROUP  BY s.seller_id, s.name
        ORDER  BY revenue DESC
        LIMIT  %(limit)s
    """
    return _rows(sql, {**_window(date_from, date_to), "limit": limit})


# --------------------------------------------------------------------------
# 4. Sales by category
# --------------------------------------------------------------------------
@router.get("/sales-by-category")
def sales_by_category(date_from: Optional[date] = None, date_to: Optional[date] = None):
    sql = f"""
        SELECT c.category_id, c.category_name,
               SUM(oi.quantity) AS units_sold,
               SUM(oi.subtotal) AS revenue,
               ROUND(100 * SUM(oi.subtotal) / SUM(SUM(oi.subtotal)) OVER (), 1) AS pct_of_revenue
        FROM   order_item oi
        JOIN   orders   o ON o.order_id    = oi.order_id
        {PAID_JOIN}
        JOIN   product  p ON p.product_id  = oi.product_id
        JOIN   category c ON c.category_id = p.category_id
        WHERE  {DATE_FILTER}
        GROUP  BY c.category_id, c.category_name
        ORDER  BY revenue DESC
    """
    return _rows(sql, _window(date_from, date_to))


# --------------------------------------------------------------------------
# 5. Low-stock alert list (quantity_in_stock <= reorder_level)
# --------------------------------------------------------------------------
@router.get("/low-stock")
def low_stock(limit: int = Query(50, ge=1, le=500)):
    # v_low_stock_products (already in the schema) = active products at/below reorder level.
    sql = """
        SELECT product_id, product_name, seller_name, category_name,
               quantity_in_stock, reorder_level, shortfall
        FROM   v_low_stock_products
        ORDER  BY shortfall DESC, quantity_in_stock
        LIMIT  %(limit)s
    """
    return _rows(sql, {"limit": limit})


# --------------------------------------------------------------------------
# 6. Payment breakdown by method and status
# --------------------------------------------------------------------------
@router.get("/payments")
def payments(date_from: Optional[date] = None, date_to: Optional[date] = None):
    sql = f"""
        SELECT pay.payment_method AS method, pay.payment_status AS status,
               COUNT(*)           AS payments,
               SUM(pay.amount)    AS amount
        FROM   payment pay
        JOIN   orders o ON o.order_id = pay.order_id
        WHERE  {DATE_FILTER}
        GROUP  BY pay.payment_method, pay.payment_status
        ORDER  BY pay.payment_method, pay.payment_status
    """
    return _rows(sql, _window(date_from, date_to))


# --------------------------------------------------------------------------
# 7. New customer registrations over time
# --------------------------------------------------------------------------
@router.get("/new-customers")
def new_customers(date_from: Optional[date] = None, date_to: Optional[date] = None,
                  interval: str = Query("month", pattern="^(day|week|month)$")):
    # customer has registration_date (a date), not order_date, so it has its own filter.
    sql = f"""
        SELECT date_trunc('{INTERVALS[interval]}', c.registration_date)::date AS period,
               COUNT(*) AS new_customers
        FROM   customer c
        WHERE  (%(date_from)s::date IS NULL OR c.registration_date >= %(date_from)s::date)
           AND (%(date_to)s::date   IS NULL OR c.registration_date <= %(date_to)s::date)
        GROUP  BY period
        ORDER  BY period
    """
    return _rows(sql, _window(date_from, date_to))


# --------------------------------------------------------------------------
# 8. Shipment status overview
# --------------------------------------------------------------------------
@router.get("/shipments")
def shipments(date_from: Optional[date] = None, date_to: Optional[date] = None):
    # A shipment row exists only after a successful payment, so this counts shipped-flow orders.
    sql = f"""
        SELECT sh.shipment_status AS status,
               COUNT(*) AS shipments,
               ROUND(AVG(EXTRACT(EPOCH FROM (sh.delivery_date - sh.shipment_date)) / 86400)
                     FILTER (WHERE sh.shipment_status = 'Delivered'), 1) AS avg_days_to_deliver
        FROM   shipment sh
        JOIN   orders o ON o.order_id = sh.order_id
        WHERE  {DATE_FILTER}
        GROUP  BY sh.shipment_status
        ORDER  BY array_position(
                  ARRAY['Pending','Shipped','In Transit','Delivered','Cancelled'], sh.shipment_status::text)
    """
    return _rows(sql, _window(date_from, date_to))
