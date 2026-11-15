/* Admin dashboard: reads the /admin/* API (see docs/ADMIN_API.md).
   Every request carries the X-Admin-Key header; the key is kept in
   sessionStorage only, so it disappears when the tab is closed. */

const KEY_STORE = "adminKey";
const PALETTE = ["#2563eb", "#16a34a", "#f59e0b", "#dc2626", "#7c3aed",
                 "#0891b2", "#db2777", "#65a30d", "#ea580c", "#475569"];
const charts = {};                       // canvas id -> Chart instance

class AuthError extends Error {}

// ---------------------------------------------------------------- helpers ---

const $ = (id) => document.getElementById(id);
const inr = (n) => "₹" + Number(n).toLocaleString("en-IN", { maximumFractionDigits: 0 });
const num = (n) => Number(n).toLocaleString("en-IN");

function periodLabel(iso, interval) {
    const d = new Date(iso + "T00:00:00");
    return interval === "month"
        ? d.toLocaleDateString("en-IN", { month: "short", year: "numeric" })
        : d.toLocaleDateString("en-IN", { day: "numeric", month: "short", year: "2-digit" });
}

async function adminGet(path, params = {}) {
    const query = new URLSearchParams();
    for (const [k, v] of Object.entries(params)) {
        if (v !== "" && v !== null && v !== undefined) query.set(k, v);
    }
    const qs = query.toString();
    const response = await fetch(`${API_BASE_URL}/admin/${path}${qs ? "?" + qs : ""}`, {
        headers: { "X-Admin-Key": sessionStorage.getItem(KEY_STORE) || "" },
    });
    if (response.status === 401) throw new AuthError("Admin key missing or wrong");
    if (response.status === 503) throw new Error("Server has no ADMIN_API_KEY configured");
    const data = await response.json().catch(() => ({}));
    if (!response.ok) throw new Error(data.detail || `Request failed (${response.status})`);
    return data;
}

function currentFilters() {
    return { date_from: $("dateFrom").value, date_to: $("dateTo").value };
}

// ----------------------------------------------------------------- charts ---

function drawChart(canvasId, config, hasData) {
    if (charts[canvasId]) { charts[canvasId].destroy(); delete charts[canvasId]; }
    const canvas = $(canvasId);
    const empty = canvas.parentElement.querySelector(".empty");
    canvas.hidden = !hasData;
    empty.hidden = hasData;
    empty.textContent = "No data for this range";   // showError() overrides this after
    if (!hasData) return;
    config.options = Object.assign({ responsive: true, maintainAspectRatio: false }, config.options);
    charts[canvasId] = new Chart(canvas, config);
}

function showError(canvasId, message) {
    drawChart(canvasId, {}, false);
    const empty = $(canvasId).parentElement.querySelector(".empty");
    empty.textContent = message;
}

// ------------------------------------------------------------------ tables ---

function renderTable(containerId, columns, rows) {
    const box = $(containerId);
    box.replaceChildren();
    if (!rows.length) {
        const p = document.createElement("p");
        p.textContent = "No data for this range";
        box.appendChild(p);
        return;
    }
    const wrap = document.createElement("div");
    wrap.className = "table-scroll";
    const table = document.createElement("table");
    const head = table.createTHead().insertRow();
    columns.forEach((c) => {
        const th = document.createElement("th");
        th.textContent = c.label;
        if (c.num) th.className = "num";
        head.appendChild(th);
    });
    const body = table.createTBody();
    rows.forEach((row) => {
        const tr = body.insertRow();
        columns.forEach((c) => {
            const td = tr.insertCell();
            td.textContent = c.format ? c.format(row[c.key]) : row[c.key];   // textContent: no HTML injection
            if (c.num) td.className = "num";
        });
    });
    wrap.appendChild(table);
    box.appendChild(wrap);
}

function showBoxError(containerId, message) {
    const p = document.createElement("p");
    p.className = "admin-error";
    p.textContent = message;
    $(containerId).replaceChildren(p);
}

// ---------------------------------------------------------------- sections ---

// Each loader handles its own errors, except a wrong key, which must
// bubble up so the page can go back to the key prompt.
async function guarded(work, onError) {
    try { await work(); }
    catch (err) {
        if (err instanceof AuthError) throw err;
        console.error(err);
        onError(err.message);
    }
}

function fillKpis(box, cards) {
    box.replaceChildren(...cards.map(([label, value]) => {
        const div = document.createElement("div");
        div.className = "kpi";
        const l = document.createElement("p"); l.className = "label"; l.textContent = label;
        const v = document.createElement("p"); v.className = "value"; v.textContent = value;
        div.append(l, v);
        return div;
    }));
}

// Headline counts: a live snapshot, so no date window.
async function loadOverview() {
    const box = $("overview");
    await guarded(async () => {
        const o = await adminGet("overview");
        fillKpis(box, [["Customers", num(o.customers)], ["Sellers", num(o.sellers)],
                       ["Products", num(o.products)], ["Active products", num(o.active_products)]]);
    }, (msg) => { box.textContent = "Unable to load overview: " + msg; });
}

async function loadKpis(f) {
    const box = $("kpis");
    await guarded(async () => {
        const s = await adminGet("summary", f);
        fillKpis(box, [
            ["Revenue", inr(s.revenue)],
            ["Paid orders", num(s.paid_orders)],
            ["All orders", num(s.total_orders)],
            ["Avg order value", inr(s.avg_order_value)],
            ["Refunded", inr(s.refunded_amount)],
        ]);
    }, (msg) => { box.textContent = "Unable to load summary: " + msg; });
}

async function loadRevenueTrend(f, interval) {
    await guarded(async () => {
        const rows = await adminGet("revenue-trend", { ...f, interval });
        drawChart("chartRevenue", {
            type: "line",
            data: {
                labels: rows.map((r) => periodLabel(r.period, interval)),
                datasets: [{
                    label: "Revenue (₹)", data: rows.map((r) => Number(r.revenue)),
                    borderColor: PALETTE[0], backgroundColor: "rgba(37,99,235,0.15)",
                    fill: true, tension: 0,
                }],
            },
            options: { scales: { y: { beginAtZero: true, ticks: { callback: (v) => inr(v) } } },
                       plugins: { tooltip: { callbacks: {
                           label: (c) => `${inr(c.parsed.y)} from ${rows[c.dataIndex].orders} orders` } } } },
        }, rows.length > 0);
    }, (msg) => showError("chartRevenue", msg));
}

async function loadStatus(f) {
    await guarded(async () => {
        const rows = await adminGet("orders-by-status", f);
        drawChart("chartStatus", {
            type: "doughnut",
            data: { labels: rows.map((r) => r.status),
                    datasets: [{ data: rows.map((r) => r.orders), backgroundColor: PALETTE }] },
            options: { plugins: { legend: { position: "right" } } },
        }, rows.length > 0);
    }, (msg) => showError("chartStatus", msg));
}

async function loadCategories(f) {
    await guarded(async () => {
        const rows = await adminGet("sales-by-category", f);
        drawChart("chartCategory", {
            type: "bar",
            data: { labels: rows.map((r) => r.category_name),
                    datasets: [{ label: "Revenue (₹)", data: rows.map((r) => Number(r.revenue)),
                                 backgroundColor: PALETTE[0] }] },
            options: { indexAxis: "y",
                       plugins: { legend: { display: false }, tooltip: { callbacks: {
                           label: (c) => `${inr(c.parsed.x)} (${rows[c.dataIndex].pct_of_revenue}% of revenue)` } } },
                       scales: { x: { ticks: { callback: (v) => inr(v) } } } },
        }, rows.length > 0);
    }, (msg) => showError("chartCategory", msg));
}

async function loadPayments(f) {
    await guarded(async () => {
        const rows = await adminGet("payments", f);
        const methods = [...new Set(rows.map((r) => r.method))];
        const statuses = [...new Set(rows.map((r) => r.status))];
        const colour = { Successful: "#16a34a", Pending: "#f59e0b", Failed: "#dc2626", Refunded: "#7c3aed" };
        drawChart("chartPayments", {
            type: "bar",
            data: { labels: methods,
                    datasets: statuses.map((st) => ({
                        label: st, backgroundColor: colour[st] || PALETTE[5],
                        data: methods.map((m) => (rows.find((r) => r.method === m && r.status === st) || {}).payments || 0),
                    })) },
            options: { scales: { x: { stacked: true }, y: { stacked: true, beginAtZero: true } } },
        }, rows.length > 0);
    }, (msg) => showError("chartPayments", msg));
}

async function loadShipments(f) {
    await guarded(async () => {
        const rows = await adminGet("shipments", f);
        drawChart("chartShipments", {
            type: "bar",
            data: { labels: rows.map((r) => r.status),
                    datasets: [{ label: "Shipments", data: rows.map((r) => r.shipments),
                                 backgroundColor: PALETTE[2] }] },
            options: { plugins: { legend: { display: false }, tooltip: { callbacks: {
                           afterLabel: (c) => rows[c.dataIndex].avg_days_to_deliver !== null
                               ? `Avg ${rows[c.dataIndex].avg_days_to_deliver} days to deliver` : "" } } },
                       scales: { y: { beginAtZero: true } } },
        }, rows.length > 0);
    }, (msg) => showError("chartShipments", msg));
}

async function loadCustomers(f, interval) {
    await guarded(async () => {
        const rows = await adminGet("new-customers", { ...f, interval });
        drawChart("chartCustomers", {
            type: "bar",
            data: { labels: rows.map((r) => periodLabel(r.period, interval)),
                    datasets: [{ label: "New customers", data: rows.map((r) => r.new_customers),
                                 backgroundColor: PALETTE[6] }] },
            options: { plugins: { legend: { display: false } }, scales: { y: { beginAtZero: true } } },
        }, rows.length > 0);
    }, (msg) => showError("chartCustomers", msg));
}

async function loadTables(f) {
    await guarded(async () => {
        renderTable("topProductsTable", [
            { key: "product_name", label: "Product" },
            { key: "seller_name", label: "Seller" },
            { key: "units_sold", label: "Units", num: true, format: num },
            { key: "revenue", label: "Revenue", num: true, format: inr },
        ], await adminGet("top-products", { ...f, limit: 10 }));
    }, (msg) => showBoxError("topProductsTable", "Unable to load top products: " + msg));

    await guarded(async () => {
        renderTable("topSellersTable", [
            { key: "seller_name", label: "Seller" },
            { key: "orders", label: "Orders", num: true, format: num },
            { key: "units_sold", label: "Units", num: true, format: num },
            { key: "revenue", label: "Revenue", num: true, format: inr },
        ], await adminGet("top-sellers", { ...f, limit: 10 }));
    }, (msg) => showBoxError("topSellersTable", "Unable to load top sellers: " + msg));

    // Low stock is a live snapshot, so it has no date window.
    await guarded(async () => {
        renderTable("lowStockTable", [
            { key: "product_name", label: "Product" },
            { key: "seller_name", label: "Seller" },
            { key: "category_name", label: "Category" },
            { key: "quantity_in_stock", label: "In stock", num: true },
            { key: "reorder_level", label: "Reorder at", num: true },
            { key: "shortfall", label: "Short by", num: true },
        ], await adminGet("low-stock", { limit: 15 }));
    }, (msg) => showBoxError("lowStockTable", "Unable to load low stock: " + msg));
}

// ------------------------------------------------------------- page control ---

async function loadDashboard() {
    const f = currentFilters();
    const message = $("filterMessage");
    message.textContent = "";
    if (f.date_from && f.date_to && f.date_from > f.date_to) {
        message.textContent = "The start date is after the end date.";
        return;
    }
    const interval = $("interval").value;
    try {
        await Promise.all([
            loadOverview(), loadKpis(f), loadRevenueTrend(f, interval), loadStatus(f), loadCategories(f),
            loadPayments(f), loadShipments(f), loadCustomers(f, interval), loadTables(f),
        ]);
    } catch (err) {
        if (err instanceof AuthError) { lock("That admin key was rejected. Please try again."); return; }
        throw err;
    }
}

function lock(message = "") {
    sessionStorage.removeItem(KEY_STORE);
    Object.keys(charts).forEach((id) => { charts[id].destroy(); delete charts[id]; });
    $("adminApp").hidden = true;
    $("keyGate").hidden = false;
    $("adminKeyInput").value = "";
    $("keyMessage").textContent = message;
}

function unlock() {
    const key = $("adminKeyInput").value.trim();
    if (!key) { $("keyMessage").textContent = "Enter the admin key."; return; }
    sessionStorage.setItem(KEY_STORE, key);
    $("keyMessage").textContent = "";
    $("keyGate").hidden = true;
    $("adminApp").hidden = false;
    loadDashboard();
}

$("unlockBtn").addEventListener("click", unlock);
$("adminKeyInput").addEventListener("keydown", (e) => { if (e.key === "Enter") unlock(); });
$("applyBtn").addEventListener("click", loadDashboard);
$("interval").addEventListener("change", loadDashboard);
$("resetBtn").addEventListener("click", () => {
    $("dateFrom").value = ""; $("dateTo").value = ""; $("interval").value = "month";
    loadDashboard();
});
$("lockBtn").addEventListener("click", () => lock());

if (sessionStorage.getItem(KEY_STORE)) {          // already unlocked in this tab
    $("keyGate").hidden = true;
    $("adminApp").hidden = false;
    loadDashboard();
}
