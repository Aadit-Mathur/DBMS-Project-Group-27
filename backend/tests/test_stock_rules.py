"""Regression tests: stock may only change through restock and orders, and
there is exactly one way to relist a product.

Run from the repository root:   pytest backend/tests/test_stock_rules.py -v
"""


def stock_of(client, product_id):
    return client.get(f"/products/{product_id}").json()["quantity_in_stock"]


def test_legacy_put_route_cannot_overwrite_stock(client, seller, product, category_id):
    before = stock_of(client, product["product_id"])
    res = client.put(
        f"/sellers/{seller['seller_id']}/products/{product['product_id']}",
        json={"category_id": category_id, "product_name": product["product_name"],
              "price": 10, "quantity_in_stock": before + 500, "reorder_level": 1},
    )
    assert res.status_code in (404, 405)            # the route no longer exists
    assert stock_of(client, product["product_id"]) == before


def test_stock_changes_only_through_restock(client, seller, product):
    before = stock_of(client, product["product_id"])
    res = client.post(f"/products/{product['product_id']}/restock", json={"quantity": 7},
                      headers={"X-Seller-Id": str(seller["seller_id"])})
    assert res.status_code == 200
    assert stock_of(client, product["product_id"]) == before + 7


def test_only_one_relist_route(client, seller, product):
    headers = {"X-Seller-Id": str(seller["seller_id"])}
    assert client.patch(f"/products/{product['product_id']}/relist", headers=headers).status_code == 405
    assert client.post(f"/products/{product['product_id']}/relist", headers=headers).status_code == 200
