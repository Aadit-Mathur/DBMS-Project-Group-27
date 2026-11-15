import { api } from '../js/api.js';
import { mountPortal } from '../js/layout.js';
import { money, moneyShort, int, esc, displayName, productImage } from '../js/format.js';
import { errorState, emptyState, skeletonRows, $ } from '../js/dom.js';
import { toast, toastError } from '../js/toast.js';
import { formModal } from '../js/modal.js';
import { icon } from '../js/icons.js';

const portal = mountPortal('admin', [{ id: 'overview', label: 'Overview', icon: 'dashboard' }, { id: 'operations', label: 'Operations', icon: 'truck' }], 'Overview');
const { main, actions } = portal;

// ---- date range (shared by both tabs) ---------------------------------------------------------
const PRESETS = [['7', 'Last 7 days'], ['30', 'Last 30 days'], ['90', 'Last 90 days'], ['all', 'All time']];
const range = { preset: 'all', from: '', to: '' };
let interval = 'week', paints = [];
const iso = (d) => new Date(d.getTime() - d.getTimezoneOffset() * 60000).toISOString().slice(0, 10);
function q() {
  if (range.preset === 'custom') return { date_from: range.from || undefined, date_to: range.to || undefined };
  if (range.preset === 'all') return {};
  const to = new Date(), from = new Date(); from.setDate(to.getDate() - Number(range.preset) + 1);
  return { date_from: iso(from), date_to: iso(to) };
}
const rangeLabel = () => range.preset === 'custom' ? `${range.from || 'start'} to ${range.to || 'today'}` : PRESETS.find(([k]) => k === range.preset)[1].toLowerCase();

function rangeBar(reload) {
  actions.innerHTML = `<div class="rangebar" role="group" aria-label="Date range">${PRESETS.map(([k, l]) => `<button type="button" class="chip" data-range="${k}" aria-pressed="${range.preset === k}">${l}</button>`).join('')}
    <button type="button" class="chip" data-range="custom" aria-pressed="${range.preset === 'custom'}">${icon('clock')} Custom</button>
    <button type="button" class="btn btn--ghost btn--icon" id="rf" aria-label="Refresh" title="Refresh">${icon('refresh')}</button></div>
    <form class="rangecustom" id="rc" ${range.preset === 'custom' ? '' : 'hidden'}><label class="sr-only" for="df">From</label><input class="input" type="date" id="df" value="${range.from}">
    <span class="muted small">to</span><label class="sr-only" for="dt">To</label><input class="input" type="date" id="dt" value="${range.to}"><button class="btn btn--primary btn--sm">Apply</button></form>`;
  actions.querySelectorAll('[data-range]').forEach((b) => (b.onclick = () => {
    if (b.dataset.range === 'custom') { range.preset = 'custom'; $('#rc').hidden = false; actions.querySelectorAll('[data-range]').forEach((x) => x.setAttribute('aria-pressed', x === b)); $('#df').focus(); return; }
    range.preset = b.dataset.range; reload();
  }));
  $('#rf').onclick = reload;
  $('#rc').onsubmit = (e) => { e.preventDefault(); const a = $('#df').value, z = $('#dt').value; if (a && z && a > z) { toast('The start date is after the end date.', 'warn'); return; } range.from = a; range.to = z; reload(); };
}

// ---- small building blocks --------------------------------------------------------------------
const panel = (title, body, aside = '', cls = '') => `<section class="panel ${cls}"><div class="panel__head"><h2>${title}</h2>${aside}</div>${body}</section>`;
const table = (heads, rows, empty = 'Nothing in this date range') => rows.length ? `<div class="table-wrap table-wrap--flat"><table class="table"><thead><tr>${heads.map(([h, n]) => `<th class="${n ? 'num' : ''}">${h}</th>`).join('')}</tr></thead><tbody>${rows.join('')}</tbody></table></div>` : `<p class="muted small">${empty}</p>`;
const STATUS_TONE = { Pending: 'var(--warn)', Confirmed: 'var(--brand)', Shipped: 'color-mix(in srgb, var(--brand) 60%, var(--surface))', 'In Transit': 'color-mix(in srgb, var(--brand) 45%, var(--surface))', Delivered: 'var(--success)', Cancelled: 'var(--danger)' };
// Labelled bar list: label, bar, value. Cleaner than a chart for a handful of categories.
function hbars(rows, { value, sub = () => '', color = () => 'var(--brand)', max } = {}) {
  const top = max ?? Math.max(1, ...rows.map((r) => r.v));
  return `<ul class="hbars">${rows.map((r) => `<li class="hbar"><span class="hbar__l" title="${esc(r.label)}">${esc(r.label)}</span><span class="hbar__track" aria-hidden="true"><span class="hbar__fill" style="width:${Math.max(1.5, (r.v / top) * 100)}%;background:${color(r)}"></span></span><span class="hbar__v">${value(r)}<small>${sub(r)}</small></span></li>`).join('')}</ul>`;
}
const fmtDay = (s, withYear) => new Intl.DateTimeFormat('en-IN', withYear ? { day: 'numeric', month: 'short', year: 'numeric' } : { day: 'numeric', month: 'short' }).format(new Date(s));
const fmtMonth = (s) => new Intl.DateTimeFormat('en-IN', { month: 'short', year: '2-digit' }).format(new Date(s));
const lakh = (v) => v >= 1e7 ? `₹${+(v / 1e7).toFixed(1)}Cr` : v >= 1e5 ? `₹${+(v / 1e5).toFixed(1)}L` : v >= 1e3 ? `₹${+(v / 1e3).toFixed(0)}K` : `₹${v}`;

// Chart.js styled from the theme tokens; repainted on theme change.
const cv = (n) => getComputedStyle(document.documentElement).getPropertyValue(n).trim();
function chart(id, make) {
  const paint = () => {
    const el = document.getElementById(id); if (!el) return;
    Chart.getChart(el)?.destroy();
    Object.assign(Chart.defaults, { color: cv('--muted'), borderColor: cv('--line') });
    Chart.defaults.font.family = cv('--font'); Chart.defaults.font.size = 12;
    Object.assign(Chart.defaults.plugins.tooltip, { backgroundColor: cv('--ink'), titleColor: cv('--surface'), bodyColor: cv('--surface'), padding: 10, cornerRadius: 6, displayColors: false, titleFont: { weight: '600' } });
    new Chart(el, make({ hue: cv('--brand'), surface: cv('--surface'), line: cv('--line') }));
  };
  paints.push(paint); paint();
}
window.addEventListener('themechange', () => paints.forEach((p) => p()));
const base = (extra = {}) => ({ responsive: true, maintainAspectRatio: false, animation: { duration: 350 }, plugins: { legend: { display: false } }, ...extra });

// ---- Overview ---------------------------------------------------------------------------------
async function overview() {
  paints = []; rangeBar(overview); main.innerHTML = skeletonRows(6);
  const res = await Promise.allSettled([api.admin.overview(), api.admin.summary(q()), api.admin['revenue-trend']({ ...q(), interval }), api.admin['orders-by-status'](q()), api.admin['sales-by-category'](q()), api.admin['top-products']({ ...q(), limit: 8 })]);
  const [ov, sum, trend, status, cat, top] = res.map((r) => (r.status === 'fulfilled' ? r.value : null));
  if (res.every((r) => r.status === 'rejected')) { main.innerHTML = `<div class="panel">${errorState(res[0].reason.message)}</div>`; $('[data-retry]').onclick = overview; return; }
  res.filter((r) => r.status === 'rejected').slice(0, 1).forEach((r) => toastError(r.reason));
  const totalRev = trend ? trend.reduce((n, r) => n + Number(r.revenue), 0) : 0;
  const statusTotal = status ? status.reduce((n, s) => n + Number(s.orders), 0) : 0;
  const cats = cat ? [...cat].sort((a, b) => b.revenue - a.revenue) : [];
  const catRows = cats.slice(0, 8).map((c) => ({ label: c.category_name, v: Number(c.revenue), pct: c.pct_of_revenue }));
  if (cats.length > 8) { const rest = cats.slice(8); catRows.push({ label: `Other ${rest.length} categories`, v: rest.reduce((n, c) => n + Number(c.revenue), 0), pct: +rest.reduce((n, c) => n + Number(c.pct_of_revenue), 0).toFixed(1), other: true }); }

  main.innerHTML = `
  ${sum ? `<section class="panel panel--flush kpis-panel" aria-label="Key figures for ${rangeLabel()}"><div class="kpis">
    <div class="kpi"><span class="kpi__l">Revenue</span><span class="kpi__v">${moneyShort(sum.revenue)}</span><span class="kpi__s">from paid orders, ${rangeLabel()}</span></div>
    <div class="kpi"><span class="kpi__l">Paid orders</span><span class="kpi__v">${int(sum.paid_orders)}</span><span class="kpi__s">of ${int(sum.total_orders)} placed (${sum.total_orders ? Math.round(sum.paid_orders / sum.total_orders * 100) : 0}%)</span></div>
    <div class="kpi"><span class="kpi__l">Average paid order</span><span class="kpi__v">${moneyShort(sum.avg_order_value)}</span><span class="kpi__s">per paid order</span></div>
    <div class="kpi"><span class="kpi__l">Refunded</span><span class="kpi__v">${moneyShort(sum.refunded_amount)}</span><span class="kpi__s">returned on cancelled orders</span></div></div>
    ${ov ? `<div class="kpis__foot"><span>${icon('users')}<b>${int(ov.customers)}</b> customers</span><span>${icon('store')}<b>${int(ov.sellers)}</b> sellers</span><span>${icon('package')}<b>${int(ov.active_products)}</b> of ${int(ov.products)} products listed</span></div>` : ''}</section>` : ''}
  ${panel('Revenue', trend && trend.length ? `<div class="chart-box chart-box--tall"><canvas id="c-trend" role="img" aria-label="Revenue per ${interval}, ${rangeLabel()}"></canvas></div>` : emptyState({ icon: 'trend', title: 'No paid orders in this range' }),
    `<div class="row"><span class="muted small">${trend ? `${moneyShort(totalRev)} over ${trend.length} ${interval}${trend.length === 1 ? '' : 's'}` : ''}</span><div class="seg" role="group" aria-label="Group revenue by">${['day', 'week', 'month'].map((i) => `<button type="button" data-iv="${i}" aria-pressed="${i === interval}">${i[0].toUpperCase() + i.slice(1)}</button>`).join('')}</div></div>`)}
  <div class="cols cols--even">
    ${panel('Orders by status', status && status.length ? hbars(['Pending', 'Confirmed', 'Shipped', 'Delivered', 'Cancelled'].map((k) => ({ label: k, v: Number(status.find((s) => s.status === k)?.orders || 0) })),
      { value: (r) => int(r.v), sub: (r) => `${statusTotal ? Math.round(r.v / statusTotal * 100) : 0}%`, color: (r) => STATUS_TONE[r.label], max: Math.max(...status.map((s) => Number(s.orders))) }) : '<p class="muted small">No orders in this range.</p>', `<span class="muted small">${int(statusTotal)} orders</span>`)}
    ${panel('Revenue by category', catRows.length ? hbars(catRows, { value: (r) => lakh(r.v), sub: (r) => `${r.pct}%`, color: (r) => (r.other ? 'var(--line-strong)' : 'var(--brand)'), max: catRows[0].v }) : '<p class="muted small">No paid orders in this range.</p>', '<span class="muted small">Share of paid revenue</span>')}
  </div>
  ${panel('Top-selling products', top ? table([['#'], ['Product'], ['Seller'], ['Units', 1], ['Revenue', 1]], top.map((p, i) => `<tr><td class="num muted">${i + 1}</td><td><div class="prod-cell">${productImage(p, 'pimg--xs')}<b class="clamp-2">${esc(displayName(p.product_name))}</b></div></td><td class="small">${esc(p.seller_name)}</td><td class="num">${int(p.units_sold)}</td><td class="num">${money(p.revenue)}</td></tr>`)) : '', '<span class="muted small">By units sold, paid orders only</span>')}`;

  main.querySelectorAll('[data-iv]').forEach((b) => (b.onclick = () => { interval = b.dataset.iv; overview(); }));
  if (trend && trend.length) chart('c-trend', (c) => ({
    type: 'line',
    data: { labels: trend.map((r) => (interval === 'month' ? fmtMonth(r.period) : fmtDay(r.period))), datasets: [{ data: trend.map((r) => Number(r.revenue)), borderColor: c.hue, borderWidth: 2.5, tension: 0.35, cubicInterpolationMode: 'monotone', pointRadius: interval === 'day' ? 0 : 3, pointBackgroundColor: c.hue, pointBorderColor: c.surface, pointBorderWidth: 2, pointHoverRadius: 6, fill: true,
      backgroundColor: (ctx) => { const { ctx: g, chartArea: a } = ctx.chart; if (!a) return 'transparent'; const gr = g.createLinearGradient(0, a.top, 0, a.bottom); gr.addColorStop(0, c.hue + '40'); gr.addColorStop(1, c.hue + '00'); return gr; } }] },
    options: base({ interaction: { mode: 'index', intersect: false },
      plugins: { legend: { display: false }, tooltip: { callbacks: { title: (x) => (interval === 'week' ? 'Week of ' : '') + (interval === 'month' ? new Intl.DateTimeFormat('en-IN', { month: 'long', year: 'numeric' }).format(new Date(trend[x[0].dataIndex].period)) : fmtDay(trend[x[0].dataIndex].period, true)),
        label: (x) => `${money(x.parsed.y)} from ${int(trend[x.dataIndex].orders)} paid order${trend[x.dataIndex].orders === 1 ? '' : 's'}` } } },
      scales: { y: { beginAtZero: true, grid: { color: c.line, drawTicks: false }, border: { display: false }, ticks: { callback: lakh, padding: 10, maxTicksLimit: 5 } },
        x: { grid: { display: false }, border: { display: false }, ticks: { maxTicksLimit: interval === 'day' ? 8 : 10, maxRotation: 0, autoSkipPadding: 18, padding: 6 } } } }),
  }));
}

// ---- Operations -------------------------------------------------------------------------------
async function operations() {
  paints = []; rangeBar(operations); main.innerHTML = skeletonRows(6);
  const res = await Promise.allSettled([api.admin['top-sellers']({ ...q(), limit: 8 }), api.admin.payments(q()), api.admin.shipments(q()), api.admin['low-stock']({ limit: 12 }), api.admin['new-customers']({ ...q(), interval: 'month' })]);
  const [sellers, pays, ships, low, newc] = res.map((r) => (r.status === 'fulfilled' ? r.value : null));
  if (res.every((r) => r.status === 'rejected')) { main.innerHTML = `<div class="panel">${errorState(res[0].reason.message)}</div>`; $('[data-retry]').onclick = operations; return; }
  res.filter((r) => r.status === 'rejected').slice(0, 1).forEach((r) => toastError(r.reason));

  // Payments pivot: one row per method, counts per status, amount collected from successful payments.
  const PST = ['Successful', 'Failed', 'Pending', 'Refunded'];
  const methods = pays ? [...new Set(pays.map((p) => p.method))].sort() : [];
  const cell = (m, s) => pays.find((p) => p.method === m && p.status === s);
  const payRows = methods.map((m) => `<tr><td><b>${esc(m)}</b></td>${PST.map((s) => `<td class="num ${s === 'Failed' && cell(m, s) ? 'tone-danger' : ''}">${cell(m, s) ? int(cell(m, s).payments) : '<span class="muted">0</span>'}</td>`).join('')}<td class="num">${money(cell(m, 'Successful')?.amount || 0)}</td></tr>`);
  const shipOrder = ['Pending', 'Shipped', 'In Transit', 'Delivered', 'Cancelled'];
  const delivered = ships?.find((s) => s.status === 'Delivered');
  const months = newc ? (range.preset === 'all' ? newc.slice(-12) : newc) : [];

  main.innerHTML = `<div class="cols cols--even">
    ${panel('Payments', pays ? table([['Method'], ...PST.map((s) => [s, 1]), ['Collected', 1]], payRows) : '', '<span class="muted small">Number of payments by result</span>')}
    ${panel('Shipments', ships ? `<div class="kpi kpi--inline"><span class="kpi__l">Average time to deliver</span><span class="kpi__v">${delivered?.avg_days_to_deliver != null ? `${delivered.avg_days_to_deliver} days` : '—'}</span><span class="kpi__s">from shipping to delivery, ${int(delivered?.shipments || 0)} delivered</span></div>
      ${hbars(shipOrder.map((k) => ({ label: k, v: Number(ships.find((s) => s.status === k)?.shipments || 0) })), { value: (r) => int(r.v), color: (r) => STATUS_TONE[r.label] })}` : '')}
  </div>
  <div class="cols cols--even">
    ${panel('New customers', months.length ? `<div class="chart-box"><canvas id="c-new" role="img" aria-label="New customer sign-ups per month"></canvas></div>` : '<p class="muted small">No sign-ups in this range.</p>', `<span class="muted small">${range.preset === 'all' ? 'Last 12 months' : 'Per month'}</span>`)}
    ${panel('Top sellers', sellers ? table([['#'], ['Seller'], ['Orders', 1], ['Units', 1], ['Revenue', 1]], sellers.map((s, i) => `<tr><td class="num muted">${i + 1}</td><td><b>${esc(s.seller_name)}</b></td><td class="num">${int(s.orders)}</td><td class="num">${int(s.units_sold)}</td><td class="num">${money(s.revenue)}</td></tr>`)) : '', '<span class="muted small">By paid revenue</span>')}
  </div>
  <div class="cols">
    ${panel(`${icon('alert')} Low stock across the marketplace`, low ? table([['Product'], ['Seller'], ['In stock', 1], ['Alert at', 1]], low.map((p) => `<tr><td><div class="prod-cell">${productImage(p, 'pimg--xs')}<div><b>${esc(displayName(p.product_name))}</b><span class="muted xsmall">${esc(p.category_name)}</span></div></div></td><td class="small">${esc(p.seller_name)}</td><td class="num">${p.quantity_in_stock === 0 ? '<span class="badge badge--danger">Sold out</span>' : int(p.quantity_in_stock)}</td><td class="num">${int(p.reorder_level)}</td></tr>`), 'No product is low on stock.') : '', '<span class="muted small">View v_low_stock_products</span>')}
    ${panel('Unpaid orders', `<p class="small" style="color:var(--ink-2)">Cancel orders that were never paid. The database function expire_unpaid_orders() cancels them in one transaction and puts their items back in stock.</p><button class="btn btn--danger btn--block" id="expire">${icon('clock')} Cancel unpaid orders…</button>`)}
  </div>`;

  $('#expire').onclick = () => formModal({ title: 'Cancel unpaid orders', submitLabel: 'Cancel unpaid orders', danger: true, intro: 'Every order still unpaid after this many minutes is cancelled and its stock returned. This cannot be undone.', fields: [{ name: 'minutes', label: 'Unpaid for more than (minutes)', type: 'number', min: 1, max: 10080, step: 1, value: 30, required: true, full: true }],
    onSubmit: async (v) => { const r = await api.orders.expireUnpaid(Number(v.minutes)); toast(r.cancelled ? `${r.cancelled} unpaid order${r.cancelled === 1 ? '' : 's'} cancelled.` : 'No orders were unpaid for that long.', 'success'); } });
  if (months.length) chart('c-new', (c) => ({ type: 'bar',
    data: { labels: months.map((r) => fmtMonth(r.period)), datasets: [{ data: months.map((r) => Number(r.new_customers)), backgroundColor: c.hue, borderRadius: 4, borderSkipped: 'start', maxBarThickness: 28 }] },
    options: base({ plugins: { legend: { display: false }, tooltip: { callbacks: { title: (x) => new Intl.DateTimeFormat('en-IN', { month: 'long', year: 'numeric' }).format(new Date(months[x[0].dataIndex].period)), label: (x) => `${int(x.parsed.y)} new customers` } } },
      scales: { y: { beginAtZero: true, grid: { color: c.line, drawTicks: false }, border: { display: false }, ticks: { precision: 0, maxTicksLimit: 5, padding: 8 } }, x: { grid: { display: false }, border: { display: false }, ticks: { maxRotation: 0, autoSkipPadding: 12 } } } }) }));
}

const routes = { overview, operations };
const go = () => routes[portal.route()]().catch(toastError);
window.addEventListener('hashchange', go);
go();
