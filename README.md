# E-Commerce Marketplace: DBMS Project, Group 27

A full-stack e-commerce marketplace built over a relational database.
Customers browse and order products, sellers manage their catalog and
inventory, and an admin dashboard shows platform statistics. The focus of
the project is the database: the ER design, the relational schema, integrity
constraints, and DBMS features such as triggers, views, stored functions,
indexes and transactions.

Repository: https://github.com/Aadit-Mathur/DBMS-Project-Group-27

## Team

| Name | ID | Role |
|---|---|---|
| TODO | TODO | Database design, ER diagram, implementation |
| TODO | TODO | Ordering backend |
| Divvij Yogesh Chichra | TODO | Seller & Products backend |
| TODO | TODO | Admin backend |
| TODO | TODO | Frontend |

## Technology stack

| Layer | Technology |
|---|---|
| Database | PostgreSQL, hosted on Neon |
| Backend | Python, FastAPI, psycopg2 (plain SQL, no ORM) |
| Frontend | TODO |
| Data population | Python scripts (`Populate_DB/`) |
| Testing | pytest; SQL constraint tests |

## Repository structure

```
Populate_DB/                  scripts that fill the database with sample data
db/
  seller_product_schema.sql   SELLER, CATEGORY, PRODUCT schema (safe to re-run)
  run_sql.py                  runs any .sql file against the database (no psql needed)
  inspect_constraints.sql     lists every constraint, index and trigger (read-only)
  queries/                    non-trivial queries for the report
  tests/                      SQL tests that try to break each rule, then roll back
backend/app/                  FastAPI application (one router per module)
backend/tests/                API tests (rolled back)
```

## Setup and running (Windows PowerShell)

1. Clone the repository and create a virtual environment:
   ```powershell
   git clone https://github.com/Aadit-Mathur/DBMS-Project-Group-27.git
   cd DBMS-Project-Group-27
   python -m venv .venv
   .venv\Scripts\Activate.ps1
   pip install -r requirements.txt
   ```
2. Create a `.env` file in the repository root. It is git-ignored; never commit it.
   ```
   DATABASE_URL=postgresql://<user>:<password>@<host>/neondb?sslmode=require
   ```
3. Create or upgrade the schema (safe to run more than once):
   ```powershell
   python db\run_sql.py db\seller_product_schema.sql
   ```
4. On an empty database, load sample data in this order:
   ```powershell
   python Populate_DB\customer_seller_category.py
   python Populate_DB\products_varied.py
   python Populate_DB\addresses.py
   ```
5. Run the API and open the interactive docs at http://127.0.0.1:8000/docs:
   ```powershell
   uvicorn backend.app.main:app --reload
   ```
6. Run the tests. Every change they make is rolled back, so this is safe on Neon:
   ```powershell
   python db\run_sql.py db\tests\seller_product_constraint_tests.sql
   pytest
   ```

## Database rules (Seller & Products)

Every rule is enforced by PostgreSQL itself, so bad data is rejected even if
a client skips the API. Constraint names follow the team convention:
`chk_` CHECK, `uq_` UNIQUE, `fk_` foreign key, `idx_` index, `trg_` trigger.

| Rule | Enforced by |
|---|---|
| Price cannot be negative | `chk_product_price` (price >= 0) |
| Stock and reorder level cannot be negative | `chk_product_stock`, `chk_product_reorder_level` |
| Seller phone is 10 to 15 digits | `chk_seller_phone` |
| Seller email has a valid shape | `chk_seller_email` |
| Seller email and phone are unique | UNIQUE on `seller(email)`, `seller(phone)` |
| A seller cannot list two products with the same name | `uq_product_seller_name` |
| A product must belong to an existing seller and category | `fk_product_seller`, `fk_product_category` (ON DELETE RESTRICT) |
| `last_updated` changes on every product edit | trigger `trg_product_touch` |
| Restocking adds stock only to the seller's own product, quantity > 0 | function `restock_product(seller_id, product_id, qty)` |
| Products that appear in past orders are delisted, not deleted | `product.is_active` + RESTRICT on `order_item.product_id` |

When the database rejects a request, the API turns the PostgreSQL error code
into an HTTP status: CHECK / NOT NULL / bad input → 400, UNIQUE → 409,
foreign key → 400 (missing reference) or 409 (row still in use),
permission → 403.

## API endpoints (Seller & Products module)

| Method | Path | Purpose |
|---|---|---|
| POST | `/sellers` | Register a seller |
| GET | `/sellers/{id}/dashboard` | Product count, units in stock, inventory value, low-stock count |
| GET | `/sellers/{id}/products` | The seller's catalog (`include_inactive` to show delisted) |
| POST | `/sellers/{id}/products` | Add a product |
| GET | `/sellers/{id}/low-stock` | Products at or below their reorder level (view `v_low_stock_products`) |
| GET | `/products` | Search by keyword, category, price range, in-stock only |
| PATCH | `/products/{id}` | Edit a product (header `X-Seller-Id`; only the owner) |
| POST | `/products/{id}/restock` | Add stock (header `X-Seller-Id`) |
| DELETE | `/products/{id}` | Delete, or delist if it is in past orders (header `X-Seller-Id`) |
| GET | `/categories` | List categories |
| GET | `/health` | Database connection check |

## Application workflows

1. **Seller manages products and inventory** (integrity enforcement). A seller
   registers, adds products, views a dashboard, edits, restocks and removes
   products. Every step is checked by the database rules above.
2. **Customer places and tracks an order** (transaction across several tables). TODO
3. **Admin dashboard** (aggregation and reporting). TODO

## Current progress (midsem, October 2026)

**Data population (done):** `Populate_DB/` scripts for customers, sellers,
categories, products and addresses (600 customers, 200 sellers,
18 categories, 800 products, 780 addresses).

**Seller & Products module (done and tested):**
- SELLER, CATEGORY, PRODUCT with primary key, foreign key, unique, check and
  not-null constraints (`db/seller_product_schema.sql`). The script is
  re-runnable: it upgrades existing tables without losing data and keeps the
  team's existing constraints instead of adding duplicates.
- Trigger, low-stock view, restock function and 2 indexes
  (`(category_id, price)` and a partial index for low stock).
- 4 non-trivial queries: joins, GROUP BY with FILTER, correlated subquery,
  CTE with RANK (`db/queries/seller_product_queries.sql`).
- 10 REST endpoints in FastAPI with database-error-to-HTTP mapping.
- 17 SQL constraint tests and 24 API tests, passing on the team's seed data.
  One API test needs at least one row in `orders` and is skipped until the
  ordering module adds orders.

**Ordering, admin and frontend modules:** TODO

## Working on this repository

- Pull before you start: `git pull origin main`.
- Put schema changes in `db/*.sql` and keep them safe to re-run
  (`IF NOT EXISTS`, check `pg_constraint` before adding a constraint).
- Name every constraint with the team prefixes above.
- Each module adds its own router in `backend/app/routers/` and one line in
  `backend/app/main.py`.
- Run both test commands before pushing.
- Never commit `.env` or the database password.

## Contributions

| Member | Contribution |
|---|---|
| Aadit Mathur | Set up the repository and wrote the data population scripts (`Populate_DB/`). |
| Divvij Yogesh Chichra | Designed the SELLER, CATEGORY and PRODUCT tables and their constraints; wrote the trigger, view, restock function, indexes and 4 queries; built the seller and product API endpoints with error mapping; wrote the SQL and API tests. |
| TODO | TODO |
| TODO | TODO |
| TODO | TODO |
