# DBMS Project, Group-27: E-commerce Marketplace

The system models a marketplace similar to Amazon, where sellers list products, customers browse and purchase items, and orders are processed through transactional database logic.

## Project Overview

The application is built around a PostgreSQL database hosted on Neon and a FastAPI backend that exposes REST endpoints for the main domain workflows:

- Seller registration and catalog management
- Product search, filtering, and inventory controls
- Customer order placement and order history
- Payment and shipment workflow logic
- Database-enforced integrity checks, transactions, and reporting queries

## Current Progress (Mid-Sem Evaluation)

### Completed work

- Core database objects and business rules for the marketplace have been implemented for the seller, product, category, order, payment, and shipment workflow.
- Most SQL constraints, unique keys, checks, triggers, views, and functions are in place to support validation and inventory-related logic.
- FastAPI routes have been implemented for seller registration, product management, product search, category listing, and order-related actions.
- Transactional database logic is used for order placement and stock updates to keep the core workflow atomic.
- SQL validation scripts and API tests have been added to exercise key constraints and backend operations.
- Sample data generation scripts are included to populate realistic customers, sellers, categories, products, and addresses for testing.

### In progress / next milestones

- Addition of a few more triggers, views, etc. under consideration
- Development of the frontend is ongoing
- Admin dashboard module in development
- Final frontend-backend integration and UX refinement
- Complete end-to-end validation across frontend, backend, and database workflows

## Repository Structure

- `backend/app/` — FastAPI application, database connection, request validation, and routers
- `backend/tests/` — API tests for seller/product workflows
- `db_testing/` — database restore, schema scripts, SQL validation files, and queries
- `reconstruct_database/` — portable schema and sample data dumps
- `populate_DB/` — data-generation scripts for realistic sample data
- `Reference/` — design documents used as the baseline for the project

## Technology Stack

- Backend: Python, FastAPI
- Database: PostgreSQL (Neon or local)
- Database access: psycopg2, SQL, PL/pgSQL
- Validation: pytest and SQL constraint tests
- Version control: GitHub

## Local Setup

```powershell
python -m venv .venv
.\.venv\Scripts\Activate.ps1
pip install -r requirements.txt
# Set DATABASE_URL in a local .env file before running the app.
# It may be a Neon URL or a local PostgreSQL URL.
uvicorn backend.app.main:app --reload
```

The API documentation is available at `/docs` when the server is running.

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

## Contributors

### Aadit Mathur (2024AAPS0310H)
- Project setup and repository organization
- Database design (ER Diagram creation & Relational Schema) and business rules
- Neon database population and overall testing

### Rithwik Rudra (2024AAPS0260H)
- Frontend development
- Product browsing, order management, the seller portal, and the admin dashboard
- Integration of frontend and backend

### Aarav Gang (2024AAPS0328H)
- Ordering module development
- Payment and shipment workflow logic
- Transactional database design and order-processing validation

### Divvij Yogesh Chichra (2024AAPS0298H)
- Seller and product module development
- Inventory and product catalog management
- Product delisting and low-stock monitoring

### Yash Agarwal (2024AAPS0294H)
- Admin dashboard module development 
- Analytical queries and reporting functionality for revenue
- Charts and visualisations


# E-Commerce Marketplace — DBMS Project

## 1. Project Overview

This project is a full-stack e-commerce marketplace application developed as part of the DBMS course.

The system connects a web-based frontend with a FastAPI backend and a PostgreSQL relational database. It supports customers, sellers, products, orders, payments, shipments, inventory management, and administrative reporting.

The application demonstrates practical use of relational database concepts including primary and foreign keys, integrity constraints, transactions, stored functions, triggers, multi-table queries, aggregation, and database-backed application workflows.

---

## 2. Technology Stack

### Frontend
- HTML
- CSS
- JavaScript

### Backend
- Python
- FastAPI
- psycopg2

### Database
- PostgreSQL

### Development Tools
- Visual Studio Code
- pgAdmin
- Swagger / OpenAPI
- Git / GitHub

---

## 3. Main Users

### Customer
Customers can:
- Browse products
- Search and filter products
- Add products to a cart
- Checkout
- Place orders
- Make payments
- View previous orders
- Track shipments

### Seller
Sellers can:
- View their seller dashboard
- View their products
- Add products
- Edit products
- Delete/delist products
- Restock products
- View orders containing their products
- Update shipment status

### Administrator
The administrator dashboard provides:
- Overall system statistics
- Top-selling products
- Category-wise sales reports
- Order-status summaries

---

## 4. Database Schema

The application uses a relational database containing the following major relations:

1. Customer
2. Seller
3. Category
4. Product
5. Address
6. Delivery_Address
7. Inventory
8. Orders
9. Order_Item
10. Payment
11. Shipment

The database uses primary keys and foreign keys to maintain relationships between entities and enforce referential integrity.

Important constraints such as NOT NULL, UNIQUE, CHECK, PRIMARY KEY, and FOREIGN KEY constraints are enforced at the database level where appropriate.

---

## 5. Major Application Workflows

### Workflow 1 — Customer Purchase

Customer searches for a product → filters products → adds products to cart → selects delivery address → places an order → completes payment → views order → tracks shipment.

### Workflow 2 — Seller Fulfilment

Seller opens dashboard → views products and inventory → manages products/restocks inventory → views customer orders → updates shipment status from Shipped to In Transit to Delivered.

### Workflow 3 — Administrative Reporting

Administrator opens the dashboard → views customer, seller, product and order statistics → analyzes top products → analyzes category-wise sales → views order-status distribution.

---

## 6. Reports and Dashboard

The application provides the following reports:

- Overall dashboard statistics
- Top products by units sold and revenue
- Category-wise sales
- Order-status summary

These reports use SQL joins, aggregation, grouping, filtering and ordering across multiple relations.

---

## 7. DBMS Features Demonstrated

The project demonstrates the following DBMS features:

### Transactions
Database transactions are used for coordinated operations such as order and payment processing.

### Stored Functions
Database functions are used for important operations including:
- `place_order`
- `begin_payment`
- `record_payment`
- `advance_shipment`
- `restock_product`

### Triggers
Triggers are used for automatic database operations such as maintaining product update information.

### Integrity Constraints
The database uses:
- Primary keys
- Foreign keys
- UNIQUE constraints
- NOT NULL constraints
- CHECK constraints

---

## 8. Important SQL Operations

The project contains non-trivial SQL queries involving:

- Multiple-table joins
- Aggregation using SUM and COUNT
- GROUP BY
- ORDER BY
- Filtering
- Subqueries
- Seller-specific order retrieval
- Product sales analysis
- Category sales analysis
- Dashboard statistics

These queries support both application functionality and administrative reporting.

---

## 9. Project Structure

DBMS-Project-Group-27/
│
├── backend/
│   └── app/
│       ├── routers/
│       ├── db.py
│       ├── schemas.py
│       └── main.py
│
├── frontend/
│   ├── customer/
│   ├── seller/
│   ├── admin/
│   ├── css/
│   └── js/
│
├── db_testing/
│   ├── seller_product_schema.sql
│   ├── order_schema.sql
│   ├── reset_order_data.sql
│   └── run_sql.py
│
├── Populate_DB/
├── Reference/
├── docs/
├── requirements.txt
└── README.md


### Part 3 — Setup

Continue with:

```markdown
---

## 10. Running the Backend

Install the required Python dependencies.

From the project root, run:

```bash
uvicorn backend.app.main:app --reload