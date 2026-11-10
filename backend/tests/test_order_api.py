"""Ordering API tests. Same setup as the seller tests (conftest.py): everything runs in one
rolled-back transaction, so the real data is never changed."""
import pytest

from backend.app.main import app
from backend.app.payments import GatewayError, SimulatedGateway, get_gateway


@pytest.fixture()
def customer(conn):
    with conn.cursor() as cur:
        cur.execute("INSERT INTO customer (name, email, phone) VALUES "
                    "('__API Test Customer__', '__api_cust__@example.in', '6999999921') RETURNING customer_id")
        cid = cur.fetchone()[0]
        cur.execute("INSERT INTO address (customer_id, address_type, house_no, street, locality, city, district, state, pin_code) "
                    "VALUES (%s,'Home','1','Main St','Loc','Bengaluru','Bengaluru Urban','Karnataka','560001') RETURNING address_id", (cid,))
        return {"customer_id": cid, "address_id": cur.fetchone()[0]}


@pytest.fixture()
def other_customer(conn):
    with conn.cursor() as cur:
        cur.execute("INSERT INTO customer (name, email, phone) VALUES "
                    "('__API Other Customer__', '__api_cust2__@example.in', '6999999922') RETURNING customer_id")
        return cur.fetchone()[0]


def place(client, customer, product, qty=2, method="UPI"):
    return client.post("/orders", json={"customer_id": customer["customer_id"], "address_id": customer["address_id"],
                                        "payment_method": method,
                                        "items": [{"product_id": product["product_id"], "quantity": qty}]})


def stock(conn, product):
    with conn.cursor() as cur:
        cur.execute("SELECT quantity_in_stock FROM product WHERE product_id = %s", (product["product_id"],))
        return cur.fetchone()[0]


def test_place_order_returns_pending_order_and_reduces_stock(client, conn, customer, product):
    res = place(client, customer, product, qty=2)
    assert res.status_code == 201, res.text
    o = res.json()
    assert o["status"] == "Pending" and float(o["total_amount"]) == 998.0
    assert o["payment"]["status"] == "Pending" and o["shipment"] is None
    assert o["items"][0]["quantity"] == 2 and o["timeline"][0]["event_type"] == "Order Pending"
    assert stock(conn, product) == 3


def test_not_enough_stock_is_409_and_nothing_changes(client, conn, customer, product):
    res = place(client, customer, product, qty=6)          # product has 5 in stock
    assert res.status_code == 409
    assert stock(conn, product) == 5


def test_foreign_address_is_400(client, conn, customer, other_customer, product):
    with conn.cursor() as cur:
        cur.execute("INSERT INTO address (customer_id, address_type, house_no, street, locality, city, district, state, pin_code) "
                    "VALUES (%s,'Home','9','X','L','C','D','S','560002') RETURNING address_id", (other_customer,))
        foreign = cur.fetchone()[0]
    res = client.post("/orders", json={"customer_id": customer["customer_id"], "address_id": foreign,
                                       "payment_method": "UPI", "items": [{"product_id": product["product_id"], "quantity": 1}]})
    assert res.status_code == 400


def test_bad_body_is_422(client, customer, product):
    res = client.post("/orders", json={"customer_id": customer["customer_id"], "address_id": customer["address_id"],
                                       "payment_method": "UPI", "items": []})
    assert res.status_code == 422


def test_unknown_order_is_404(client):
    assert client.get("/orders/999999999").status_code == 404


def test_payment_success_confirms_order_and_creates_shipment(client, customer, product):
    oid = place(client, customer, product).json()["order_id"]
    res = client.post(f"/orders/{oid}/payment", json={"customer_id": customer["customer_id"]})
    assert res.status_code == 200, res.text
    body = res.json()
    assert body["paid"] is True and body["order"]["status"] == "Confirmed"
    assert body["order"]["payment"]["status"] == "Successful" and body["order"]["payment"]["transaction_ref"].startswith("SIM-")
    assert body["order"]["shipment"]["status"] == "Pending"
    assert client.post(f"/orders/{oid}/payment", json={"customer_id": customer["customer_id"]}).status_code == 409


def test_declined_payment_can_be_retried(client, customer, product):
    oid = place(client, customer, product).json()["order_id"]
    cid = customer["customer_id"]
    res = client.post(f"/orders/{oid}/payment", json={"customer_id": cid, "simulate": "decline"})
    assert res.status_code == 200 and res.json()["paid"] is False
    assert res.json()["order"]["status"] == "Pending" and res.json()["order"]["payment"]["status"] == "Failed"
    res = client.post(f"/orders/{oid}/payment", json={"customer_id": cid})
    assert res.json()["paid"] is True and res.json()["order"]["payment"]["attempts"] == 2


def test_gateway_outage_is_502_and_records_nothing(client, customer, product):
    oid = place(client, customer, product).json()["order_id"]
    res = client.post(f"/orders/{oid}/payment", json={"customer_id": customer["customer_id"], "simulate": "error"})
    assert res.status_code == 502
    assert client.get(f"/orders/{oid}").json()["payment"]["attempts"] == 0


def test_cannot_pay_someone_elses_order(client, customer, other_customer, product):
    oid = place(client, customer, product).json()["order_id"]
    assert client.post(f"/orders/{oid}/payment", json={"customer_id": other_customer}).status_code == 403


def test_cancel_unpaid_order_restores_stock(client, conn, customer, product):
    oid = place(client, customer, product, qty=3).json()["order_id"]
    assert stock(conn, product) == 2
    res = client.post(f"/orders/{oid}/cancel", json={"customer_id": customer["customer_id"], "reason": "changed mind"})
    assert res.status_code == 200 and res.json()["refund"] is None
    assert res.json()["order"]["status"] == "Cancelled" and stock(conn, product) == 5
    assert client.post(f"/orders/{oid}/cancel", json={}).status_code == 409


def test_cancel_paid_order_refunds(client, conn, customer, product):
    oid = place(client, customer, product, qty=2).json()["order_id"]
    client.post(f"/orders/{oid}/payment", json={"customer_id": customer["customer_id"]})
    res = client.post(f"/orders/{oid}/cancel", json={"customer_id": customer["customer_id"]})
    body = res.json()
    assert res.status_code == 200 and body["refund"]["refunded"] is True and body["refund"]["refund_ref"].startswith("SIMREF-")
    assert body["order"]["payment"]["status"] == "Refunded" and body["order"]["shipment"]["status"] == "Cancelled"
    assert stock(conn, product) == 5


def test_failed_refund_keeps_the_order(client, customer, product):
    class BrokenRefund(SimulatedGateway):
        def refund(self, *a, **k):
            raise GatewayError("down")
    oid = place(client, customer, product).json()["order_id"]
    client.post(f"/orders/{oid}/payment", json={"customer_id": customer["customer_id"]})
    app.dependency_overrides[get_gateway] = BrokenRefund
    try:
        assert client.post(f"/orders/{oid}/cancel", json={}).status_code == 502
    finally:
        app.dependency_overrides.pop(get_gateway, None)
    assert client.get(f"/orders/{oid}").json()["status"] == "Confirmed"


def test_shipment_flow_and_tracking(client, customer, product):
    cid = customer["customer_id"]
    oid = place(client, customer, product).json()["order_id"]
    assert client.post(f"/orders/{oid}/shipment", json={"status": "Shipped"}).status_code == 409   # unpaid
    client.post(f"/orders/{oid}/payment", json={"customer_id": cid})
    assert client.post(f"/orders/{oid}/shipment", json={"status": "Delivered"}).status_code == 409  # cannot skip
    assert client.post(f"/orders/{oid}/shipment", json={"status": "Shipped", "carrier": "BlueDart"}).json()["status"] == "Shipped"
    assert client.post(f"/orders/{oid}/cancel", json={"customer_id": cid}).status_code == 409       # too late
    client.post(f"/orders/{oid}/shipment", json={"status": "In Transit"})
    assert client.post(f"/orders/{oid}/shipment", json={"status": "Delivered"}).json()["status"] == "Delivered"
    t = client.get(f"/orders/{oid}/tracking").json()
    assert t["status"] == "Delivered" and t["carrier"] == "BlueDart" and t["tracking_number"].startswith("TRK")
    assert [e["event_type"] for e in t["timeline"]][-1] == "Order Delivered"


def test_customer_endpoints(client, customer, product):
    cid = customer["customer_id"]
    place(client, customer, product, qty=1)
    assert client.get("/customers", params={"email": "__API_CUST__@example.in"}).json()["customer_id"] == cid
    assert len(client.get(f"/customers/{cid}/addresses").json()) == 1
    orders = client.get(f"/customers/{cid}/orders").json()
    assert len(orders) == 1 and orders[0]["status"] == "Pending" and orders[0]["item_count"] == 1
    assert client.get(f"/customers/{cid}/orders", params={"status": "Delivered"}).json() == []
    assert client.get(f"/customers/{cid}/orders", params={"status": "Nope"}).status_code == 400
    assert client.get("/customers/999999999").status_code == 404


def test_expire_unpaid(client, conn, customer, product):
    oid = place(client, customer, product).json()["order_id"]
    with conn.cursor() as cur:
        cur.execute("UPDATE orders SET order_date = LOCALTIMESTAMP - interval '2 hours' WHERE order_id = %s", (oid,))
    assert client.post("/orders/expire-unpaid", params={"minutes": 30}).json()["cancelled"] >= 1
    assert client.get(f"/orders/{oid}").json()["status"] == "Cancelled"
