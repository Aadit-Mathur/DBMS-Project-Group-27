# Admin Dashboard API (for the frontend)

Base URL (local): `http://127.0.0.1:8000`. Interactive version with "Try it out": `/docs` (use the **Authorize** button to enter the key).
Every endpoint is **read-only** (`GET`) and returns JSON. Money comes back as numbers in rupees; dates are ISO strings (`2026-08-01`).
The raw SQL behind each endpoint is in `db_testing/queries/admin_queries.sql` (query numbers below match its `Q` labels).

## Authentication
There are no user accounts, so the admin routes use a shared secret. Send it in every request:

```
X-Admin-Key: <value of ADMIN_API_KEY from .env>
```

| Code | Meaning |
|---|---|
| 401 | `X-Admin-Key` header missing or wrong |
| 422 | bad query parameter (not a date, `interval` not `day`/`week`/`month`, `limit` out of range) |
| 503 | `ADMIN_API_KEY` is not set on the server |

## Definitions
- **Revenue** = orders whose payment has `payment_status = 'Successful'`. Pending, failed and refunded payments are not revenue.
- **Date window** (`date_from`, `date_to`, both optional, `YYYY-MM-DD`) filters `orders.order_date`. `date_to` is **inclusive** (the whole day counts).
  Leave a bound out for "no limit on that side". A window with no orders returns zeros / `[]`, not an error.
  (`/admin/new-customers` filters `customer.registration_date` instead; `/admin/low-stock` and `/admin/overview` have no date window.)

## Endpoints

| Endpoint | Extra params | Query | Returns |
|---|---|---|---|
| `GET /admin/summary` | | Q1a | one object: `total_orders, paid_orders, revenue, avg_order_value, refunded_amount` |
| `GET /admin/revenue-trend` | `interval` = `day`\|`week`\|`month` (default `day`) | Q1b | list of `{period, orders, revenue}`, oldest first |
| `GET /admin/orders-by-status` | | Q2 | list of `{status, orders}` in lifecycle order (Pending, Confirmed, Shipped, Delivered, Cancelled) |
| `GET /admin/top-products` | `limit` 1-50 (default 10) | Q3a | `{product_id, product_name, seller_name, units_sold, revenue}`, best first |
| `GET /admin/top-sellers` | `limit` 1-50 (default 10) | Q3b | `{seller_id, seller_name, orders, units_sold, revenue}`, best first |
| `GET /admin/sales-by-category` | | Q4 | `{category_id, category_name, units_sold, revenue, pct_of_revenue}`, biggest first |
| `GET /admin/low-stock` | `limit` 1-500 (default 50) | Q5 | `{product_id, product_name, seller_name, category_name, quantity_in_stock, reorder_level, shortfall}` |
| `GET /admin/payments` | | Q6 | `{method, status, payments, amount}` per payment method and status |
| `GET /admin/new-customers` | `interval` (default `month`) | Q7 | list of `{period, new_customers}` |
| `GET /admin/shipments` | | Q8 | `{status, shipments, avg_days_to_deliver}` (days only filled for `Delivered`, else `null`) |
| `GET /admin/overview` | | Q9 | one object: `customers, sellers, products, active_products` (live counts, no date window) |

## Example
```
GET /admin/summary?date_from=2026-10-01&date_to=2026-10-31
X-Admin-Key: ...

{"total_orders": 98, "paid_orders": 88, "revenue": 2230966.0, "avg_order_value": 25351.89, "refunded_amount": 15800.0}
```
Response samples (all data, no date window):
```
/admin/summary          {"total_orders": 302, "paid_orders": 238, "revenue": 5344215.0, "avg_order_value": 22454.68, "refunded_amount": 342325.0}
/admin/revenue-trend    [{"period": "2026-08-01", "orders": 54, "revenue": 1051554.0}, ...]     (interval=month)
/admin/sales-by-category [{"category_id": 3, "category_name": "Computers & Laptops", "units_sold": 52, "revenue": 1734123.0, "pct_of_revenue": 32.4}, ...]
```

## Database features each endpoint demonstrates (for the viva)
| Feature | Where |
|---|---|
| `GROUP BY` + aggregates (`COUNT`, `SUM`, `AVG`) | all |
| Multi-table `JOIN`s (up to 5 tables) | top-products, top-sellers, sales-by-category |
| `FILTER (WHERE ...)` conditional aggregation | summary, shipments |
| Window function `SUM(SUM(x)) OVER ()` | sales-by-category (`pct_of_revenue`) |
| View `v_low_stock_products` | low-stock |
| `date_trunc` time bucketing (unit whitelisted, never raw user input) | revenue-trend, new-customers |
| Scalar subqueries | overview |
| Parameterised queries (`%(name)s`), so no SQL injection | all |

## Tests
`pytest backend/tests/test_admin_api.py -v` (57 tests: key check on every endpoint, input validation, date filters, empty and inverted ranges,
and consistency checks such as "two half-ranges add up to the whole" and "trend total equals summary revenue"). All changes are rolled back.
