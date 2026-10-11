"""Test setup: every test runs inside ONE database transaction that is
rolled back at the end, so the tests never change real data and are
safe to run against the team's Neon database.

Each API request gets a SAVEPOINT instead of a real COMMIT.
"""
import os
from contextlib import contextmanager

import psycopg2
import pytest
from dotenv import load_dotenv
from fastapi.testclient import TestClient
from psycopg2.extras import RealDictCursor

from backend.app import db
from backend.app.main import app

load_dotenv()


@pytest.fixture()
def conn():
    url = os.getenv("DATABASE_URL")
    if not url:
        pytest.skip("DATABASE_URL is not set")
    connection = psycopg2.connect(url, connect_timeout=15)
    yield connection
    connection.rollback()          # undo everything the test did
    connection.close()


@pytest.fixture()
def client(conn, monkeypatch):
    @contextmanager
    def rolled_back_transaction():
        with conn.cursor(cursor_factory=RealDictCursor) as cur:
            cur.execute("SAVEPOINT api_request")
            try:
                yield cur
                cur.execute("RELEASE SAVEPOINT api_request")
            except Exception:
                cur.execute("ROLLBACK TO SAVEPOINT api_request")
                raise

    monkeypatch.setattr(db, "transaction", rolled_back_transaction)
    return TestClient(app)


@pytest.fixture()
def category_id(conn):
    with conn.cursor() as cur:
        cur.execute("INSERT INTO category (category_name) VALUES ('__api_test_category__') "
                    "RETURNING category_id")
        return cur.fetchone()[0]


@pytest.fixture()
def seller(client):
    res = client.post("/sellers", json={"name": "__API Test Seller__",
                                        "email": "__api_seller__@example.in",
                                        "phone": "6999999911"})
    assert res.status_code == 201, res.text
    return res.json()


@pytest.fixture()
def other_seller(client):
    res = client.post("/sellers", json={"name": "__API Other Seller__",
                                        "email": "__api_other__@example.in",
                                        "phone": "6999999912"})
    assert res.status_code == 201, res.text
    return res.json()


@pytest.fixture()
def product(client, seller, category_id):
    res = client.post(f"/sellers/{seller['seller_id']}/products",
                      json={"category_id": category_id, "product_name": "__API Test Product__",
                            "price": "499.00", "quantity_in_stock": 5, "reorder_level": 10})
    assert res.status_code == 201, res.text
    return res.json()
