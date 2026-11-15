import { api } from '../js/api.js';
import { mountStore } from '../js/layout.js';
import { customer } from '../js/state.js';
import { esc, price, money, dateTime, date, badge, addressLine, productImage, displayName } from '../js/format.js';
import { errorState, emptyState, $ } from '../js/dom.js';
import { toast, toastError } from '../js/toast.js';
import { formModal, confirmDialog } from '../js/modal.js';
import { PAYMENT_METHODS } from '../js/config.js';
import { icon } from '../js/icons.js';
import { metro, productUrl } from '../js/components.js';

const page = mountStore('orders', { requireCustomer: true }), me = customer(), params = new URLSearchParams(location.search), id = params.get('id');
let order, autoPay = params.get('pay') === '1';

function headline(o) {
  const s = o.shipment?.status, p = o.payment;
  if (o.status === 'Cancelled') return ['Cancelled', `Cancelled ${o.cancelled_at ? dateTime(o.cancelled_at) : ''}${o.cancel_reason ? `. Reason: ${esc(o.cancel_reason)}` : ''}${p?.status === 'Refunded' ? `. ${money(p.amount)} refunded.` : ''}`];
  if (s === 'Delivered') return ['Delivered', `Delivered on ${date(o.shipment.delivery_date)}`];
  if (s === 'In Transit') return ['On the way', `In transit with ${esc(o.shipment.carrier || 'the carrier')}`];
  if (s === 'Shipped') return ['Shipped', `Shipped on ${date(o.shipment.shipment_date)} with ${esc(o.shipment.carrier || 'the carrier')}`];
  if (o.status === 'Confirmed') return ['Paid, preparing to ship', 'The seller ships your order next.'];
  return ['Waiting for payment', p?.failure_reason ? `Last payment attempt failed: ${esc(p.failure_reason)}` : 'Pay to confirm the order. Unpaid orders can be cancelled automatically.'];
}

function render() {
  const o = order, p = o.payment, s = o.shipment, [h, sub] = headline(o);
  const canPay = o.status === 'Pending' && p && p.status !== 'Successful', canCancel = ['Pending', 'Confirmed'].includes(o.status);
  page.innerHTML = `<nav aria-label="Breadcrumb"><ol class="crumbs"><li><a href="../index.html">Home</a></li><li><a href="orders.html">Your orders</a></li><li><span aria-current="page">Order #${o.order_id}</span></li></ol></nav>
  <div class="page-head"><div><h1>Order #${o.order_id}</h1><p class="muted small">Placed ${dateTime(o.order_date)}. ${o.items.length} item${o.items.length === 1 ? '' : 's'}, ${price(o.total_amount)}</p></div>
    <div class="row">${canPay ? `<button class="btn btn--cta btn--lg" id="pay">${icon('card')} Pay ${money(o.total_amount)}</button>` : ''}${canCancel ? '<button class="btn btn--danger" id="cancel">Cancel order</button>' : ''}</div></div>
  <section class="panel track" aria-labelledby="th"><div class="row row--between" style="margin-bottom:var(--s5)"><div><h2 id="th" style="margin:0;color:${o.status === 'Cancelled' ? 'var(--danger)' : s?.status === 'Delivered' ? 'var(--success)' : 'var(--ink)'}">${h}</h2><p class="muted small" style="margin:.2rem 0 0">${sub}</p></div>
    ${s?.tracking_number ? `<div class="right small"><span class="muted">Tracking number</span><br><b class="num">${esc(s.tracking_number)}</b></div>` : ''}</div>
    ${metro(o)}</section>
  <div class="cols" style="margin-top:var(--s4)"><div class="stack">
    <section class="panel"><h2>Items in this order</h2><div class="items">${o.items.map((i) => `<div class="line"><a href="${productUrl(i.product_id)}" tabindex="-1" aria-hidden="true">${productImage(i)}</a>
      <div><a class="line__name" style="font-size:var(--t-sm)" href="${productUrl(i.product_id)}">${esc(displayName(i.product_name))}</a><div class="line__meta">${i.quantity} × ${price(i.unit_price)}</div></div>
      <div class="line__price">${price(i.subtotal)}</div></div>`).join('')}</div>
      <div class="summary__total" style="margin-bottom:0"><span>Order total</span>${price(o.total_amount)}</div></section>
    <section class="panel"><h2>Activity</h2>${o.timeline.length ? `<ul class="events">${o.timeline.map((e) => `<li><b>${esc(e.event_type)}</b>${e.detail ? `<span>${esc(e.detail)}</span>` : ''}<span>${dateTime(e.event_time)}</span></li>`).join('')}</ul>` : '<p class="muted">No activity recorded yet.</p>'}
      <p class="xsmall muted" style="margin:var(--s3) 0 0">Every entry here is written by a database trigger when the order, payment or shipment changes.</p></section></div>
    <div class="stack">
      <section class="panel"><h3>${icon('pin')} Delivery address</h3><p class="small" style="margin:0"><b>${esc(me.name)}</b> <span class="badge badge--plain">${esc(o.address.address_type || 'Address')}</span><br>${addressLine(o.address)}</p></section>
      <section class="panel"><h3>${icon('card')} Payment</h3>${p ? `<dl class="kv"><dt>Method</dt><dd>${esc(p.payment_method)}</dd><dt>Status</dt><dd>${badge(p.status)}</dd><dt>Amount</dt><dd>${money(p.amount)}</dd><dt>Attempts</dt><dd>${p.attempts ?? 0}</dd>${p.transaction_ref ? `<dt>Reference</dt><dd class="num">${esc(p.transaction_ref)}</dd>` : ''}${p.payment_date ? `<dt>Paid on</dt><dd>${dateTime(p.payment_date)}</dd>` : ''}${p.refund_ref ? `<dt>Refund reference</dt><dd class="num">${esc(p.refund_ref)}</dd>` : ''}</dl>` : '<p class="muted small">No payment record.</p>'}</section>
      <section class="panel"><h3>${icon('truck')} Shipment</h3>${s ? `<dl class="kv"><dt>Status</dt><dd>${badge(s.status)}</dd><dt>Carrier</dt><dd>${esc(s.carrier || 'Not assigned yet')}</dd><dt>Shipped</dt><dd>${date(s.shipment_date)}</dd><dt>Delivered</dt><dd>${date(s.delivery_date)}</dd></dl>` : '<p class="muted small" style="margin:0">A shipment is created when the payment succeeds.</p>'}</section>
    </div></div>`;
  $('#pay')?.addEventListener('click', openPay); $('#cancel')?.addEventListener('click', cancel);
}

function openPay() {
  formModal({ title: `Pay ${money(order.total_amount)} for order #${order.order_id}`, submitLabel: `Pay ${money(order.total_amount)}`,
    intro: 'Choose how to pay. This demo uses a simulated payment gateway, so you can also test a declined payment.',
    fields: [{ name: 'payment_method', label: 'Payment method', type: 'select', value: order.payment?.payment_method, options: PAYMENT_METHODS.map((m) => ({ value: m, label: m })), full: true, required: true },
      { name: 'simulate', label: 'Gateway result (demo)', type: 'select', value: 'success', full: true, hint: 'Pick “Declined” to see a failed payment you can retry.', options: [{ value: 'success', label: 'Approved' }, { value: 'decline', label: 'Declined by the bank' }, { value: 'error', label: 'Gateway unavailable (502)' }] }],
    onSubmit: async (v) => {
      const r = await api.orders.pay(order.order_id, { customer_id: me.id, payment_method: v.payment_method, simulate: v.simulate });
      order = r.order; render();
      if (r.paid) toast('Payment received. Your order is confirmed.', 'success'); else toast(r.message || 'The payment was declined. You can try again.', 'error', 7000);
    } });
}
async function cancel() {
  const paid = order.payment?.status === 'Successful';
  if (!(await confirmDialog({ title: `Cancel order #${order.order_id}?`, message: paid ? `The items go back into stock and ${money(order.total_amount)} is refunded to your ${order.payment.payment_method}.` : 'The items go back into stock. This cannot be undone.', confirmLabel: 'Cancel order', danger: true }))) return;
  try { const r = await api.orders.cancel(order.order_id, { customer_id: me.id, reason: 'Cancelled by customer' }); order = r.order; render(); toast(r.refund ? `Order cancelled. ${money(r.refund.amount)} refunded.` : 'Order cancelled.', 'success'); } catch (e) { toastError(e); }
}
async function load() {
  if (!id) { page.innerHTML = `<div class="panel">${emptyState({ title: 'No order selected', action: '<a class="btn btn--primary" href="orders.html">Your orders</a>' })}</div>`; return; }
  page.innerHTML = '<div class="skeleton" style="height:16px;width:280px;margin-bottom:var(--s4)"></div><div class="skeleton" style="height:180px"></div><div class="cols" style="margin-top:var(--s4)"><div class="skeleton" style="height:300px"></div><div class="skeleton" style="height:300px"></div></div>';
  try {
    order = await api.orders.get(id);
    if (order.customer_id !== me.id) { page.innerHTML = `<div class="panel">${emptyState({ icon: 'alert', title: 'This order belongs to another account', text: 'Sign in with the account that placed it to see the details.', action: '<a class="btn btn--primary" href="orders.html">Your orders</a>' })}</div>`; return; }
    document.title = `Order #${order.order_id} · Bazaar`;
    render(); if (autoPay && order.status === 'Pending') { autoPay = false; history.replaceState(null, '', `?id=${order.order_id}`); openPay(); }
  } catch (e) { page.innerHTML = `<div class="panel">${e.status === 404 ? emptyState({ icon: 'search', title: 'Order not found', action: '<a class="btn btn--primary" href="orders.html">Your orders</a>' }) : errorState(e.message)}</div>`; $('[data-retry]')?.addEventListener('click', load); }
}
load();
