"""End-to-end tests of the seller workflow through the API.

Run from the repository root:   pytest backend/tests -v
All changes are rolled back (see conftest.py).
"""
import pytest


def seller_header(seller):
    return {"X-Seller-Id": str(seller["seller_id"])}


# ---------- registration ----------

def test_register_seller(seller):
    assert seller["seller_id"] > 0
    assert seller["email"] == "__api_seller__@example.in"


def test_invalid_phone_is_400(client):
    res = client.post("/sellers", json={"name": "X", "email": "__x__@example.in", "phone": "12345"})
    assert res.status_code == 400
    assert res.json()["constraint"] == "chk_seller_phone"


def test_duplicate_email_is_409(client, seller):
    res = client.post("/sellers", json={"name": "X", "email": seller["email"], "phone": "6999999913"})
    assert res.status_code == 409


# ---------- adding products ----------

def test_add_product(product):
    assert product["is_active"] is True
    assert float(product["price"]) == 499.0


def test_negative_price_is_400(client, seller, category_id):
    res = client.post(f"/sellers/{seller['seller_id']}/products",
                      json={"category_id": category_id, "product_name": "Bad", "price": "-5"})
    assert res.status_code == 400
    assert res.json()["constraint"] == "chk_product_price"
    assert res.json()["error"] == "Price cannot be negative."


def test_duplicate_product_name_is_409(client, seller, product, category_id):
    res = client.post(f"/sellers/{seller['seller_id']}/products",
                      json={"category_id": category_id, "product_name": product["product_name"],
                            "price": "10"})
    assert res.status_code == 409
    assert res.json()["error"] == "You already have a product with this name."


def test_unknown_category_is_400(client, seller):
    res = client.post(f"/sellers/{seller['seller_id']}/products",
                      json={"category_id": -1, "product_name": "X", "price": "10"})
    assert res.status_code == 400


def test_unknown_seller_is_404(client, category_id):
    res = client.post("/sellers/-1/products",
                      json={"category_id": category_id, "product_name": "X", "price": "10"})
    assert res.status_code == 404


# ---------- dashboard, catalog, low stock ----------

def test_dashboard(client, seller, product):
    res = client.get(f"/sellers/{seller['seller_id']}/dashboard")
    assert res.status_code == 200
    body = res.json()
    assert body["active_products"] == 1
    assert body["units_in_stock"] == 5
    assert float(body["inventory_value"]) == 2495.0
    assert body["low_stock_products"] == 1


def test_seller_catalog(client, seller, product):
    res = client.get(f"/sellers/{seller['seller_id']}/products")
    assert [p["product_id"] for p in res.json()] == [product["product_id"]]


def test_low_stock_list(client, seller, product):
    res = client.get(f"/sellers/{seller['seller_id']}/low-stock")
    assert res.status_code == 200
    assert res.json()[0]["shortfall"] == 5


# ---------- editing ----------

def test_edit_price_updates_last_updated(client, conn, seller, product):
    with conn.cursor() as cur:
        cur.execute("UPDATE product SET last_updated = '2000-01-01' WHERE product_id = %s",
                    (product["product_id"],))
    res = client.patch(f"/products/{product['product_id']}", json={"price": "549.00"},
                       headers=seller_header(seller))
    assert res.status_code == 200
    assert float(res.json()["price"]) == 549.0
    assert not res.json()["last_updated"].startswith("2000")      # set by the trigger


def test_edit_other_sellers_product_is_403(client, other_seller, product):
    res = client.patch(f"/products/{product['product_id']}", json={"price": "1"},
                       headers=seller_header(other_seller))
    assert res.status_code == 403


def test_stock_is_not_editable_directly(client, seller, product):
    res = client.patch(f"/products/{product['product_id']}", json={"quantity_in_stock": 999},
                       headers=seller_header(seller))
    assert res.status_code == 422


# ---------- restocking ----------

def test_restock(client, seller, product):
    res = client.post(f"/products/{product['product_id']}/restock", json={"quantity": 20},
                      headers=seller_header(seller))
    assert res.status_code == 200
    assert res.json()["quantity_in_stock"] == 25
    low = client.get(f"/sellers/{seller['seller_id']}/low-stock").json()
    assert low == []


def test_restock_other_sellers_product_is_403(client, other_seller, product):
    res = client.post(f"/products/{product['product_id']}/restock", json={"quantity": 5},
                      headers=seller_header(other_seller))
    assert res.status_code == 403


def test_restock_zero_is_400(client, seller, product):
    res = client.post(f"/products/{product['product_id']}/restock", json={"quantity": 0},
                      headers=seller_header(seller))
    assert res.status_code == 400


# ---------- removing ----------

def test_remove_never_ordered_product_deletes_it(client, seller, product):
    res = client.delete(f"/products/{product['product_id']}", headers=seller_header(seller))
    assert res.status_code == 204
    assert client.get(f"/sellers/{seller['seller_id']}/products?include_inactive=true").json() == []


def test_remove_ordered_product_delists_it(client, conn, seller, product):
    """Puts the product into an existing order (rolled back), then removes it.
    The order_item FK blocks the delete (23503, or 23001 on PostgreSQL 18+),
    so the API must delist the product instead of failing."""
    with conn.cursor() as cur:
        cur.execute("SELECT to_regclass('order_item') IS NOT NULL, to_regclass('orders') IS NOT NULL")
        has_items, has_orders = cur.fetchone()
        if not (has_items and has_orders):
            pytest.skip("orders / order_item tables do not exist yet (ordering module)")
        cur.execute("SELECT order_id FROM orders ORDER BY order_id LIMIT 1")
        row = cur.fetchone()
        if row is None:
            pytest.skip("no orders in the database yet to attach the product to")
        cur.execute("INSERT INTO order_item (order_id, product_id, quantity, unit_price) "
                    "VALUES (%s, %s, 1, 499.00)", (row[0], product["product_id"]))

    res = client.delete(f"/products/{product['product_id']}", headers=seller_header(seller))
    assert res.status_code == 200, res.text
    assert res.json()["status"] == "delisted"
    assert client.get(f"/sellers/{seller['seller_id']}/products").json() == []        # hidden
    hidden = client.get(f"/sellers/{seller['seller_id']}/products?include_inactive=true").json()
    assert hidden[0]["is_active"] is False                                           # but kept


def test_remove_other_sellers_product_is_403(client, other_seller, product):
    res = client.delete(f"/products/{product['product_id']}", headers=seller_header(other_seller))
    assert res.status_code == 403


# ---------- customer search and categories ----------

def test_search_finds_product(client, product, category_id):
    res = client.get("/products", params={"q": "__API Test", "category_id": category_id})
    assert [p["product_id"] for p in res.json()] == [product["product_id"]]


def test_search_price_filter_excludes_product(client, product, category_id):
    res = client.get("/products", params={"category_id": category_id, "max_price": "100"})
    assert res.json() == []


def test_categories_list(client, product, category_id):
    cats = {c["category_id"]: c for c in client.get("/categories").json()}
    assert cats[category_id]["active_products"] == 1


def test_health(client):
    assert client.get("/health").json()["status"] == "ok"
