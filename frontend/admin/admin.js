import { api } from '../js/api.js';
import { mountPortal } from '../js/layout.js';
import { money, moneyShort, int, esc, badge } from '../js/format.js';
import { errorState, emptyState, skeletonRows, $, busy } from '../js/dom.js';
import { toast, toastError } from '../js/toast.js';
import { formModal } from '../js/modal.js';
import { icon } from '../js/icons.js';

const portal = mountPortal('admin', [{ id: 'overview', label: 'Overview', icon: 'dashboard' }, { id: 'operations', label: 'Operations', icon: 'truck' }], 'Overview');
const { main } = portal;
const range = { date_from: '', date_to: '' };
let interval = 'day', charts = [], paints = [];
const cv = (n) => getComputedStyle(document.documentElement).getPropertyValue(n).trim();
const PALETTE = ['#6366f1', '#22c55e', '#f59e0b', '#ef4444', '#06b6d4', '#a855f7', '#ec4899', '#14b8a6', '#84cc16', '#f97316'];
const STATUS_COLORS = { Pending: '#f59e0b', Confirmed: '#3b82f6', Shipped: '#06b6d4', Delivered: '#22c55e', Cancelled: '#ef4444' };
const stat = (ic, v, l, cls = '') => `<div class="card stat ${cls}"><span class="stat__ic">${icon(ic)}</span><div><div class="stat__v">${v}</div><div class="stat__l">${l}</div></div></div>`;
const section = (t, body, extra = '') => `<section class="card"><div class="row row--between"><h3>${t}</h3>${extra}</div>${body}</section>`;
const table = (heads, rows) => rows.length ? `<div class="table-wrap"><table class="table"><thead><tr>${heads.map(([h, n]) => `<th class="${n ? 'num' : ''}">${h}</th>`).join('')}</tr></thead><tbody>${rows.join('')}</tbody></table></div>` : emptyState({ icon: 'search', title: 'No data for this period' });

// Chart.js styled from theme tokens; repainted when the theme toggles.
function chart(id, make) {
  const paint = () => {
    const el = document.getElementById(id); if (!el) return;
    Chart.getChart(el)?.destroy();
    Chart.defaults.color = cv('--muted'); Chart.defaults.font.family = cv('--font-body'); Chart.defaults.borderColor = cv('--border');
    charts.push(new Chart(el, make()));
  };
  paints.push(paint); paint();
}
window.addEventListener('themechange', () => paints.forEach((p) => p()));
const reset = () => { charts.forEach((c) => c.destroy()); charts = []; paints = []; };
const opts = (extra = {}) => ({ responsive: true, maintainAspectRatio: false, ...extra });
const q = () => ({ date_from: range.date_from || undefined, date_to: range.date_to || undefined });
const ok = (r) => (r.status === 'fulfilled' ? r.value : null);

function filterBar(withInterval) {
  return `<form class="row" id="flt" style="margin-bottom:var(--s5)"><div class="field" style="margin:0"><label for="df">From</label><input class="input" type="date" id="df" value="${range.date_from}"></div><div class="field" style="margin:0"><label for="dt">To</label><input class="input" type="date" id="dt" value="${range.date_to}"></div>
  ${withInterval ? `<div class="field" style="margin:0"><label for="iv">Trend interval</label><select class="select" id="iv">${['day', 'week', 'month'].map((i) => `<option ${i === interval ? 'selected' : ''}>${i}</option>`).join('')}</select></div>` : ''}
  <button class="btn btn--primary" style="align-self:flex-end">Apply</button><button class="btn" type="button" id="clr" style="align-self:flex-end">Clear</button><button class="btn btn--ghost" type="button" id="rf" style="align-self:flex-end">${icon('refresh')} Refresh</button></form>`;
}
function bindFilter(reload) {
  $('#flt').onsubmit = (e) => { e.preventDefault(); const a = $('#df').value, b = $('#dt').value; if (a && b && a > b) { toast('“From” date must be before “To” date.', 'warn'); return; } range.date_from = a; range.date_to = b; if ($('#iv')) interval = $('#iv').value; reload(); };
  $('#clr').onclick = () => { range.date_from = range.date_to = ''; reload(); }; $('#rf').onclick = reload;
}

async function overview() {
  reset(); main.innerHTML = skeletonRows(6);
  const res = await Promise.allSettled([
    api.reports.dashboard(),
    api.admin.summary(q()),
    api.admin["revenue-trend"]({ ...q(), interval }),
    api.admin["orders-by-status"](q()),
    api.admin["sales-by-category"](q()),
    api.admin["top-products"]({ ...q(), limit: 10 }),
  ]);
  const [ov, sum, trend, status, cat, top] = res.map(ok);
  if (res.every((r) => r.status === 'rejected')) { main.innerHTML = errorState(res[0].reason.message); $('[data-retry]').onclick = overview; return; }
  res.filter((r) => r.status === 'rejected').slice(0, 1).forEach((r) => toastError(r.reason));
  main.innerHTML = `${filterBar(true)}
  <div class="grid-stats">${
    sum
      ? stat(
          "rupee",
          moneyShort(sum.revenue),
          "Revenue (paid orders)",
          "stat--ok"
        ) +
        stat(
          "receipt",
          `${int(sum.paid_orders)} <span class="muted small">/ ${int(
            sum.total_orders
          )}</span>`,
          "Paid / total orders",
          "stat--info"
        ) +
        stat("trend", moneyShort(sum.avg_order_value), "Average order value") +
        stat(
          "refresh",
          moneyShort(sum.refunded_amount),
          "Refunded",
          "stat--warn"
        )
      : ""
  }
  ${
    ov
      ? stat("users", int(ov.total_customers), "Customers") +
        stat("store", int(ov.total_sellers), "Sellers") +
        stat("package", int(ov.total_products), "Products")
      : ""
  }</div>
  <div class="grid-charts">${section(
    "Revenue trend",
    '<div class="chart-box"><canvas id="c-trend" role="img" aria-label="Revenue trend line chart"></canvas></div>'
  )}${section(
    "Orders by status",
    '<div class="chart-box"><canvas id="c-status" role="img" aria-label="Orders by status doughnut chart"></canvas></div>'
  )}${section(
    "Sales by category",
    '<div class="chart-box" style="height:420px"><canvas id="c-cat" role="img" aria-label="Revenue by category bar chart"></canvas></div>'
  )}</div>
  ${section(
    "Top-selling products",
    top
      ? table(
          [["#"], ["Product"], ["Seller"], ["Units sold", 1], ["Revenue", 1]],
          top.map(
            (p, i) =>
              `<tr><td>${i + 1}</td><td><b>${esc(
                p.product_name
              )}</b></td><td>${esc(p.seller_name)}</td><td class="num">${int(
                p.units_sold
              )}</td><td class="num">${money(p.revenue)}</td></tr>`
          )
        )
      : ""
  )}`;
  bindFilter(overview);
  if (trend) chart('c-trend', () => ({ type: 'line', data: { labels: trend.map((r) => r.period), datasets: [{ label: 'Revenue (₹)', data: trend.map((r) => Number(r.revenue)), borderColor: PALETTE[0], backgroundColor: PALETTE[0] + '33', fill: true, tension: .3, pointRadius: 2 }] }, options: opts({ plugins: { legend: { display: false } }, scales: { y: { beginAtZero: true, ticks: { callback: (v) => '₹' + Intl.NumberFormat('en-IN', { notation: 'compact' }).format(v) } } } }) }));
  if (status) chart('c-status', () => ({ type: 'doughnut', data: { labels: status.map((s) => s.status), datasets: [{ data: status.map((s) => Number(s.orders)), backgroundColor: status.map((s) => STATUS_COLORS[s.status] || '#94a3b8'), borderColor: cv('--surface'), borderWidth: 2 }] }, options: opts({ cutout: '62%', plugins: { legend: { position: 'bottom' } } }) }));
  if (cat) chart('c-cat', () => ({ type: 'bar', data: { labels: cat.map((c) => c.category_name), datasets: [{ label: 'Revenue (₹)', data: cat.map((c) => Number(c.revenue)), backgroundColor: cat.map((_, i) => PALETTE[i % PALETTE.length]), borderRadius: 6 }] }, options: opts({ indexAxis: 'y', plugins: { legend: { display: false } }, scales: { y: { ticks: { autoSkip: false, font: { size: 11 } } }, x: { ticks: { callback: (v) => '₹' + Intl.NumberFormat('en-IN', { notation: 'compact' }).format(v) } } } }) }));
}

async function operations() {
  reset(); main.innerHTML = skeletonRows(6);
  const res = await Promise.allSettled([api.admin['top-sellers']({ ...q(), limit: 10 }), api.admin.payments(q()), api.admin.shipments(q()), api.admin['low-stock']({ limit: 25 }), api.admin['new-customers']({ ...q(), interval: 'month' })]);
  const [sellers, pays, ships, low, newc] = res.map(ok);
  if (res.every((r) => r.status === 'rejected')) { main.innerHTML = errorState(res[0].reason.message); $('[data-retry]').onclick = operations; return; }
  main.innerHTML = `${filterBar(false)}<div class="grid-charts">
  ${section('Top sellers', sellers ? table([['Seller'], ['Orders', 1], ['Units', 1], ['Revenue', 1]], sellers.map((s) => `<tr><td><b>${esc(s.seller_name)}</b></td><td class="num">${int(s.orders)}</td><td class="num">${int(s.units_sold)}</td><td class="num">${money(s.revenue)}</td></tr>`)) : '')}
  ${section('Payments', pays ? table([['Method'], ['Status'], ['Count', 1], ['Amount', 1]], pays.map((p) => `<tr><td>${esc(p.method)}</td><td>${badge(p.status)}</td><td class="num">${int(p.payments)}</td><td class="num">${money(p.amount)}</td></tr>`)) : '')}
  ${section('Shipments', ships ? table([['Status'], ['Shipments', 1], ['Avg days to deliver', 1]], ships.map((s) => `<tr><td>${badge(s.status)}</td><td class="num">${int(s.shipments)}</td><td class="num">${s.avg_days_to_deliver ?? '—'}</td></tr>`)) : '')}
  ${section('New customers per month', '<div class="chart-box"><canvas id="c-new" role="img" aria-label="New customers per month bar chart"></canvas></div>')}</div>
  <div class="cols" style="margin-top:var(--s5)">${section(`${icon('alert')} Low-stock products (platform-wide)`, low ? table([['Product'], ['Seller'], ['In stock', 1], ['Reorder at', 1]], low.map((p) => `<tr><td>${esc(p.product_name)}<div class="muted small">${esc(p.category_name)}</div></td><td>${esc(p.seller_name)}</td><td class="num">${p.quantity_in_stock === 0 ? '<span class="badge badge--danger">0</span>' : p.quantity_in_stock}</td><td class="num">${p.reorder_level}</td></tr>`)) : '')}
  ${section('Maintenance', `<p class="muted">Cancel orders that stayed unpaid for too long. Stock is returned to the shelf.</p><button class="btn btn--danger" id="expire">${icon('clock')} Expire unpaid orders…</button>`)}</div>`;
  bindFilter(operations);
  $('#expire').onclick = () => formModal({ title: 'Expire unpaid orders', submitLabel: 'Cancel unpaid orders', danger: true, intro: 'Every order that is still unpaid after this many minutes will be cancelled.', fields: [{ name: 'minutes', label: 'Unpaid for more than (minutes)', type: 'number', min: 1, max: 10080, step: 1, value: 30, required: true, full: true }], onSubmit: async (v) => { const r = await api.orders.expireUnpaid(Number(v.minutes)); toast(`${r.cancelled} unpaid order${r.cancelled === 1 ? '' : 's'} cancelled.`, 'success'); } });
  if (newc) chart('c-new', () => ({ type: 'bar', data: { labels: newc.map((r) => r.period.slice(0, 7)), datasets: [{ label: 'New customers', data: newc.map((r) => Number(r.new_customers)), backgroundColor: PALETTE[4], borderRadius: 4 }] }, options: opts({ plugins: { legend: { display: false } }, scales: { y: { beginAtZero: true, ticks: { precision: 0 } }, x: { ticks: { maxTicksLimit: 8 } } } }) }));
}

const routes = { overview, operations };
const go = () => routes[portal.route()]().catch(toastError);
window.addEventListener('hashchange', go);
go();
