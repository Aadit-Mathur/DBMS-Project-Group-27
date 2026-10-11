"""Category list (categories are created by the admin)."""
from fastapi import APIRouter

from .. import db

router = APIRouter(prefix="/categories", tags=["Categories"])


@router.get("")
def list_categories():
    with db.transaction() as cur:
        cur.execute(
            """
            SELECT c.category_id, c.category_name, c.description,
                   COUNT(p.product_id) FILTER (WHERE p.is_active) AS active_products
            FROM   category c
            LEFT JOIN product p ON p.category_id = c.category_id
            GROUP  BY c.category_id, c.category_name, c.description
            ORDER  BY c.category_name
            """
        )
        return cur.fetchall()
