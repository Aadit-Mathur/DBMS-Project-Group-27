# DBMS Project, Group 27: E-commerce marketplace

Full-stack app over PostgreSQL (Neon). Backend: FastAPI + psycopg2 (plain SQL, no ORM).

## Seller & Products module (Divvij Yogesh Chichra)

- `db/seller_product_schema.sql`: SELLER, CATEGORY, PRODUCT tables with constraints, a trigger, a view and a function (safe to re-run)
- `db/queries/`: report queries
- `db/tests/`: SQL tests that try to break each rule, then roll back
- `backend/app/routers/`: sellers, products and categories endpoints
- `backend/tests/`: API tests (rolled back)

## Run

```powershell
python -m venv .venv; .venv\Scripts\Activate.ps1
pip install -r requirements.txt
# put DATABASE_URL in .env (never commit it)
python db\run_sql.py db\seller_product_schema.sql
python db\run_sql.py db\tests\seller_product_constraint_tests.sql
uvicorn backend.app.main:app --reload    # docs at /docs
pytest
```
