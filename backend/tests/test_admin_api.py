"""Tests for the admin dashboard API (/admin/*).

Run from the repository root:   pytest backend/tests/test_admin_api.py -v
All DB work is rolled back (see conftest.py). The tests only READ data, and
check invariants (e.g. "two half-ranges add up to the full range") instead of
hard-coded numbers, so they pass on both Neon and a local restore.
"""
from datetime import date, timedelta

import pytest

KEY = "test-admin-key"

# Every admin endpoint. Used to prove the API-key gate covers all of them.
ENDPOINTS = [
    "/admin/summary", "/admin/revenue-trend", "/admin/orders-by-status",
    "/admin/top-products", "/admin/top-sellers", "/admin/sales-by-category",
    "/admin/low-stock", "/admin/payments", "/admin/new-customers",
    "/admin/shipments",
]


@pytest.fixture(autouse=True)
def admin_key(monkeypatch):
    monkeypatch.setenv("ADMIN_API_KEY", KEY)


@pytest.fixture()
def auth():
    return {"X-Admin-Key": KEY}


def get(client, auth, path, **params):
    res = client.get(path, params=params, headers=auth)
    assert res.status_code == 200, res.text
    return res.json()


@pytest.fixture()
def order_dates(client, auth):
    """(first, last) day that has orders, taken from the data itself."""
    rows = get(client, auth, "/admin/revenue-trend", interval="day")
    assert rows, "database has no paid orders"
    return date.fromisoformat(rows[0]["period"]), date.fromisoformat(rows[-1]["period"])


# ---------------------------------------------------------------- API key ---

@pytest.mark.parametrize("path", ENDPOINTS)
def test_missing_key_is_401(client, path):
    assert client.get(path).status_code == 401


@pytest.mark.parametrize("path", ENDPOINTS)
def test_wrong_key_is_401(client, path):
    assert client.get(path, headers={"X-Admin-Key": "nope"}).status_code == 401


@pytest.mark.parametrize("path", ENDPOINTS)
def test_correct_key_is_200(client, auth, path):
    assert client.get(path, headers=auth).status_code == 200


def test_server_without_configured_key_is_503(client, monkeypatch):
    monkeypatch.delenv("ADMIN_API_KEY", raising=False)
    assert client.get("/admin/summary", headers={"X-Admin-Key": KEY}).status_code == 503


# ------------------------------------------------------- input validation ---

def test_bad_date_is_422(client, auth):
    assert client.get("/admin/summary", params={"date_from": "not-a-date"}, headers=auth).status_code == 422


def test_bad_interval_is_422(client, auth):
    assert client.get("/admin/revenue-trend", params={"interval": "year"}, headers=auth).status_code == 422


@pytest.mark.parametrize("limit", [0, 51])
def test_limit_out_of_range_is_422(client, auth, limit):
    assert client.get("/admin/top-products", params={"limit": limit}, headers=auth).status_code == 422


def test_interval_sql_injection_is_rejected(client, auth):
    res = client.get("/admin/revenue-trend", params={"interval": "day'); DROP TABLE orders;--"}, headers=auth)
    assert res.status_code == 422


# ------------------------------------------------------------ date filters ---

def test_empty_range_gives_zeros_and_empty_lists(client, auth):
    window = {"date_from": "1999-01-01", "date_to": "1999-12-31"}
    s = get(client, auth, "/admin/summary", **window)
    assert s["total_orders"] == 0 and s["paid_orders"] == 0
    assert float(s["revenue"]) == 0 and float(s["avg_order_value"]) == 0
    for path in ["/admin/revenue-trend", "/admin/orders-by-status", "/admin/top-products",
                 "/admin/top-sellers", "/admin/sales-by-category", "/admin/payments",
                 "/admin/shipments"]:
        assert get(client, auth, path, **window) == [], path


def test_inverted_range_is_empty_not_an_error(client, auth):
    s = get(client, auth, "/admin/summary", date_from="2026-12-31", date_to="2026-01-01")
    assert s["total_orders"] == 0


def test_only_date_from_or_only_date_to(client, auth, order_dates):
    first, last = order_dates
    everything = get(client, auth, "/admin/summary")
    assert get(client, auth, "/admin/summary", date_from=first.isoformat())["total_orders"] <= everything["total_orders"]
    assert get(client, auth, "/admin/summary", date_to=last.isoformat())["total_orders"] == everything["total_orders"]


def test_date_to_is_inclusive(client, auth, order_dates):
    _, last = order_dates
    s = get(client, auth, "/admin/summary", date_from=last.isoformat(), date_to=last.isoformat())
    assert s["total_orders"] >= 1          # the last day's orders are included


def test_two_half_ranges_add_up_to_the_whole(client, auth, order_dates):
    first, last = order_dates
    mid = first + (last - first) // 2
    whole = get(client, auth, "/admin/summary", date_from=first.isoformat(), date_to=last.isoformat())
    a = get(client, auth, "/admin/summary", date_from=first.isoformat(), date_to=mid.isoformat())
    b = get(client, auth, "/admin/summary",
            date_from=(mid + timedelta(days=1)).isoformat(), date_to=last.isoformat())
    assert a["total_orders"] + b["total_orders"] == whole["total_orders"]
    assert a["paid_orders"] + b["paid_orders"] == whole["paid_orders"]
    assert float(a["revenue"]) + float(b["revenue"]) == pytest.approx(float(whole["revenue"]))


# --------------------------------------------- numbers agree with each other ---

def test_revenue_only_counts_paid_orders(client, auth):
    s = get(client, auth, "/admin/summary")
    assert s["paid_orders"] <= s["total_orders"]
    assert float(s["revenue"]) == pytest.approx(float(s["avg_order_value"]) * s["paid_orders"], rel=1e-3)


@pytest.mark.parametrize("interval", ["day", "week", "month"])
def test_trend_total_equals_summary_revenue(client, auth, interval):
    trend = get(client, auth, "/admin/revenue-trend", interval=interval)
    assert sum(float(r["revenue"]) for r in trend) == pytest.approx(float(get(client, auth, "/admin/summary")["revenue"]))
    periods = [r["period"] for r in trend]
    assert periods == sorted(periods)


def test_status_counts_add_up_to_total_orders(client, auth):
    by_status = get(client, auth, "/admin/orders-by-status")
    assert sum(r["orders"] for r in by_status) == get(client, auth, "/admin/summary")["total_orders"]
    # shown in lifecycle order, not alphabetical
    order = ["Pending", "Confirmed", "Shipped", "Delivered", "Cancelled"]
    seen = [r["status"] for r in by_status]
    assert seen == sorted(seen, key=order.index)


def test_category_revenue_matches_summary_and_percentages_total_100(client, auth):
    cats = get(client, auth, "/admin/sales-by-category")
    assert sum(float(r["revenue"]) for r in cats) == pytest.approx(float(get(client, auth, "/admin/summary")["revenue"]))
    assert sum(float(r["pct_of_revenue"]) for r in cats) == pytest.approx(100, abs=0.1 * len(cats))


def test_payments_breakdown_counts_every_order(client, auth):
    pays = get(client, auth, "/admin/payments")
    assert sum(r["payments"] for r in pays) == get(client, auth, "/admin/summary")["total_orders"]


# ----------------------------------------------------------- rankings/lists ---

@pytest.mark.parametrize("path,key", [("/admin/top-products", "units_sold"), ("/admin/top-sellers", "revenue")])
def test_rankings_are_sorted_and_respect_limit(client, auth, path, key):
    rows = get(client, auth, path, limit=3)
    assert 0 < len(rows) <= 3
    values = [float(r[key]) for r in rows]
    assert values == sorted(values, reverse=True)


def test_low_stock_rows_really_are_low(client, auth):
    rows = get(client, auth, "/admin/low-stock", limit=500)
    assert all(r["quantity_in_stock"] <= r["reorder_level"] for r in rows)
    shortfalls = [r["shortfall"] for r in rows]
    assert shortfalls == sorted(shortfalls, reverse=True)


def test_new_customers_total_matches_customer_table(client, auth, conn):
    with conn.cursor() as cur:
        cur.execute("SELECT COUNT(*) FROM customer")
        expected = cur.fetchone()[0]
    rows = get(client, auth, "/admin/new-customers", interval="month")
    assert sum(r["new_customers"] for r in rows) == expected


def test_shipments_delivery_time_only_for_delivered(client, auth):
    for r in get(client, auth, "/admin/shipments"):
        if r["status"] != "Delivered":
            assert r["avg_days_to_deliver"] is None
