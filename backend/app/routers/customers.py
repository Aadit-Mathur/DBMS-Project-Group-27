"""Customer lookups the frontend needs to place and view orders (there is no login in this project:
the frontend identifies the customer by email once, then passes customer_id around)."""
from typing import Optional

from fastapi import APIRouter, HTTPException, Query

from .. import db

router = APIRouter(tags=["customers"])

ORDER_STATUSES = ("Pending", "Confirmed", "Shipped", "Delivered", "Cancelled")


def _customer_or_404(cur, customer_id: int) -> dict:
    cur.execute("SELECT customer_id, name, email, phone FROM customer WHERE customer_id = %s", (customer_id,))
    row = cur.fetchone()
    if row is None:
        raise HTTPException(status_code=404, detail="Customer not found")
    return row


@router.get("/customers")
def find_customer(email: str = Query(..., min_length=3)):
    with db.transaction() as cur:
        cur.execute("SELECT customer_id, name, email, phone FROM customer WHERE lower(email) = lower(%s)", (email,))
        row = cur.fetchone()
    if row is None:
        raise HTTPException(status_code=404, detail="Customer not found")
    return row


@router.get("/customers/{customer_id}")
def get_customer(customer_id: int):
    with db.transaction() as cur:
        return _customer_or_404(cur, customer_id)


@router.get("/customers/{customer_id}/addresses")
def list_addresses(customer_id: int):
    with db.transaction() as cur:
        _customer_or_404(cur, customer_id)
        cur.execute("""SELECT address_id, address_type, house_no, street, locality, city, district, state, pin_code
                       FROM address WHERE customer_id = %s ORDER BY address_id""", (customer_id,))
        return cur.fetchall()


@router.get("/customers/{customer_id}/orders")
def order_history(customer_id: int, status: Optional[str] = None,
                  limit: int = Query(20, ge=1, le=100), offset: int = Query(0, ge=0)):
    if status is not None and status not in ORDER_STATUSES:
        raise HTTPException(status_code=400, detail=f"status must be one of {', '.join(ORDER_STATUSES)}")
    with db.transaction() as cur:
        _customer_or_404(cur, customer_id)
        cur.execute(
            """SELECT order_id, order_date, order_status AS status, total_amount, item_count,
                      payment_status, shipment_status, tracking_number
               FROM v_order_summary
               WHERE customer_id = %s AND (%s::text IS NULL OR order_status = %s)
               ORDER BY order_date DESC, order_id DESC LIMIT %s OFFSET %s""",
            (customer_id, status, status, limit, offset))
        return cur.fetchall()
