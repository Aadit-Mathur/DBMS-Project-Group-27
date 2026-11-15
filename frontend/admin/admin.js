import { api } from '../js/api.js';
import { mountPortal } from '../js/layout.js';
import { money, moneyShort, int, esc, badge, displayName, productImage } from '../js/format.js';
import { errorState, emptyState, skeletonRows, $ } from '../js/dom.js';
import { toast, toastError } from '../js/toast.js';
import { formModal } from '../js/modal.js';
import { icon } from '../js/icons.js';

const portal = mountPortal('admin', [{ id: 'overview', label: 'Overview', icon: 'dashboard' }, { id: 'operations', label: 'Operations', icon: 'truck' }], 'Overview');
const { main, actions } = portal;
const range = { date_from: '', date_to: '' };
let interval = 'day', paints = [];
const cv = (n) => getComputedStyle(document.documentElement).getPropertyValue(n).trim();
const inr = (v) => '₹' + Intl.NumberFormat('en-IN', { notation: 'compact', maximumFractionDigits: 1 }).format(v);
const stat = (ic, v, l, cls = '') => `<div class="stat ${cls}"><span class="stat__ic">${icon(ic)}</span><div><div class="stat__v">${v}</div><div class="stat__l">${l}</div></div></div>`;
const section = (t, body, note = '') => `<section class="panel"><div class="panel__head"><h2>${t}</h2>${note ? `<span class="muted xsmall">${note}</span>` : ''}</div>${body}</section>`;
const table = (heads, rows) => rows.length ? `<div class="table-wrap"><table class="table"><thead><tr>${heads.map(([h, n]) => `<th class="${n ? 'num' : ''}">${h}</th>`).join('')}</tr></thead><tbody>${rows.join('')}</tbody></table></div>` : emptyState({ icon: 'search', title: 'No data in this date range', text: 'Widen the dates or clear them.' });
const q = () => ({ date_from: range.date_from || undefined, date_to: range.date_to || undefined });
const ok = (r) => (r.status === 'fulfilled' ? r.value : null);

// Chart.js styled from the theme tokens: one hue per chart (single series), thin marks, recessive grid.
function chart(id, make) {
  const paint = () => {
    const el = document.getElementById(id); if (!el) return;
    Chart.getChart(el)?.destroy();
    Object.assign(Chart.defaults, { color: cv('--muted'), borderColor: cv('--line') });
    Chart.defaults.font.family = cv('--font'); Chart.defaults.font.size = 12;
    Object.assign(Chart.defaults.plugins.tooltip, { backgroundColor: cv('--ink'), titleColor: cv('--surface'), bodyColor: cv('--surface'), padding: 10, cornerRadius: 6, displayColors: false });
    new Chart(el, make({ hue: cv('--brand'), surface: cv('--surface'), line: cv('--line') }));
  };
  paints.push(paint); paint();
}
window.addEventListener('themechange', () => paints.forEach((p) => p()));
const opts = (extra = {}) => ({ responsive: true, maintainAspectRatio: false, animation: { duration: 400 }, plugins: { legend: { display: false } }, ...extra });
const grid = (c) => ({ grid: { color: c.line, drawTicks: false }, border: { display: false } });

function filterBar(withInterval) {
  return `<form class="toolbar" id="flt"><div class="field"><label for="df">From</label><input class="input" type="date" id="df" value="${range.date_from}"></div><div class="field"><label for="dt">To</label><input class="input" type="date" id="dt" value="${range.date_to}"></div>
  ${withInterval ? `<div class="field"><label for="iv">Group revenue by</label><select class="select" id="iv">${[['day', 'Day'], ['week', 'Week'], ['month', 'Month']].map(([v, l]) => `<option value="${v}" ${v === interval ? 'selected' : ''}>${l}</option>`).join('')}</select></div>` : ''}
  <button class="btn btn--primary">Apply</button><button class="btn" type="button" id="clr">All time</button>
  <span class="muted xsmall" style="margin:0 0 .6rem auto">Revenue counts only orders with a successful payment. End date is included.</span></form>`;
}
function bindFilter(reload) {
  $('#flt').onsubmit = (e) => { e.preventDefault(); const a = $('#df').value, b = $('#dt').value; if (a && b && a > b) { toast('The start date is after the end date. Swap them and apply again.', 'warn'); return; } range.date_from = a; range.date_to = b; if ($('#iv')) interval = $('#iv').value; reload(); };
  $('#clr').onclick = () => { range.date_from = range.date_to = ''; reload(); };
}
const refresh = (fn) => { actions.innerHTML = `<button class="btn" id="rf">${icon('refresh')} Refresh</button>`; $('#rf').onclick = fn; };

async function overview() {
  paints = []; refresh(overview); main.innerHTML = skeletonRows(6);
  const res = await Promise.allSettled([api.admin.overview(), api.admin.summary(q()), api.admin['revenue-trend']({ ...q(), interval }), api.admin['orders-by-status'](q()), api.admin['sales-by-category'](q()), api.admin['top-products']({ ...q(), limit: 10 })]);
  const [ov, sum, trend, status, cat, top] = res.map(ok);
  if (res.every((r) => r.status === 'rejected')) { main.innerHTML = `<div class="panel">${errorState(res[0].reason.message)}</div>`; $('[data-retry]').onclick = overview; return; }
  res.filter((r) => r.status === 'rejected').slice(0, 1).forEach((r) => toastError(r.reason));
  main.innerHTML = `${filterBar(true)}
  <div class="grid-stats">${sum ? stat('rupee', moneyShort(sum.revenue), 'Revenue from paid orders', 'stat--ok') + stat('receipt', `${int(sum.paid_orders)} <span class="muted small">of ${int(sum.total_orders)}</span>`, 'Orders paid') + stat('trend', moneyShort(sum.avg_order_value), 'Average paid order') + stat('rotate', moneyShort(sum.refunded_amount), 'Refunded', Number(sum.refunded_amount) ? 'stat--warn' : '') : ''}
  ${ov ? stat('users', int(ov.customers), 'Customers') + stat('store', int(ov.sellers), 'Sellers') + stat('package', `${int(ov.active_products)} <span class="muted small">of ${int(ov.products)}</span>`, 'Products listed') : ''}</div>
  <div class="grid-charts">${section('Revenue', '<div class="chart-box"><canvas id="c-trend" role="img" aria-label="Line chart of revenue over time"></canvas></div>', `Per ${interval}`)}${section('Orders by status', '<div class="chart-box"><canvas id="c-status" role="img" aria-label="Bar chart of order counts by status"></canvas></div>')}</div>
  <div class="cols" style="grid-template-columns:minmax(0,1fr) minmax(0,1fr);margin-bottom:var(--s4)">${section('Revenue by category', '<div class="chart-box" style="height:440px"><canvas id="c-cat" role="img" aria-label="Bar chart of revenue by category"></canvas></div>')}
  ${section('Top-selling products', top ? table([['Product'], ['Seller'], ['Units', 1], ['Revenue', 1]], top.map((p) => `<tr><td><div class="prod-cell" style="min-width:0">${productImage(p, 'pimg--xs')}<b class="clamp-2">${esc(displayName(p.product_name))}</b></div></td><td class="small">${esc(p.seller_name)}</td><td class="num">${int(p.units_sold)}</td><td class="num">${money(p.revenue)}</td></tr>`)) : '', 'By units sold')}</div>`;
  bindFilter(overview);
  if (trend) chart('c-trend', (c) => ({ type: 'line', data: { labels: trend.map((r) => r.period), datasets: [{ label: 'Revenue', data: trend.map((r) => Number(r.revenue)), borderColor: c.hue, backgroundColor: c.hue + '22', fill: true, tension: 0.25, borderWidth: 2, pointRadius: 0, pointHoverRadius: 5, pointHoverBackgroundColor: c.hue, pointHoverBorderColor: c.surface, pointHoverBorderWidth: 2 }] },
    options: opts({ interaction: { mode: 'index', intersect: false }, plugins: { legend: { display: false }, tooltip: { callbacks: { label: (x) => ` ${money(x.parsed.y)}` } } }, scales: { y: { beginAtZero: true, ...grid(c), ticks: { callback: inr, padding: 8 } }, x: { grid: { display: false }, ticks: { maxTicksLimit: 8, maxRotation: 0 } } } }) }));
  if (status) { const s = [...status].sort((a, b) => b.orders - a.orders); chart('c-status', (c) => ({ type: 'bar', data: { labels: s.map((r) => r.status), datasets: [{ label: 'Orders', data: s.map((r) => Number(r.orders)), backgroundColor: c.hue, borderRadius: 4, borderSkipped: 'start', maxBarThickness: 28 }] },
    options: opts({ indexAxis: 'y', plugins: { legend: { display: false }, tooltip: { callbacks: { label: (x) => ` ${int(x.parsed.x)} orders` } } }, scales: { x: { beginAtZero: true, ...grid(c), ticks: { precision: 0 } }, y: { grid: { display: false }, border: { display: false } } } }) })); }
  if (cat) { const s = [...cat].sort((a, b) => b.revenue - a.revenue); chart('c-cat', (c) => ({ type: 'bar', data: { labels: s.map((r) => r.category_name), datasets: [{ label: 'Revenue', data: s.map((r) => Number(r.revenue)), backgroundColor: c.hue, borderRadius: 4, borderSkipped: 'start', maxBarThickness: 18 }] },
    options: opts({ indexAxis: 'y', plugins: { legend: { display: false }, tooltip: { callbacks: { label: (x) => ` ${money(x.parsed.x)}, ${s[x.dataIndex].pct_of_revenue}% of revenue` } } }, scales: { x: { beginAtZero: true, ...grid(c), ticks: { callback: inr } }, y: { grid: { display: false }, border: { display: false }, ticks: { autoSkip: false, font: { size: 11 } } } } }) })); }
}

async function operations() {
  paints = []; refresh(operations); main.innerHTML = skeletonRows(6);
  const res = await Promise.allSettled([api.admin['top-sellers']({ ...q(), limit: 10 }), api.admin.payments(q()), api.admin.shipments(q()), api.admin['low-stock']({ limit: 25 }), api.admin['new-customers']({ ...q(), interval: 'month' })]);
  const [sellers, pays, ships, low, newc] = res.map(ok);
  if (res.every((r) => r.status === 'rejected')) { main.innerHTML = `<div class="panel">${errorState(res[0].reason.message)}</div>`; $('[data-retry]').onclick = operations; return; }
  main.innerHTML = `${filterBar(false)}<div class="grid-charts">
  ${section('Top sellers', sellers ? table([['Seller'], ['Orders', 1], ['Units', 1], ['Revenue', 1]], sellers.map((s) => `<tr><td><b>${esc(s.seller_name)}</b></td><td class="num">${int(s.orders)}</td><td class="num">${int(s.units_sold)}</td><td class="num">${money(s.revenue)}</td></tr>`)) : '', 'By revenue')}
  ${section('Payments', pays ? table([['Method'], ['Status'], ['Count', 1], ['Amount', 1]], pays.map((p) => `<tr><td>${esc(p.method)}</td><td>${badge(p.status)}</td><td class="num">${int(p.payments)}</td><td class="num">${money(p.amount)}</td></tr>`)) : '')}
  ${section('Shipments', ships ? table([['Status'], ['Shipments', 1], ['Average days to deliver', 1]], ships.map((s) => `<tr><td>${badge(s.status)}</td><td class="num">${int(s.shipments)}</td><td class="num">${s.avg_days_to_deliver ?? '—'}</td></tr>`)) : '')}
  ${section('New customers', '<div class="chart-box"><canvas id="c-new" role="img" aria-label="Bar chart of new customer sign-ups per month"></canvas></div>', 'Per month')}</div>
  <div class="cols">${section(`${icon('alert')} Low stock across the marketplace`, low ? table([['Product'], ['Seller'], ['In stock', 1], ['Alert at', 1]], low.map((p) => `<tr><td><div class="prod-cell">${productImage(p, 'pimg--xs')}<div><b>${esc(displayName(p.product_name))}</b><span class="muted xsmall">${esc(p.category_name)}</span></div></div></td><td class="small">${esc(p.seller_name)}</td><td class="num">${p.quantity_in_stock === 0 ? '<span class="badge badge--danger">0</span>' : p.quantity_in_stock}</td><td class="num">${p.reorder_level}</td></tr>`)) : '', 'View v_low_stock_products')}
  ${section('Unpaid orders', `<p class="muted small">Cancel orders that stayed unpaid too long. The database function expire_unpaid_orders() cancels them in one transaction and returns their items to stock.</p><button class="btn btn--danger" id="expire">${icon('clock')} Cancel unpaid orders…</button>`)}</div>`;
  bindFilter(operations);
  $('#expire').onclick = () => formModal({ title: 'Cancel unpaid orders', submitLabel: 'Cancel unpaid orders', danger: true, intro: 'Every order still unpaid after this many minutes is cancelled and its stock returned. This cannot be undone.', fields: [{ name: 'minutes', label: 'Unpaid for more than (minutes)', type: 'number', min: 1, max: 10080, step: 1, value: 30, required: true, full: true }],
    onSubmit: async (v) => { const r = await api.orders.expireUnpaid(Number(v.minutes)); toast(r.cancelled ? `${r.cancelled} unpaid order${r.cancelled === 1 ? '' : 's'} cancelled.` : 'No orders were unpaid for that long.', 'success'); } });
  if (newc) chart('c-new', (c) => ({ type: 'bar', data: { labels: newc.map((r) => String(r.period).slice(0, 7)), datasets: [{ label: 'New customers', data: newc.map((r) => Number(r.new_customers)), backgroundColor: c.hue, borderRadius: 4, borderSkipped: 'start', maxBarThickness: 26 }] },
    options: opts({ plugins: { legend: { display: false }, tooltip: { callbacks: { label: (x) => ` ${int(x.parsed.y)} new customers` } } }, scales: { y: { beginAtZero: true, ...grid(c), ticks: { precision: 0 } }, x: { grid: { display: false }, ticks: { maxTicksLimit: 10, maxRotation: 0 } } } }) }));
}

const routes = { overview, operations };
const go = () => routes[portal.route()]().catch(toastError);
window.addEventListener('hashchange', go);
go();
