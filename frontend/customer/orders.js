import { api } from '../js/api.js';
import { mountStore } from '../js/layout.js';
import { session } from '../js/state.js';
import { money, date, esc, badge } from '../js/format.js';
import { emptyState, errorState, skeletonRows, $ } from '../js/dom.js';

const main = mountStore('orders'), me = session.get(), LIMIT = 15, STATUSES = ['', 'Pending', 'Confirmed', 'Shipped', 'Delivered', 'Cancelled'];
let status = '', rows = [];
main.innerHTML = `<div class="page-head"><h1>My orders</h1></div><div class="tabs" role="tablist" id="tabs">${STATUSES.map((s) => `<button role="tab" data-s="${s}" aria-selected="${s === ''}">${s || 'All'}</button>`).join('')}</div><div id="list"></div><div id="more" class="row" style="justify-content:center;margin-top:var(--s4)"></div>`;
const list = $('#list');
async function load(reset = true) {
  if (reset) { rows = []; list.innerHTML = skeletonRows(); $('#more').innerHTML = ''; }
  try {
    const page = await api.customers.orders(me.id, { status, limit: LIMIT, offset: rows.length }); rows.push(...page);
    if (!rows.length) { list.innerHTML = emptyState({ icon: 'receipt', title: status ? `No ${status.toLowerCase()} orders` : 'No orders yet', text: 'Orders you place will appear here.', action: '<a class="btn btn--primary" href="shop.html">Start shopping</a>' }); return; }
    list.innerHTML = `<div class="table-wrap"><table class="table"><thead><tr><th>Order</th><th>Date</th><th class="num">Items</th><th class="num">Total</th><th>Status</th><th>Payment</th><th>Shipment</th><th></th></tr></thead><tbody>${rows.map((o) => `<tr><td><b>#${o.order_id}</b></td><td>${date(o.order_date)}</td><td class="num">${o.item_count}</td><td class="num">${money(o.total_amount)}</td><td>${badge(o.status)}</td><td>${badge(o.payment_status)}</td><td>${badge(o.shipment_status)}${o.tracking_number ? `<div class="muted small">${esc(o.tracking_number)}</div>` : ''}</td><td class="right"><a class="btn btn--sm" href="order.html?id=${o.order_id}">View</a></td></tr>`).join('')}</tbody></table></div>`;
    $('#more').innerHTML = page.length === LIMIT ? '<button class="btn" id="lm">Load more</button>' : '';
    const lm = $('#lm'); if (lm) lm.onclick = () => { lm.classList.add('is-loading'); load(false); };
  } catch (e) { list.innerHTML = errorState(e.message); $('[data-retry]').onclick = () => load(); }
}
$('#tabs').onclick = (e) => { const b = e.target.closest('[data-s]'); if (!b) return; status = b.dataset.s; document.querySelectorAll('#tabs button').forEach((x) => x.setAttribute('aria-selected', x === b)); load(); };
load();
