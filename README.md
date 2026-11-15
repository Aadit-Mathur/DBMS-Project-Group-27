# DBMS Project, Group-27: E-commerce Marketplace

The system models a marketplace similar to Amazon, where sellers list products, customers browse and purchase items, and orders are processed through transactional database logic.

## Project Overview

The application is built around a PostgreSQL database hosted on Neon and a FastAPI backend that exposes REST endpoints for the main domain workflows:

- Seller registration and catalog management
- Product search, filtering, and inventory controls
- Customer order placement and order history
- Payment and shipment workflow logic
- Database-enforced integrity checks, transactions, and reporting queries

## Submission

- Git tag: `final` 
- Final commit hash: a1a09f3069b8cd869e47e60ce730240f25d4d102

## Members and Contributions

### Aadit Mathur (2024AAPS0310H)
- Project setup and repository organization (along with documentation)
- Database design (ER Diagram creation & Relational Schema) and business rules
- Neon database population and overall testing

### Rithwik Rudra (2024AAPS0260H)
- Frontend development
- Product browsing, order management, the seller portal, and administrative reporting
- Integration of frontend and backend

### Aarav Gang (2024AAPS0328H)
- Ordering module development
- Payment and shipment workflow logic
- Transactional database design and order-processing validation

### Divvij Yogesh Chichra (2024AAPS0298H)
- Seller and product module development
- Inventory and product catalog management
- Product delisting and low-stock monitoring
- Frontend refinement

### Yash Agarwal (2024AAPS0294H)
- Administrative reporting module development
- Analytical queries and reporting functionality for revenue
- Charts and visualisations


## Technology Stack

- Backend: Python, FastAPI
- Frontend: HTML, CSS, JavaScript; charts use Chart.js 4.5.1, bundled in `frontend/js/vendor/` (works offline)
- Database: PostgreSQL (NeonDB primary target; local PostgreSQL supported for reproducible testing), 10 application tables
- Database access: psycopg2, SQL, PL/pgSQL
- Validation: pytest and SQL constraint tests
- Version control: GitHub

## Local Setup

1. From the project root, install dependencies and start the backend:

   ```powershell
   pip install -r requirements.txt
   uvicorn backend.app.main:app --reload
   ```

   Create a `.env` file in the repository root with:

   ```env
   DATABASE_URL=postgresql://...   # a Neon URL or a local PostgreSQL URL
   ADMIN_API_KEY=...               # required for the admin dashboard and admin endpoints
   ```

2. In a second terminal window, serve the frontend:

   ```powershell
   python -m http.server 5500 --directory frontend
   ```

   Then open `http://127.0.0.1:5500`.

The deployed frontend is also available at
[`https://bazaar-group27.vercel.app/`](https://bazaar-group27.vercel.app/).
The API documentation is available at `/docs` when the backend is running.

There are no passwords in this project: sign in as a customer or seller by email (for example `customer0001@example.in` or `seller0001@example.in`), and open the admin dashboard with the `ADMIN_API_KEY` value from `.env`. Page-by-page details and the endpoint each screen uses are in [`frontend/README.md`](frontend/README.md).

## Reproducible database setup

The checked-in database files can be restored independently of the hosted
NeonDB instance. PostgreSQL 18 or a compatible PostgreSQL version, pgAdmin 4
or `psql`, and the files in `reconstruct_database/` are required.

### Local PostgreSQL

1. Create an empty database named `ecommerce_local` in pgAdmin, or run:

   ```powershell
   createdb -U postgres ecommerce_local
   ```

2. Restore the schema and sample data with the automated helper:

   ```powershell
   python db_testing/restore_database.py `
     --database-url "postgresql://postgres:YOUR_PASSWORD@localhost:5432/ecommerce_local"
   ```

   The helper uses `psql` because `sample_data_fixed.sql` contains `COPY`
   blocks. It temporarily disables user-defined triggers while importing the
   historical data, then re-enables them in the same transaction. Foreign-key
   constraints remain enabled.

   Alternatively, use `psql` manually:

   ```text
   \i 'C:/path/to/reconstruct_database/schema.sql'
   ```

   Before importing `sample_data_fixed.sql`, execute:

   ```sql
   ALTER TABLE public.address DISABLE TRIGGER USER;
   ALTER TABLE public.category DISABLE TRIGGER USER;
   ALTER TABLE public.customer DISABLE TRIGGER USER;
   ALTER TABLE public.order_event DISABLE TRIGGER USER;
   ALTER TABLE public.order_fn_backup DISABLE TRIGGER USER;
   ALTER TABLE public.order_item DISABLE TRIGGER USER;
   ALTER TABLE public.orders DISABLE TRIGGER USER;
   ALTER TABLE public.payment DISABLE TRIGGER USER;
   ALTER TABLE public.product DISABLE TRIGGER USER;
   ALTER TABLE public.seller DISABLE TRIGGER USER;
   ALTER TABLE public.shipment DISABLE TRIGGER USER;
   ```

   Then run:

   ```text
   \set ON_ERROR_STOP on
   \i 'C:/path/to/reconstruct_database/sample_data_fixed.sql'
   ```

   Re-enable the triggers by changing `DISABLE` to `ENABLE` in the
   statements above before testing normal application operations.

3. Configure the application to use the restored database:

   ```env
   DATABASE_URL=postgresql://postgres:YOUR_PASSWORD@localhost:5432/ecommerce_local
   ```

   Then start the API:

   ```powershell
   uvicorn backend.app.main:app --reload
   ```

### Verification

Run this query after importing the data:

```sql
SELECT
    (SELECT COUNT(*) FROM customer) AS customers,
    (SELECT COUNT(*) FROM address) AS addresses,
    (SELECT COUNT(*) FROM category) AS categories,
    (SELECT COUNT(*) FROM orders) AS orders,
    (SELECT COUNT(*) FROM order_event) AS events,
    (SELECT COUNT(*) FROM seller) AS sellers,
    (SELECT COUNT(*) FROM product) AS products,
    (SELECT COUNT(*) FROM order_item) AS order_items,
    (SELECT COUNT(*) FROM payment) AS payments,
    (SELECT COUNT(*) FROM shipment) AS shipments;
```

Expected counts are: customer 600, address 1,560, category 18, orders 302,
order_event 1,914, seller 200, product 801, order_item 605, payment 302,
and shipment 251.

The restore target must be empty (or contain no objects owned by this
project). For Neon, use a fresh branch or empty database and pass its
connection URL to the same restore command:

```powershell
python db_testing/restore_database.py --database-url $env:DATABASE_URL
```

## Major Application Workflows

### Workflow 1 — Customer Purchase

Customer searches for a product → filters products → adds products to cart → selects delivery address → places an order → completes payment → views order → tracks shipment.

### Workflow 2 — Seller Fulfilment

Seller opens dashboard → views products and inventory → manages products/restocks inventory → views customer orders → updates shipment status from Shipped to In Transit to Delivered.

### Workflow 3 — Administrative Reporting

Administrator opens the dashboard → views customer, seller, product and order statistics → analyzes top products → analyzes category-wise sales → views order-status distribution.

## Database objects

- **10 application tables:** address, category, customer, order_event, order_item, orders, payment, product, seller, shipment. `order_fn_backup` is a development-only backup table and is excluded from this count.
- **3 views:** `v_low_stock_products`, `v_order_summary`, `v_paid_orders`
- **9 indexes:** `idx_order_event_order`, `idx_order_item_order`, `idx_order_item_product`, `idx_orders_customer`, `idx_orders_pending` (partial), `idx_payment_successful` (partial), `idx_product_category_price`, `idx_product_low_stock` (partial), `uq_shipment_tracking` (unique, partial)
- **9 triggers** (order item freeze and total, order guard and event log, payment flow and event log, product timestamp, shipment flow and event log)
- **14 functions:** `place_order`, `begin_payment`, `record_payment`, `cancel_order`, `expire_unpaid_orders`, `advance_shipment`, `restock_product` and the trigger functions behind the triggers above
