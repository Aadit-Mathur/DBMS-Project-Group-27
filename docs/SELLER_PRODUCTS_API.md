# Seller & Products API (for the frontend)

Base URL (local): `http://127.0.0.1:8000`. Interactive version with "Try it out": `/docs`.
Bodies and responses are JSON. `price` and `inventory_value` come back as numbers in rupees; dates are ISO strings.
CORS is open, so the pages can be served from any origin.

There is **no login**: the seller portal finds the seller once (`GET /sellers?email=`), keeps `seller_id`,
puts it in the URL for `/sellers/{seller_id}/...` routes and in the **`X-Seller-Id` header** for the
`/products/{product_id}` routes that change a product. A request with another seller's id gets 403.

## The seller workflow

```
POST /sellers                        register          (or GET /sellers?email= for a returning seller)
POST /sellers/{id}/products          add a product under an existing category (GET /categories)
GET  /sellers/{id}/dashboard         products, units, stock value, low-stock count
GET  /sellers/{id}/products          own catalog         GET /sellers/{id}/low-stock   reorder alerts
PATCH  /products/{id}                edit details or price (not stock)
POST   /products/{id}/restock        add stock
DELETE /products/{id}                remove: deleted if never ordered, otherwise delisted (hidden)
POST   /products/{id}/relist         put a delisted product back on sale
```

Stock changes in exactly three ways: restocking (here), placing an order (decrease) and cancelling one
(increase), both in the Ordering API. It cannot be edited directly, and the database refuses to let it go below 0.

## Errors
| Code | Meaning |
|---|---|
| 400 | a database rule was broken (negative price, phone not 10 to 15 digits, bad email, unknown category, restock quantity 0 or less) |
| 403 | the product belongs to another seller |
| 404 | seller or product not found |
| 409 | duplicate (email or phone already registered, the seller already has a product with this name) |
| 422 | malformed request (wrong type, missing or unknown field, missing `X-Seller-Id`) |

Database-rule errors look like
`{"error": "Price cannot be negative.", "detail": "...", "constraint": "chk_product_price", "sqlstate": "23514"}`: show `error`.
403 and 404 look like `{"detail": "Product not found."}`: show `detail`. Handle both keys (same as the Ordering API).

## Seller endpoints

### Register: `POST /sellers` -> 201
Request: `{"name": "Asha Traders", "email": "asha@example.in", "phone": "9876543210"}`
Response: `{seller_id, name, email, phone, registration_date}`.
Errors: 400 phone / email format, 409 email or phone already registered.

### Find a seller ("login"): `GET /sellers?email=asha@example.in` -> 200
Response: `{seller_id, name, email, phone, registration_date}`. The match ignores case. 404 if unknown.
`GET /sellers/{seller_id}` returns the same object.

### Dashboard: `GET /sellers/{seller_id}/dashboard` -> 200
`{"seller_id": 3, "name": "Asha Traders", "active_products": 12, "units_in_stock": 340, "inventory_value": 182450.0, "low_stock_products": 2}`
Delisted products are not counted. `low_stock_products` is the number of rows the low-stock list returns.

### Own catalog: `GET /sellers/{seller_id}/products?include_inactive=false` -> 200
List of `{product_id, product_name, brand, price, quantity_in_stock, reorder_level, is_active, last_updated, category_id, category_name}`,
ordered by name. Send `include_inactive=true` to also get delisted products (to show a "Relist" button).

### Add a product: `POST /sellers/{seller_id}/products` -> 201
Request (the last four fields are optional; defaults shown):
```json
{"category_id": 4, "product_name": "Steel Bottle 1L", "price": 499.00,
 "description": null, "brand": null, "quantity_in_stock": 0, "reorder_level": 10}
```
Response: the full product row. Errors: 400 negative price / stock / reorder level or unknown category,
404 unknown seller, 409 the seller already has a product with this name.

### Low-stock alerts: `GET /sellers/{seller_id}/low-stock` -> 200
List of `{product_id, product_name, category_name, quantity_in_stock, reorder_level, shortfall}` for active products
with `quantity_in_stock <= reorder_level`, largest `shortfall` (= reorder level - stock) first.

## Product endpoints (seller; send `X-Seller-Id`)

### Edit: `PATCH /products/{product_id}` -> 200
Send only the fields that change, out of `category_id, product_name, description, brand, price, reorder_level`,
e.g. `{"price": 549.00}`. Response: the full product row, with a new `last_updated`.
`quantity_in_stock` is not accepted here (422): use restock. Errors: 400 nothing to update / rule broken, 403, 404, 409 name already used.

### Restock: `POST /products/{product_id}/restock` -> 200
Request: `{"quantity": 20}`. Response: `{"product_id": 12, "quantity_in_stock": 25}` (the new stock).
Errors: 400 quantity 0 or less, 403, 404.

### Remove: `DELETE /products/{product_id}`
- **204**, no body: the product was never ordered and is deleted.
- **200**, `{"product_id": 12, "is_active": false, "status": "delisted", "reason": "..."}`: the product appears in at least
  one order, so it is kept for the order history and hidden from customers instead.

Check the status code, not the body. Errors: 403, 404.

### Relist: `POST /products/{product_id}/relist` -> 200
Puts a delisted product back on sale. Response: the full product row with `is_active: true`. Errors: 403, 404.

## Shop endpoints (customer; no header)

### Search: `GET /products?q=&category_id=&min_price=0&max_price=&in_stock_only=false&limit=20&offset=0` -> 200
All filters are optional. `q` matches the product name or brand, ignoring case. Only active products are returned,
cheapest first: `[{product_id, product_name, brand, price, in_stock, category_id, category_name, seller_id, seller_name}]`.
`limit` is 1 to 100; page with `offset`.

### Product page: `GET /products/{product_id}` -> 200
`{product_id, product_name, description, brand, price, quantity_in_stock, in_stock, reorder_level, is_active, last_updated, category_id, category_name, seller_id, seller_name}`.
A delisted product is still returned (an old order may link to it) with `is_active: false`: do not show "Add to cart" for it.
Ordering it fails with 409 anyway. 404 if the id is unknown.

### Categories: `GET /categories` -> 200
`[{category_id, category_name, description, active_products}]`, ordered by name. Use it for the shop's category filter
and for the category dropdown in the seller's "Add product" form.

## Database objects behind this module
`db_testing/seller_product_schema.sql` (safe to re-run): CHECK, UNIQUE and FOREIGN KEY constraints on `seller`, `category`
and `product`; trigger `trg_product_touch` (sets `last_updated`); view `v_low_stock_products`; function
`restock_product(seller_id, product_id, qty)`; indexes `idx_product_category_price` and `idx_product_low_stock`.
Report queries: `db_testing/queries/seller_product_queries.sql`. Rule tests: `db_testing/tests/seller_product_constraint_tests.sql`.
