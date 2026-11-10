# Ordering API (for the frontend)

Base URL (local): `http://127.0.0.1:8000`. Interactive version with "Try it out": `/docs`.
Bodies and responses are JSON. Money is a number in rupees. Times are ISO strings, server local time.
There is **no login**: the frontend finds the customer once (`GET /customers?email=`), keeps `customer_id`, and sends it where noted.

## The order lifecycle

```
POST /orders            -> order Pending, payment Pending, stock reserved
POST /orders/{id}/payment
     paid=true          -> order Confirmed, payment Successful, shipment Pending
     paid=false         -> order stays Pending, payment Failed (retry the same call)
POST /orders/{id}/cancel     (only while Pending or Confirmed)  -> Cancelled, stock returned, refund if paid
POST /orders/{id}/shipment   Shipped -> In Transit -> Delivered   (seller/admin screen)
GET  /orders/{id}/tracking   timeline for the customer
```

| Status field | Values |
|---|---|
| order `status` | `Pending`, `Confirmed`, `Shipped`, `Delivered`, `Cancelled` |
| payment `status` | `Pending`, `Successful`, `Failed`, `Refunded` |
| shipment `status` | `Pending`, `Shipped`, `In Transit`, `Delivered`, `Cancelled` |

Payment methods: `UPI`, `Credit Card`, `Debit Card`, `Net Banking`, `Wallet`.
An unpaid order is cancelled automatically by `POST /orders/expire-unpaid` (default 30 min).
Revenue = orders whose payment is `Successful` (cancelled/refunded orders are excluded).

## Errors
| Code | Meaning |
|---|---|
| 400 | invalid value (e.g. address not the customer's) |
| 403 | the order belongs to another customer |
| 404 | customer / order / product not found |
| 409 | action not allowed now (not enough stock, already paid, already shipped, product delisted...) |
| 422 | malformed request body (wrong type, missing field, empty `items`) |
| 502 | payment gateway unreachable; nothing was recorded, try again |

Business-rule errors look like `{"detail": "Only 1 unit(s) of product 12 in stock (requested 3)"}`. Show `detail` to the user.
Constraint errors from the database layer look like `{"error": "...", "constraint": "..."}`. Handle both keys.

## Endpoints

### Customer lookups
- `GET /customers?email=a@b.com` -> `{customer_id, name, email, phone}` (404 if unknown)
- `GET /customers/{customer_id}/addresses` -> list of `{address_id, address_type, house_no, street, locality, city, district, state, pin_code}`
- `GET /customers/{customer_id}/orders?status=&limit=20&offset=0` -> order history, newest first:
  `[{order_id, order_date, status, total_amount, item_count, payment_status, shipment_status, tracking_number}]`

### Place an order: `POST /orders` -> 201
Request:
```json
{"customer_id": 5, "address_id": 9, "payment_method": "UPI",
 "items": [{"product_id": 12, "quantity": 2}, {"product_id": 40, "quantity": 1}]}
```
The cart lives in the frontend. Prices come from the database at this moment and are fixed on the order.
Response: the **order object** (below). Errors: 404 customer/product, 400 address or empty items, 409 out of stock / delisted.

### Pay: `POST /orders/{order_id}/payment` -> 200
Request: `{"customer_id": 5}`. Optional: `"payment_method": "Wallet"` (change method), `"simulate": "decline"` (see below).
Response: `{"paid": true, "message": "Payment successful", "order": {...}}`.
A declined card is **not an HTTP error**: `paid` is `false`, `message` says why, the order stays `Pending`; call again to retry.
Errors: 403 not your order, 409 already paid or order cancelled, 502 gateway down.

**Simulated gateway** (until a real one is plugged in): omit `simulate` or send `"success"` -> approved; `"decline"` -> card declined; `"error"` -> gateway outage (502). Use these to build and demo the failure screens.

### Cancel: `POST /orders/{order_id}/cancel` -> 200
Request: `{"customer_id": 5, "reason": "ordered by mistake"}` (both optional; omit `customer_id` for an admin cancel).
Response: `{"order": {...}, "refund": null}` for an unpaid order, or
`{"order": {...}, "refund": {"refunded": true, "amount": 998.0, "refund_ref": "SIMREF-..."}}` for a paid one.
Errors: 403, 409 if already shipped/delivered/cancelled, 502 if the refund failed (the order is then not cancelled).

### Track: `GET /orders/{order_id}/tracking` -> 200
```json
{"order_id": 1, "status": "Shipped", "payment_status": "Successful", "shipment_status": "In Transit",
 "carrier": "BlueDart", "tracking_number": "TRK000000001", "shipped_on": "...", "delivered_on": null,
 "timeline": [{"event_time": "...", "event_type": "Order Pending", "detail": "Order placed"},
              {"event_time": "...", "event_type": "Payment Successful", "detail": null}]}
```
Render `timeline` top to bottom; `event_type` is `Order|Payment|Shipment <status>`.

### Order details: `GET /orders/{order_id}` -> the order object
```json
{"order_id": 1, "customer_id": 5, "status": "Confirmed", "order_date": "...", "total_amount": 998.0,
 "cancelled_at": null, "cancel_reason": null,
 "address": {"address_id": 9, "address_type": "Home", "house_no": "1", "street": "...", "locality": "...",
             "city": "...", "district": "...", "state": "...", "pin_code": "560001"},
 "items": [{"order_item_id": 1, "product_id": 12, "product_name": "...", "quantity": 2, "unit_price": 499.0, "subtotal": 998.0}],
 "payment": {"payment_id": 1, "payment_method": "UPI", "status": "Successful", "amount": 998.0, "payment_date": "...",
             "transaction_ref": "SIM-1-ab12cd34", "attempts": 1, "failure_reason": null, "refunded_at": null, "refund_ref": null},
 "shipment": {"shipment_id": 1, "status": "Pending", "carrier": null, "tracking_number": null, "shipment_date": null, "delivery_date": null},
 "timeline": [...]}
```
`shipment` is `null` until the order is paid. These examples show the field names and types; they were written by hand from the code, not captured from a running server.

### Fulfilment: `POST /orders/{order_id}/shipment` -> order object
Request: `{"status": "Shipped", "carrier": "BlueDart"}`, then `{"status": "In Transit"}`, then `{"status": "Delivered"}`.
409 if the order is unpaid or the step is skipped or repeated.

### Maintenance: `POST /orders/expire-unpaid?minutes=30` -> `{"cancelled": 3}`
Cancels `Pending` orders older than `minutes` and returns the stock. Wire to an admin button or a scheduler.

## For the Admin dashboard
Read revenue from the SQL view `v_paid_orders` (paid orders only, one row per order, with `paid_amount`, `payment_date`).
`v_order_summary` has one row per order with payment and shipment status. `db_testing/queries/order_queries.sql` has ready queries.

## Switching to a real payment gateway
Only `backend/app/payments.py` changes: add a class with `charge(...)` and `refund(...)`, register it in `GATEWAYS`, set `PAYMENT_GATEWAY=<name>` in `.env`. The frontend must then send the provider's payment token instead of `simulate` (add the field to `PaymentIn`).
