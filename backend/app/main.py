"""FastAPI application for the e-commerce DBMS project (Group 27).

Run from the repository root:

    uvicorn backend.app.main:app --reload

Interactive API docs: http://127.0.0.1:8000/docs

Each module adds its own router file under backend/app/routers/ and
includes it below (ordering, admin, ...).
"""
import psycopg2
from fastapi import FastAPI

from . import db
from .errors import postgres_error_handler
from .routers import categories, products, sellers

app = FastAPI(
    title="E-Commerce DBMS Project - Group 27",
    version="0.1.0",
    description="Backend API over a PostgreSQL (Neon) database. "
                "Business rules are enforced by database constraints; "
                "their errors are returned as 400 / 403 / 409 responses.",
)

app.add_exception_handler(psycopg2.Error, postgres_error_handler)

# Seller & Products module
app.include_router(sellers.router)
app.include_router(products.router)
app.include_router(categories.router)
# Ordering module:  app.include_router(orders.router)
# Admin module:     app.include_router(admin.router)


@app.get("/health", tags=["Health"])
def health():
    with db.transaction() as cur:
        cur.execute("SELECT current_database() AS database, now() AS server_time")
        return {"status": "ok", **cur.fetchone()}
