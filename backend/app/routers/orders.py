"""Order endpoints: place an order, view one order, view a customer's order history.

All business rules live in PostgreSQL (see db/order_schema.sql). place_order() is one
database transaction: it validates the address, locks the product rows, checks stock,
copies the price, decrements stock and creates a pending payment, or rolls back.
"""
import json
import os

import psycopg2
from fastapi import APIRouter, HTTPException
from psycopg2.extras import RealDictCursor
from pydantic import BaseModel, Field

router = APIRouter(tags=["orders"])


def _connect():
    # If backend/app/db.py already has a function that returns a connection, replace the
    # body of this function with a call to it, so there is only one way to connect.
    return psycopg2.connect(os.environ["DATABASE_URL"])


# ---- request models -------------------------------------------------------
class OrderItemIn(BaseModel):
    product_id: int
    quantity: int = Field(gt=0)


class OrderIn(BaseModel):
    customer_id: int
    address_id: int
    payment_method: str = Field(min_length=1, max_length=50)
    items: list[OrderItemIn]


# ---- error mapping: message raised by the database function -> HTTP status -
DB_ERRORS = {
    "ADDRESS_INVALID": 400,
    "EMPTY_ORDER": 400,
    "QTY_INVALID": 400,
    "PRODUCT_NOT_FOUND": 404,
    "ORDER_NOT_FOUND": 404,
    "INSUFFICIENT_STOCK": 409,
}


def _raise_http(e: psycopg2.Error):
    message = (e.diag.message_primary or "").strip() if getattr(e, "diag", None) else ""
    status = DB_ERRORS.get(message.split(":")[0])
    if status:
        raise HTTPException(status_code=status, detail=message)
    if e.pgcode in ("23503", "23514", "22P02"):  # foreign key, check, bad input
        raise HTTPException(status_code=400, detail=message or "Invalid data")
    raise HTTPException(status_code=500, detail="Database error")


def _run(sql, params=(), one=False):
    conn = _connect()
    try:
        with conn:  # commits on success, rolls back on any error
            with conn.cursor(cursor_factory=RealDictCursor) as cur:
                cur.execute(sql, params)
                return cur.fetchone() if one else cur.fetchall()
    except psycopg2.Error as e:
        _raise_http(e)
    finally:
        conn.close()


# ---- endpoints ------------------------------------------------------------
@router.post("/orders", status_code=201)
def place_order(body: OrderIn):
    items = [{"product_id": i.product_id, "quantity": i.quantity} for i in body.items]
    row = _run(
        "SELECT place_order(%s, %s, %s::jsonb, %s) AS order_id",
        (body.customer_id, body.address_id, json.dumps(items), body.payment_method),
        one=True,
    )
    return {"order_id": row["order_id"]}


@router.get("/orders/{order_id}")
def get_order(order_id: int):
    order = _run(
        """SELECT o.order_id, o.customer_id, o.order_date, o.order_status, o.total_amount,
                  a.address_type, a.house_no, a.street, a.locality, a.city, a.state, a.pin_code
           FROM orders o JOIN address a ON a.address_id = o.address_id
           WHERE o.order_id = %s""",
        (order_id,), one=True,
    )
    if order is None:
        raise HTTPException(status_code=404, detail="ORDER_NOT_FOUND")
    order["items"] = _run(
        """SELECT oi.order_item_id, oi.product_id, p.product_name,
                  oi.quantity, oi.unit_price, oi.subtotal
           FROM order_item oi JOIN product p ON p.product_id = oi.product_id
           WHERE oi.order_id = %s ORDER BY oi.order_item_id""",
        (order_id,),
    )
    order["payment"] = _run(
        "SELECT payment_id, payment_method, payment_status, payment_date FROM payment WHERE order_id = %s",
        (order_id,), one=True,
    )
    order["shipment"] = _run(
        """SELECT shipment_id, shipment_status, shipment_date, delivery_date
           FROM shipment WHERE order_id = %s""",
        (order_id,), one=True,
    )
    return order


@router.get("/customers/{customer_id}/orders")
def order_history(customer_id: int):
    if _run("SELECT 1 FROM customer WHERE customer_id = %s", (customer_id,), one=True) is None:
        raise HTTPException(status_code=404, detail="CUSTOMER_NOT_FOUND")
    return _run(
        """SELECT o.order_id, o.order_date, o.order_status, o.total_amount,
                  COUNT(oi.order_item_id) AS item_count
           FROM orders o LEFT JOIN order_item oi ON oi.order_id = o.order_id
           WHERE o.customer_id = %s
           GROUP BY o.order_id
           ORDER BY o.order_date DESC""",
        (customer_id,),
    )
