"""Seller endpoints: registration, dashboard, own catalog, low-stock alerts."""
from fastapi import APIRouter, HTTPException

from .. import db
from ..schemas import ProductCreate, SellerCreate

router = APIRouter(prefix="/sellers", tags=["Sellers"])


def require_seller(cur, seller_id: int) -> None:
    cur.execute("SELECT 1 FROM seller WHERE seller_id = %s", (seller_id,))
    if cur.fetchone() is None:
        raise HTTPException(status_code=404, detail="Seller not found.")


@router.post("", status_code=201)
def register_seller(body: SellerCreate):
    """UNIQUE email/phone and CHECK phone/email format are enforced by the DB."""
    with db.transaction() as cur:
        cur.execute(
            """
            INSERT INTO seller (name, email, phone)
            VALUES (%s, %s, %s)
            RETURNING seller_id, name, email, phone, registration_date
            """,
            (body.name, body.email, body.phone),
        )
        return cur.fetchone()


@router.get("/{seller_id}/dashboard")
def seller_dashboard(seller_id: int):
    """Query Q1 for one seller: catalog size, stock, inventory value, low-stock count."""
    with db.transaction() as cur:
        cur.execute(
            """
            SELECT s.seller_id,
                   s.name,
                   COUNT(p.product_id) FILTER (WHERE p.is_active)                   AS active_products,
                   COALESCE(SUM(p.quantity_in_stock) FILTER (WHERE p.is_active), 0) AS units_in_stock,
                   COALESCE(SUM(p.price * p.quantity_in_stock)
                            FILTER (WHERE p.is_active), 0)                          AS inventory_value,
                   COUNT(p.product_id) FILTER (WHERE p.is_active
                                                 AND p.quantity_in_stock <= p.reorder_level) AS low_stock_products
            FROM   seller s
            LEFT JOIN product p ON p.seller_id = s.seller_id
            WHERE  s.seller_id = %s
            GROUP  BY s.seller_id, s.name
            """,
            (seller_id,),
        )
        row = cur.fetchone()
        if row is None:
            raise HTTPException(status_code=404, detail="Seller not found.")
        return row


@router.get("/{seller_id}/products")
def list_seller_products(seller_id: int, include_inactive: bool = False):
    """The seller's own catalog. Delisted products are hidden unless asked for."""
    with db.transaction() as cur:
        require_seller(cur, seller_id)
        cur.execute(
            """
            SELECT p.product_id, p.product_name, p.brand, p.price,
                   p.quantity_in_stock, p.reorder_level, p.is_active,
                   p.last_updated, c.category_id, c.category_name
            FROM   product p
            JOIN   category c ON c.category_id = p.category_id
            WHERE  p.seller_id = %s
              AND  (%s OR p.is_active)
            ORDER  BY p.product_name
            """,
            (seller_id, include_inactive),
        )
        return cur.fetchall()


@router.post("/{seller_id}/products", status_code=201)
def add_product(seller_id: int, body: ProductCreate):
    """CHECK price >= 0 / stock >= 0, UNIQUE (seller_id, product_name) and the
    category FK are enforced by the DB."""
    with db.transaction() as cur:
        require_seller(cur, seller_id)
        cur.execute(
            """
            INSERT INTO product (seller_id, category_id, product_name, description,
                                 brand, price, quantity_in_stock, reorder_level)
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s)
            RETURNING *
            """,
            (seller_id, body.category_id, body.product_name, body.description,
             body.brand, body.price, body.quantity_in_stock, body.reorder_level),
        )
        return cur.fetchone()


@router.get("/{seller_id}/low-stock")
def low_stock(seller_id: int):
    """Reads the view v_low_stock_products."""
    with db.transaction() as cur:
        require_seller(cur, seller_id)
        cur.execute(
            """
            SELECT product_id, product_name, category_name,
                   quantity_in_stock, reorder_level, shortfall
            FROM   v_low_stock_products
            WHERE  seller_id = %s
            ORDER  BY shortfall DESC, product_name
            """,
            (seller_id,),
        )
        return cur.fetchall()
