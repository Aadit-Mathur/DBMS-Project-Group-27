# E-Commerce Marketplace — DBMS Project, Group 27 (CS F212)

**Final commit:** `<PASTE FULL COMMIT HASH HERE>` (tag `final`)  
**Team ID / Lab section:** `<FILL IN>`

A marketplace where sellers list products, customers browse and buy, and orders move through payment and shipment. Business rules live in PostgreSQL (constraints, triggers, transactional functions, views); a FastAPI backend exposes them and a plain HTML/JS frontend uses the API.

## Team

| Member | ID | Contribution |
|---|---|---|
| Aadit Mathur | 2024AAPS0310H | Repository setup, database design (ER diagram, relational schema), business rules, Neon population, restore scripts |
| Aarav Gang | 2024AAPS0328H | Ordering backend: place / pay / cancel-refund / ship / track, status-flow triggers, order timeline, payment-gateway abstraction, order SQL tests and queries, ordering API docs |
| Divvij Yogesh Chichra | 2024AAPS0298H | Seller and product backend: catalog, stock, restock, delist/relist, low-stock view, seller API docs |
| Yash Agarwal | 2024AAPS0294H | Admin backend: authenticated analytics endpoints (`/admin/*`), revenue and sales queries |
| Rithwik Rudra | 2024AAPS0260H | Frontend (customer, seller, admin pages), frontend–backend integration, dashboard reports |

## Technology stack
PostgreSQL 16+ (Neon or local) · Python 3.11+ · FastAPI · psycopg2 · plain HTML/CSS/JavaScript · pytest · SQL / PL/pgSQL

## Database (11 tables)
Domain tables (10): `customer`, `address`, `seller`, `category`, `product`, `orders`, `order_item`, `payment`, `shipment`, `order_event` (order timeline).
Plus `order_fn_backup`, a small table that stores earlier versions of functions replaced during a migration (not used by the application).
The sample data has about 6,500 rows (600 customers, 1,560 addresses, 200 sellers, 18 categories, 801 products, 302 orders, 605 order lines, 302 payments, 251 shipments, 1,914 order events).

## Workflows
1. **Customer purchase:** browse/search products → cart → choose address → place order → pay → track shipment (`place_order`, `begin_payment`, `record_payment`; one transaction each).
2. **Seller fulfilment:** seller dashboard → manage products and stock (restock, delist) → see orders containing their products → ship (`advance_shipment`: Shipped → In Transit → Delivered).
3. **Admin reporting:** dashboard of customers, sellers, products, revenue (paid orders only), top products, sales by category, orders by status.

Also available through the API: cancel with refund (`cancel_order`), automatic expiry of unpaid orders (`expire_unpaid_orders`), declined-payment retry.

## DBMS features (file → object)
| Feature | Where |
|---|---|
| Transactions + row locking (no overselling) | `db_testing/order_schema.sql` → `place_order`, `cancel_order` |
| Triggers: order total, frozen order lines, status flows, timeline | `db_testing/order_schema.sql` → `trg_order_item_total`, `trg_order_item_frozen`, `trg_orders_guard`, `trg_payment_flow`, `trg_shipment_flow`, `trg_*_event`; `trg_product_touch` in `seller_product_schema.sql` |
| Views | `v_paid_orders` (revenue = successful payments only), `v_order_summary`, `v_low_stock_products` |
| Indexes (partial, composite) | `idx_orders_pending`, `idx_payment_successful`, `idx_orders_customer`, `idx_product_category_price`, `idx_product_low_stock` |
| Constraints | PK/FK, UNIQUE, CHECK on every table; composite FK `orders(address_id, customer_id)` → `address` |
| Queries | `db_testing/queries/order_queries.sql` (10), `db_testing/queries/seller_product_queries.sql`, `backend/app/routers/admin.py` |
| SQL tests | `db_testing/tests/order_constraint_tests.sql` (92 checks), `seller_product_constraint_tests.sql` (17) |

## Setup (macOS; Windows notes below)

### 1. Database
Pick one.

**A. Local PostgreSQL (works offline, recommended for the demo).** Install PostgreSQL 16 or newer (`brew install postgresql@16`, or Postgres.app) and make sure `psql` works.
```bash
createdb ecommerce_local
python3 db_testing/restore_database.py --database-url "postgresql://localhost:5432/ecommerce_local"
```
(If your local user needs a password: `postgresql://USER:PASSWORD@localhost:5432/ecommerce_local`.)

**B. Neon.** Create an empty branch/database and pass its connection string to the same command.

Check the data: `psql ecommerce_local -c "select count(*) from orders"` should print 302.

### 2. Backend
```bash
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
uvicorn backend.app.main:app --reload
```
Create a file named `.env` in the repository root (it is git-ignored, never commit it):
```
DATABASE_URL=postgresql://localhost:5432/ecommerce_local
ADMIN_API_KEY=choose-any-secret
```
API docs and a health check: http://127.0.0.1:8000/docs and http://127.0.0.1:8000/health. `ADMIN_API_KEY` is only needed for the authenticated `/admin/*` endpoints.

### 3. Frontend
The backend must be running. In a second terminal:
```bash
cd frontend
python3 -m http.server 5500
```
Open http://127.0.0.1:5500/ and follow the links (customer shop, seller portal, admin dashboard). The pages call the API at `http://127.0.0.1:8000`.
There are no passwords: customers and sellers sign in with their email address, for example `customer0448@example.in` and `seller0106@example.in`.

### 4. Tests
```bash
pytest                                                              # API tests (use DATABASE_URL; each test rolls back)
python3 db_testing/run_sql.py db_testing/tests/order_constraint_tests.sql
python3 db_testing/run_sql.py db_testing/tests/seller_product_constraint_tests.sql
```
SQL tests also run directly with `psql -f`. Run tests against a local or dev database, not against the database used for the live demo.

### Windows
Use `python -m venv .venv`, `.\.venv\Scripts\Activate.ps1`, and `py -m http.server 5500`; the rest is identical.

## Repository layout
`backend/app/` API · `backend/tests/` API tests · `frontend/` pages and scripts · `db_testing/` schema, functions, SQL tests, queries, restore helper · `reconstruct_database/` schema and sample-data dump · `Populate_DB/` data generators and order seed · `docs/` API references · `Reference/` design documents
