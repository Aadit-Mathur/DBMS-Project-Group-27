import { api } from '../js/api.js';
import { mountStore } from '../js/layout.js';
import { customer } from '../js/state.js';
import { esc, price, date, productImage, displayName } from '../js/format.js';
import { emptyState, errorState, $ } from '../js/dom.js';
import { metroMini, productUrl } from '../js/components.js';

const page = mountStore('orders', { requireCustomer: true }), me = customer(), LIMIT = 10;
const STATUSES = [['', 'All orders'], ['Pending', 'Awaiting payment'], ['Confirmed', 'Paid'], ['Shipped', 'Shipped'], ['Delivered', 'Delivered'], ['Cancelled', 'Cancelled']];
let status = '', rows = [];
const details = {};   // order_id -> full order (items, address); fetched per page for thumbnails

page.innerHTML = `<nav aria-label="Breadcrumb"><ol class="crumbs"><li><a href="../index.html">Home</a></li><li><span aria-current="page">Your orders</span></li></ol></nav>
<div class="page-head"><div><h1>Your orders</h1><p class="muted small">Signed in as ${esc(me.name)}</p></div></div>
<div class="tabs" role="tablist" id="tabs" aria-label="Filter orders">${STATUSES.map(([s, l]) => `<button role="tab" data-s="${s}" aria-selected="${s === status}">${l}</button>`).join('')}</div>
<div id="list"></div><div id="more" class="more"></div>`;
const list = $('#list');

const skeleton = () => Array.from({ length: 3 }, () => '<div class="ocard" aria-hidden="true"><div class="ocard__head"><div class="skeleton" style="height:28px;width:60%"></div></div><div class="ocard__body"><div class="row"><div class="skeleton" style="width:64px;height:64px"></div><div class="skeleton" style="width:64px;height:64px"></div><div class="skeleton" style="height:14px;width:200px"></div></div><div class="skeleton" style="height:36px;width:170px"></div></div></div>').join('');

function card(o) {
  const d = details[o.order_id], items = d?.items || [];
  const canPay = o.status === 'Pending' && o.payment_status !== 'Successful';
  const thumbs = items.slice(0, 3).map((i) => `<a href="${productUrl(i.product_id)}" aria-label="${esc(displayName(i.product_name))}">${productImage(i, 'pimg--sm')}</a>`).join('') + (items.length > 3 ? `<span class="ocard__more">+${items.length - 3}</span>` : '');
  const first = items[0];
  return `<article class="ocard"><div class="ocard__head">
      <span>Order placed<b>${date(o.order_date)}</b></span><span>Total<b>${price(o.total_amount)}</b></span>
      ${d?.address ? `<span>Ship to<b>${esc(d.address.city || '')}</b></span>` : ''}
      <span class="grow">Order <b>#${o.order_id}</b></span></div>
    <div class="ocard__body"><div class="stack--sm stack">${metroMini(o.status, o.shipment_status, o.payment_status)}
      <div class="ocard__items"><div class="ocard__thumbs">${d ? thumbs : '<div class="skeleton" style="width:64px;height:64px"></div>'}</div>
        <div class="ocard__names">${first ? `<a href="${productUrl(first.product_id)}" class="clamp-2">${esc(displayName(first.product_name))}</a>${items.length > 1 ? `<span class="muted xsmall">and ${items.length - 1} more item${items.length > 2 ? 's' : ''}</span>` : ''}` : `<span class="muted small">${o.item_count} item${o.item_count === 1 ? '' : 's'}</span>`}
        ${o.tracking_number ? `<div class="xsmall muted">Tracking ${esc(o.tracking_number)}</div>` : ''}</div></div></div>
      <div class="ocard__actions">${canPay ? `<a class="btn btn--cta" href="order.html?id=${o.order_id}&pay=1">Pay ${price(o.total_amount)}</a>` : ''}
        <a class="btn ${canPay ? '' : 'btn--primary'}" href="order.html?id=${o.order_id}">${['Shipped', 'Confirmed'].includes(o.status) ? 'Track package' : 'View order details'}</a></div></div></article>`;
}

async function load(reset = true) {
  if (reset) { rows = []; list.innerHTML = skeleton(); $('#more').innerHTML = ''; }
  try {
    const pageRows = await api.customers.orders(me.id, { status, limit: LIMIT, offset: rows.length }); rows.push(...pageRows);
    if (!rows.length) {
      const label = STATUSES.find(([s]) => s === status)[1].toLowerCase();
      list.innerHTML = `<div class="panel">${emptyState({ icon: 'package', title: status ? `No orders in “${label}”` : 'You have not placed any orders yet', text: status ? 'Try another tab to see the rest of your orders.' : 'When you place an order, you can follow it here from payment to delivery.', action: '<a class="btn btn--cta" href="shop.html">Start shopping</a>' })}</div>`;
      return;
    }
    const draw = () => { list.innerHTML = rows.map(card).join(''); };
    draw();
    $('#more').innerHTML = pageRows.length === LIMIT ? '<button class="btn btn--lg" id="lm">Show older orders</button>' : '';
    const lm = $('#lm'); if (lm) lm.onclick = () => { lm.classList.add('is-loading'); load(false); };
    await Promise.all(pageRows.filter((o) => !details[o.order_id]).map((o) => api.orders.get(o.order_id).then((d) => (details[o.order_id] = d)).catch(() => (details[o.order_id] = { items: [] }))));
    draw();
  } catch (e) { list.innerHTML = `<div class="panel">${errorState(e.message)}</div>`; $('[data-retry]').onclick = () => load(); }
}
$('#tabs').onclick = (e) => { const b = e.target.closest('[data-s]'); if (!b) return; status = b.dataset.s; document.querySelectorAll('#tabs button').forEach((x) => x.setAttribute('aria-selected', x === b)); load(); };
load();
