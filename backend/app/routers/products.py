"""Product endpoints: customer search, and seller edit / restock / remove.

Authentication is not built yet, so seller-only routes take the
logged-in seller's id in the X-Seller-Id header. Every seller route
checks that the product belongs to that seller.
"""
from decimal import Decimal
from typing import Optional

import psycopg2
from fastapi import APIRouter, Header, HTTPException, Query, Response
from fastapi.responses import JSONResponse
from psycopg2 import sql

from .. import db
from ..schemas import ProductUpdate, RestockRequest

router = APIRouter(prefix="/products", tags=["Products"])

EDITABLE = ("category_id", "product_name", "description", "brand", "price", "reorder_level")


def require_owned_product(cur, product_id: int, seller_id: int) -> None:
    cur.execute("SELECT seller_id FROM product WHERE product_id = %s", (product_id,))
    row = cur.fetchone()
    if row is None:
        raise HTTPException(status_code=404, detail="Product not found.")
    if row["seller_id"] != seller_id:
        raise HTTPException(status_code=403, detail="This product belongs to another seller.")


@router.get("")
def search_products(
    q: Optional[str] = None,
    category_id: Optional[int] = None,
    min_price: Decimal = Decimal("0"),
    max_price: Optional[Decimal] = None,
    in_stock_only: bool = False,
    limit: int = Query(20, ge=1, le=100),
    offset: int = Query(0, ge=0),
):
    """Query Q4: keyword (name or brand), category and price filters over a
    3-table join. Uses the (category_id, price) index when a category is given."""
    pattern = f"%{q}%" if q else None
    with db.transaction() as cur:
        cur.execute(
            """
            SELECT p.product_id, p.product_name, p.brand, p.price,
                   p.quantity_in_stock > 0 AS in_stock,
                   c.category_id, c.category_name,
                   s.seller_id, s.name AS seller_name
            FROM   product p
            JOIN   category c ON c.category_id = p.category_id
            JOIN   seller   s ON s.seller_id   = p.seller_id
            WHERE  p.is_active
              AND  (%(pattern)s::TEXT IS NULL
                    OR p.product_name ILIKE %(pattern)s OR p.brand ILIKE %(pattern)s)
              AND  (%(category_id)s::BIGINT IS NULL OR p.category_id = %(category_id)s)
              AND  p.price >= %(min_price)s
              AND  (%(max_price)s::NUMERIC IS NULL OR p.price <= %(max_price)s)
              AND  (NOT %(in_stock_only)s OR p.quantity_in_stock > 0)
            ORDER  BY p.price, p.product_id
            LIMIT  %(limit)s OFFSET %(offset)s
            """,
            {"pattern": pattern, "category_id": category_id, "min_price": min_price,
             "max_price": max_price, "in_stock_only": in_stock_only,
             "limit": limit, "offset": offset},
        )
        return cur.fetchall()


@router.patch("/{product_id}")
def update_product(product_id: int, body: ProductUpdate,
                   seller_id: int = Header(alias="X-Seller-Id")):
    """Edit price or details. The trigger trg_product_touch sets last_updated."""
    changes = body.model_dump(exclude_unset=True)
    if not changes:
        raise HTTPException(status_code=400, detail="Nothing to update.")

    assignments = sql.SQL(", ").join(
        sql.SQL("{} = {}").format(sql.Identifier(col), sql.Placeholder(col))
        for col in EDITABLE if col in changes
    )
    query = sql.SQL("UPDATE product SET {} WHERE product_id = {} RETURNING *").format(
        assignments, sql.Placeholder("product_id"))

    with db.transaction() as cur:
        require_owned_product(cur, product_id, seller_id)
        cur.execute(query, {**changes, "product_id": product_id})
        return cur.fetchone()


@router.post("/{product_id}/restock")
def restock_product(product_id: int, body: RestockRequest,
                    seller_id: int = Header(alias="X-Seller-Id")):
    """Calls the stored function restock_product(), which itself refuses
    another seller's product (403) and a quantity of 0 or less (400)."""
    with db.transaction() as cur:
        cur.execute("SELECT 1 FROM product WHERE product_id = %s", (product_id,))
        if cur.fetchone() is None:
            raise HTTPException(status_code=404, detail="Product not found.")
        cur.execute("SELECT restock_product(%s, %s, %s) AS quantity_in_stock",
                    (seller_id, product_id, body.quantity))
        return {"product_id": product_id, **cur.fetchone()}


@router.delete("/{product_id}", status_code=204, responses={200: {"description": "Product delisted"}})
def remove_product(product_id: int, seller_id: int = Header(alias="X-Seller-Id")):
    """Try a real delete. If the product appears in any order, the FK on
    order_item blocks it (23503, or 23001 on PostgreSQL 18+), so the product is delisted instead:
    hidden from customers, but kept so order history stays intact."""
    with db.transaction() as cur:
        require_owned_product(cur, product_id, seller_id)
        cur.execute("SAVEPOINT before_delete")
        try:
            cur.execute("DELETE FROM product WHERE product_id = %s", (product_id,))
            return Response(status_code=204)
        except (psycopg2.errors.ForeignKeyViolation, psycopg2.errors.RestrictViolation):
            # 23503 on PostgreSQL <= 17, 23001 on PostgreSQL 18+ (Neon) for ON DELETE RESTRICT
            cur.execute("ROLLBACK TO SAVEPOINT before_delete")
            cur.execute(
                "UPDATE product SET is_active = FALSE WHERE product_id = %s "
                "RETURNING product_id, is_active",
                (product_id,),
            )
            row = cur.fetchone()
            return JSONResponse(status_code=200, content={
                **row,
                "status": "delisted",
                "reason": "The product appears in past orders, so it was hidden instead of deleted.",
            })
