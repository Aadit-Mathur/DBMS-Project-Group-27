"""Ordering endpoints. All business rules live in PostgreSQL functions/triggers
(db_testing/order_schema.sql); this file validates input, calls them inside ONE
transaction per request, talks to the payment gateway, and shapes the response.
"""
import json
from contextlib import contextmanager

import psycopg2
from fastapi import APIRouter, Depends, HTTPException, Query

from .. import db
from ..order_schemas import CancelIn, OrderCreate, PaymentIn, ShipmentUpdate
from ..payments import GatewayError, PaymentGateway, get_gateway

router = APIRouter(tags=["orders"])

# custom SQLSTATEs raised by the database -> HTTP status (documented in order_schema.sql)
ORDER_ERRORS = {"ORD01": 404, "ORD02": 400, "ORD03": 400, "ORD04": 404, "ORD05": 409,
                "ORD06": 409, "ORD07": 409, "ORD08": 404, "ORD09": 403, "ORD10": 409,
                "ORD11": 409, "ORD12": 409, "ORD13": 409}


@contextmanager
def order_transaction():
    """db.transaction() that turns the ordering error codes into HTTP errors."""
    try:
        with db.transaction() as cur:
            yield cur
    except psycopg2.Error as exc:
        status = ORDER_ERRORS.get(exc.pgcode)
        if status is None:
            raise                       # other database errors: handled by errors.py
        raise HTTPException(status_code=status, detail=exc.diag.message_primary) from exc


def load_order(cur, order_id: int) -> dict:
    cur.execute(
        """SELECT o.order_id, o.customer_id, o.order_status AS status, o.order_date, o.total_amount,
                  o.cancelled_at, o.cancel_reason,
                  a.address_id, a.address_type, a.house_no, a.street, a.locality, a.city,
                  a.district, a.state, a.pin_code
           FROM orders o JOIN address a ON a.address_id = o.address_id
           WHERE o.order_id = %s""", (order_id,))
    row = cur.fetchone()
    if row is None:
        raise HTTPException(status_code=404, detail="Order not found")
    address = {k: row.pop(k) for k in ("address_id", "address_type", "house_no", "street",
                                       "locality", "city", "district", "state", "pin_code")}
    row["address"] = address

    cur.execute(
        """SELECT oi.order_item_id, oi.product_id, p.product_name, oi.quantity, oi.unit_price, oi.subtotal
           FROM order_item oi JOIN product p ON p.product_id = oi.product_id
           WHERE oi.order_id = %s ORDER BY oi.order_item_id""", (order_id,))
    row["items"] = cur.fetchall()

    cur.execute(
        """SELECT payment_id, payment_method, payment_status AS status, amount, payment_date,
                  transaction_ref, attempts, failure_reason, refunded_at, refund_ref
           FROM payment WHERE order_id = %s""", (order_id,))
    row["payment"] = cur.fetchone()

    cur.execute(
        """SELECT shipment_id, shipment_status AS status, carrier, tracking_number,
                  shipment_date, delivery_date
           FROM shipment WHERE order_id = %s""", (order_id,))
    row["shipment"] = cur.fetchone()

    cur.execute(
        """SELECT event_time, event_type, detail FROM order_event
           WHERE order_id = %s ORDER BY event_time, event_id""", (order_id,))
    row["timeline"] = cur.fetchall()
    return row


@router.post("/orders", status_code=201)
def place_order(body: OrderCreate):
    items = [i.model_dump() for i in body.items]
    with order_transaction() as cur:
        cur.execute("SELECT place_order(%s, %s, %s::jsonb, %s) AS order_id",
                    (body.customer_id, body.address_id, json.dumps(items), body.payment_method))
        return load_order(cur, cur.fetchone()["order_id"])


@router.get("/orders/{order_id}")
def get_order(order_id: int):
    with order_transaction() as cur:
        return load_order(cur, order_id)


@router.get("/orders/{order_id}/tracking")
def track_order(order_id: int):
    with order_transaction() as cur:
        o = load_order(cur, order_id)
    ship = o["shipment"] or {}
    return {"order_id": o["order_id"], "status": o["status"],
            "payment_status": o["payment"]["status"],
            "shipment_status": ship.get("status"), "carrier": ship.get("carrier"),
            "tracking_number": ship.get("tracking_number"),
            "shipped_on": ship.get("shipment_date"), "delivered_on": ship.get("delivery_date"),
            "timeline": o["timeline"]}


@router.post("/orders/{order_id}/payment")
def pay_order(order_id: int, body: PaymentIn, gateway: PaymentGateway = Depends(get_gateway)):
    """Charge through the gateway and record the result, in one transaction.
    A declined payment is a normal answer (200, paid=false): the order stays Pending and can be retried.
    If the gateway is unreachable (502) nothing is recorded."""
    with order_transaction() as cur:
        cur.execute("SELECT begin_payment(%s, %s, %s) AS amount",
                    (order_id, body.customer_id, body.payment_method))
        amount = cur.fetchone()["amount"]
        cur.execute("SELECT payment_method FROM payment WHERE order_id = %s", (order_id,))
        method = cur.fetchone()["payment_method"]
        try:
            result = gateway.charge(order_id, amount, method, simulate=body.simulate)
        except GatewayError as exc:
            raise HTTPException(status_code=502, detail=f"Payment gateway unavailable: {exc}")
        cur.execute("SELECT record_payment(%s, %s, %s, %s) AS outcome",
                    (order_id, result.success, result.transaction_ref, result.failure_reason))
        order = load_order(cur, order_id)
    return {"paid": result.success,
            "message": "Payment successful" if result.success else result.failure_reason,
            "order": order}


@router.post("/orders/{order_id}/cancel")
def cancel_order(order_id: int, body: CancelIn | None = None,
                 gateway: PaymentGateway = Depends(get_gateway)):
    """Cancel before shipping. Stock is returned; a paid order is refunded through the gateway
    in the same transaction (if the refund fails, the order is NOT cancelled)."""
    body = body or CancelIn()
    refund = None
    with order_transaction() as cur:
        cur.execute("SELECT cancel_order(%s, %s, %s) AS outcome",
                    (order_id, body.customer_id, body.reason))
        outcome = cur.fetchone()["outcome"]
        if outcome == "CANCELLED_REFUNDED":
            cur.execute("SELECT transaction_ref, amount FROM payment WHERE order_id = %s", (order_id,))
            pay = cur.fetchone()
            try:
                res = gateway.refund(order_id, pay["transaction_ref"], pay["amount"])
            except GatewayError as exc:
                raise HTTPException(status_code=502, detail=f"Refund failed, order not cancelled: {exc}")
            cur.execute("UPDATE payment SET refund_ref = %s WHERE order_id = %s", (res.refund_ref, order_id))
            refund = {"refunded": True, "amount": pay["amount"], "refund_ref": res.refund_ref}
        order = load_order(cur, order_id)
    return {"order": order, "refund": refund}


@router.post("/orders/{order_id}/shipment")
def update_shipment(order_id: int, body: ShipmentUpdate):
    """Fulfilment (seller/admin UI): Shipped -> In Transit -> Delivered."""
    with order_transaction() as cur:
        cur.execute("SELECT advance_shipment(%s, %s, %s)", (order_id, body.status, body.carrier))
        return load_order(cur, order_id)


@router.post("/orders/expire-unpaid")
def expire_unpaid(minutes: int = Query(30, ge=1, le=10080)):
    """Cancel orders that stayed unpaid for more than `minutes` (call it from an admin button or a cron)."""
    with order_transaction() as cur:
        cur.execute("SELECT expire_unpaid_orders(make_interval(mins => %s)) AS cancelled", (minutes,))
        return {"cancelled": cur.fetchone()["cancelled"]}
