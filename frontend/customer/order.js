import { api } from '../js/api.js';
import { mountStore } from '../js/layout.js';
import { session } from '../js/state.js';
import { money, dateTime, date, esc, badge, addressLine, art } from '../js/format.js';
import { errorState, emptyState, $ } from '../js/dom.js';
import { toast, toastError } from '../js/toast.js';
import { formModal, confirmDialog } from '../js/modal.js';
import { PAYMENT_METHODS } from '../js/config.js';
import { icon } from '../js/icons.js';

const main = mountStore('orders'), me = session.get(), params = new URLSearchParams(location.search), id = params.get('id');
let order, autoPay = params.get('pay') === '1';

// Visual shipment timeline derived from the order, payment and shipment status.
function stepper(o) {
  const ship = o.shipment?.status, cancelled = o.status === 'Cancelled';
  const paid = ['Successful', 'Refunded'].includes(o.payment?.status) || ['Confirmed', 'Shipped', 'Delivered'].includes(o.status);
  const rank = { Shipped: 3, 'In Transit': 4, Delivered: 5 }[ship] ?? (paid ? 2 : 1);
  const steps = [['Order placed', 'bag'], ['Payment confirmed', 'card'], ['Shipped', 'package'], ['In transit', 'truck'], ['Delivered', 'check']];
  return `<ol class="stepper ${cancelled ? 'cancelled' : ''}" aria-label="Order progress">${steps.map(([l, ic], i) => { const n = i + 1, done = cancelled ? n === 1 : n <= rank; return `<li class="${done ? 'done' : ''} ${!cancelled && n === rank ? 'current' : ''}" ${!cancelled && n === rank ? 'aria-current="step"' : ''}><span class="dot">${done ? icon('check', 14) : ''}</span>${l}</li>`; }).join('')}</ol>${cancelled ? `<div class="alert alert--danger" style="margin-top:var(--s4)" role="status">${icon('x')}<span>Cancelled${o.cancelled_at ? ' on ' + dateTime(o.cancelled_at) : ''}${o.cancel_reason ? ' — ' + esc(o.cancel_reason) : ''}</span></div>` : ''}`;
}
function render() {
  const o = order, p = o.payment, s = o.shipment, canPay = o.status === 'Pending' && p && p.status !== 'Successful', canCancel = ['Pending', 'Confirmed'].includes(o.status);
  main.innerHTML = `<p><a href="orders.html">${icon('back')} All orders</a></p>
  <div class="page-head"><div><h1>Order #${o.order_id}</h1><p class="muted">Placed ${dateTime(o.order_date)}</p></div><div class="row">${badge(o.status)}${canPay ? `<button class="btn btn--primary" id="pay">${icon('card')} Pay ${money(o.total_amount)}</button>` : ''}${canCancel ? `<button class="btn btn--danger" id="cancel">Cancel order</button>` : ''}</div></div>
  ${canPay ? `<div class="alert alert--warn" style="margin-bottom:var(--s4)">${icon('clock')}<span>Payment is pending${p.failure_reason ? ' — last attempt failed: ' + esc(p.failure_reason) : ''}. Unpaid orders may be cancelled automatically.</span></div>` : ''}
  <section class="card" style="margin-bottom:var(--s5)"><h3>Tracking</h3>${stepper(o)}${s?.tracking_number ? `<p style="margin:var(--s5) 0 0" class="muted">Carrier <b>${esc(s.carrier || '—')}</b> · Tracking no. <b>${esc(s.tracking_number)}</b></p>` : ''}</section>
  <div class="cols"><div class="stack"><section class="card card--flush"><div class="table-wrap" style="border:0"><table class="table"><thead><tr><th>Item</th><th class="num">Qty</th><th class="num">Price</th><th class="num">Subtotal</th></tr></thead><tbody>
    ${o.items.map((i) => `<tr><td><a href="product.html?id=${i.product_id}">${esc(i.product_name)}</a></td><td class="num">${i.quantity}</td><td class="num">${money(i.unit_price)}</td><td class="num">${money(i.subtotal)}</td></tr>`).join('')}
    <tr><td colspan="3" class="right"><b>Total</b></td><td class="num"><b>${money(o.total_amount)}</b></td></tr></tbody></table></div></section>
    <section class="card"><h3>Activity</h3>${o.timeline.length ? `<ul class="events">${o.timeline.map((e) => `<li><b>${esc(e.event_type)}</b>${e.detail ? `<span>${esc(e.detail)}<br></span>` : ''}<span>${dateTime(e.event_time)}</span></li>`).join('')}</ul>` : '<p class="muted">No activity recorded.</p>'}</section></div>
  <div class="stack"><section class="card"><h3>${icon('pin')} Delivery address</h3><p class="muted" style="margin:0"><b>${esc(o.address.address_type || '')}</b><br>${addressLine(o.address)}</p></section>
    <section class="card"><h3>${icon('card')} Payment</h3>${p ? `<dl class="kv"><dt>Method</dt><dd>${esc(p.payment_method)}</dd><dt>Status</dt><dd>${badge(p.status)}</dd><dt>Amount</dt><dd>${money(p.amount)}</dd><dt>Attempts</dt><dd>${p.attempts ?? 0}</dd>${p.transaction_ref ? `<dt>Reference</dt><dd>${esc(p.transaction_ref)}</dd>` : ''}${p.payment_date ? `<dt>Paid on</dt><dd>${dateTime(p.payment_date)}</dd>` : ''}${p.refund_ref ? `<dt>Refund ref</dt><dd>${esc(p.refund_ref)}</dd>` : ''}</dl>` : '<p class="muted">No payment record.</p>'}</section>
    <section class="card"><h3>${icon('truck')} Shipment</h3>${s ? `<dl class="kv"><dt>Status</dt><dd>${badge(s.status)}</dd><dt>Carrier</dt><dd>${esc(s.carrier || '—')}</dd><dt>Shipped</dt><dd>${date(s.shipment_date)}</dd><dt>Delivered</dt><dd>${date(s.delivery_date)}</dd></dl>` : '<p class="muted">Not shipped yet.</p>'}</section></div></div>`;
  $('#pay')?.addEventListener('click', openPay); $('#cancel')?.addEventListener('click', cancel);
}
function openPay() {
  formModal({ title: `Pay ${money(order.total_amount)}`, submitLabel: `Pay ${money(order.total_amount)}`,
    intro: 'Choose how you want to pay. Payments go through the backend’s simulated gateway.',
    fields: [{ name: 'payment_method', label: 'Payment method', type: 'select', value: order.payment?.payment_method, options: PAYMENT_METHODS.map((m) => ({ value: m, label: m })), full: true, required: true },
      { name: 'simulate', label: 'Simulated gateway outcome (demo)', type: 'select', value: 'success', full: true, hint: 'Only the simulated gateway reads this. Pick “Decline” to see a retryable failure.', options: [{ value: 'success', label: 'Approve payment' }, { value: 'decline', label: 'Decline (card declined)' }, { value: 'error', label: 'Gateway outage (502)' }] }],
    onSubmit: async (v) => {
      const r = await api.orders.pay(order.order_id, { customer_id: me.id, payment_method: v.payment_method, simulate: v.simulate });
      order = r.order; render();
      if (r.paid) toast('Payment successful — your order is confirmed.', 'success'); else toast(r.message || 'Payment was declined. You can try again.', 'error', 7000);
    } });
}
async function cancel() {
  if (!(await confirmDialog({ title: 'Cancel this order?', message: order.payment?.status === 'Successful' ? 'Stock will be returned and your payment refunded.' : 'Stock will be returned. This cannot be undone.', confirmLabel: 'Yes, cancel order', danger: true }))) return;
  try { const r = await api.orders.cancel(order.order_id, { customer_id: me.id, reason: 'Cancelled by customer' }); order = r.order; render(); toast(r.refund ? `Order cancelled. ${money(r.refund.amount)} refunded.` : 'Order cancelled.', 'success'); } catch (e) { toastError(e); }
}
async function load() {
  if (!id) { main.innerHTML = emptyState({ title: 'No order selected', action: '<a class="btn btn--primary" href="orders.html">My orders</a>' }); return; }
  main.innerHTML = '<div class="skeleton" style="height:300px"></div>';
  try {
    order = await api.orders.get(id);
    if (order.customer_id !== me.id) { main.innerHTML = emptyState({ icon: 'alert', title: 'This order belongs to another customer', action: '<a class="btn btn--primary" href="orders.html">My orders</a>' }); return; }
    render(); if (autoPay && order.status === 'Pending') { autoPay = false; openPay(); }
  } catch (e) { main.innerHTML = errorState(e.status === 404 ? 'Order not found.' : e.message); $('[data-retry]').onclick = load; }
}
load();
