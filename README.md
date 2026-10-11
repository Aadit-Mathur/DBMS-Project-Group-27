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

- Development of the frontend ongoing
- Admin dashboard module in development
- Final frontend-backend integration and UX refinement
- Complete end-to-end validation across frontend, backend, and database workflows

## Repository Structure

- `backend/app/` — FastAPI application, database connection, request validation, and routers
- `backend/tests/` — API tests for seller/product workflows
- `db_testing/` — schema scripts, SQL validation files, and queries
- `populate_DB/` — data-generation scripts for realistic sample data
- `Reference/` — design documents used as the baseline for the project

## Technology Stack

- Backend: Python, FastAPI
- Database: PostgreSQL on Neon
- Database access: psycopg2, SQL, PL/pgSQL
- Validation: pytest and SQL constraint tests
- Version control: GitHub

## Local Setup

```powershell
python -m venv .venv
.\.venv\Scripts\Activate.ps1
pip install -r requirements.txt
# Add DATABASE_URL in a local .env file before running the app
uvicorn backend.app.main:app --reload
```

The API documentation is available at `/docs` when the server is running.

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
