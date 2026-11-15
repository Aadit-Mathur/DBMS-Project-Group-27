# Bazaar – marketplace frontend (Group 27 DBMS project)

Plain HTML / CSS / vanilla JS (ES modules). **No build step.** Chart.js is the vendored `js/vendor/chart.umd.js`; Google Fonts (Inter + Plus Jakarta Sans) are the only CDN dependency and have system fallbacks.

## Run

```bash
# 1. database + backend (from the repo root)
python db_testing/restore_database.py --database-url "postgresql://user:pw@localhost:5432/ecommerce_local"
#    .env:  DATABASE_URL=...   ADMIN_API_KEY=admin
uvicorn backend.app.main:app --reload            # http://127.0.0.1:8000

# 2. frontend (any static server)
cd frontend && python -m http.server 8080        # open http://127.0.0.1:8080
```

API base URL lives in `js/config.js` (`http://127.0.0.1:8000`; same-origin when served on port 8000). Override without editing: `localStorage.setItem('mk_api_base','https://host')`.

Demo identities (no passwords exist in the backend): customer `customer0001@example.in`, seller `seller0001@example.in`, admin key = `ADMIN_API_KEY` (`admin`).

## Structure

```
index.html                 landing: role picker + sign-in / seller registration
css/  tokens.css (design tokens, light+dark) · base.css · components.css · layout.css
js/   config.js · api.js (fetch wrapper, error mapping) · state.js (session, per-customer cart)
      theme.js · toast.js · modal.js (<dialog>, confirm, validated form modal) · dom.js (skeletons, states, validation)
      format.js (money, dates, badges, category art) · icons.js · layout.js (navbar / sidebar shells) · pages/landing.js
customer/  shop · product · cart · checkout · orders · order (detail, tracking, pay, cancel)   (.html + .js)
seller/    seller.html (Dashboard · Products · Orders via sidebar)
admin/     admin.html  (Overview · Operations, Chart.js)
```

## Feature → endpoint map

| UI | Endpoint(s) |
|---|---|
| Customer sign-in | `GET /customers?email=` |
| Shop: search, category, price, in-stock filters, load more | `GET /products?q&category_id&min_price&max_price&in_stock_only&limit&offset`, `GET /categories` |
| Product page | `GET /products/{id}` |
| Cart (price/stock refresh) | `GET /products/{id}` (cart itself is localStorage) |
| Checkout | `GET /customers/{id}/addresses`, `POST /orders` |
| Pay (incl. retry after decline) | `POST /orders/{id}/payment` |
| Order history (status filter) | `GET /customers/{id}/orders?status&limit&offset` |
| Order detail, tracking timeline | `GET /orders/{id}` (`/orders/{id}/tracking` is a subset of it, so not called) |
| Cancel order (refund if paid) | `POST /orders/{id}/cancel` |
| Seller sign-in / register | `GET /sellers?email=`, `POST /sellers` |
| Seller dashboard, low stock | `GET /sellers/{id}/dashboard`, `GET /sellers/{id}/low-stock` |
| Seller products | `GET /sellers/{id}/products?include_inactive`, `POST /sellers/{id}/products` |
| Edit / restock / delist / relist | `PATCH /products/{id}`, `POST /products/{id}/restock`, `DELETE /products/{id}` (204 deleted, 200 delisted), `POST /products/{id}/relist` (seller routes send `X-Seller-Id`) |
| Seller orders + shipment update | `GET /sellers/{id}/orders`, `POST /orders/{id}/shipment` |
| Admin overview charts | `GET /admin/overview, summary, revenue-trend, orders-by-status, sales-by-category, top-products` (send `X-Admin-Key`) |
| Admin operations | `GET /admin/top-sellers, payments, shipments, low-stock, new-customers`, `POST /orders/expire-unpaid` |

Not used: `PUT /sellers/{id}/products/{pid}` (superseded by `PATCH`, which does not touch stock), `GET /sellers/{id}`, `GET /customers/{id}`, `GET /health`.

## Unavailable (no backend endpoint)

- **Customer registration** and **adding a delivery address**: only existing customers/addresses can be used; checkout explains this when no address exists.
- **Low-stock badge on shop cards**: `GET /products` returns only `in_stock` (boolean), so cards show *In stock / Out of stock*; *Low stock · N left* appears on the product page and in seller tables, where quantities are returned.
- Sorting products (backend always sorts by price), product images (none in the data).

## Backend changes

None. CORS (`*`, all headers) already allows the `X-Seller-Id` / `X-Admin-Key` headers.

## Assumptions / notes

- Shipment updates act on the whole order (backend `advance_shipment`), even if it contains other sellers' items; the UI says so.
- Payment uses the backend's simulated gateway; the pay dialog exposes its `simulate` option (approve / decline / outage) for demos.
- Ownership of orders is only checked client-side (backend `GET /orders/{id}` has no auth); there is no real authentication in this project.
