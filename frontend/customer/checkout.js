import { api } from '../js/api.js';
import { mountStore } from '../js/layout.js';
import { cart, session } from '../js/state.js';
import { money, esc, addressLine } from '../js/format.js';
import { emptyState, errorState, busy, $ } from '../js/dom.js';
import { toast, toastError } from '../js/toast.js';
import { PAYMENT_METHODS } from '../js/config.js';
import { icon } from '../js/icons.js';

const main = mountStore('cart'), me = session.get();
async function load() {
  const items = cart.items();
  if (!items.length) { main.innerHTML = `<h1>Checkout</h1>${emptyState({ icon: 'cart', title: 'Your cart is empty', action: '<a class="btn btn--primary" href="shop.html">Browse products</a>' })}`; return; }
  main.innerHTML = '<h1>Checkout</h1><div class="skeleton" style="height:240px"></div>';
  let addrs;
  try { addrs = await api.customers.addresses(me.id); } catch (e) { main.innerHTML = errorState(e.message); $('[data-retry]').onclick = load; return; }
  main.innerHTML = `<h1>Checkout</h1><form id="co" novalidate class="cols"><div class="stack">
    <section class="card"><h3>${icon('pin')} Delivery address</h3>
      ${addrs.length ? `<div class="stack" role="radiogroup" aria-label="Delivery address">${addrs.map((a, i) => `<label class="opt"><input type="radio" name="address_id" value="${a.address_id}" ${i === 0 ? 'checked' : ''}><span><b>${esc(a.address_type || 'Address')}</b><br><span class="muted">${addressLine(a)}</span></span></label>`).join('')}</div>`
        : `<div class="alert alert--warn" role="alert">${icon('alert')}<span>You have no saved delivery address. The backend has no endpoint for adding addresses yet, so an address must exist in the database before ordering.</span></div>`}
    </section>
    <section class="card"><h3>${icon('card')} Payment method</h3><div class="form-grid" role="radiogroup" aria-label="Payment method">${PAYMENT_METHODS.map((m, i) => `<label class="opt" style="margin-bottom:var(--s2)"><input type="radio" name="payment_method" value="${m}" ${i === 0 ? 'checked' : ''}><b>${m}</b></label>`).join('')}</div>
      <p class="muted small">You will confirm the payment on the next screen.</p></section></div>
    <aside class="card"><h3>Order summary</h3>${items.map((i) => `<div class="row row--between small" style="margin-bottom:var(--s2)"><span>${esc(i.product_name)} × ${i.quantity}</span><b>${money(i.price * i.quantity)}</b></div>`).join('')}
      <hr style="border:0;border-top:1px solid var(--border);margin:var(--s4) 0"><div class="row row--between"><b>Total</b><span class="price">${money(cart.total())}</span></div>
      <button class="btn btn--primary btn--block btn--lg" id="place" style="margin-top:var(--s4)" ${addrs.length ? '' : 'disabled'}>Place order</button></aside></form>`;
  $('#co').onsubmit = async (e) => {
    e.preventDefault(); const v = Object.fromEntries(new FormData(e.target));
    try {
      const order = await busy($('#place'), () => api.orders.place({ customer_id: me.id, address_id: Number(v.address_id), payment_method: v.payment_method, items: items.map((i) => ({ product_id: i.product_id, quantity: i.quantity })) }));
      cart.clear(); toast(`Order #${order.order_id} placed. Complete the payment to confirm it.`, 'success');
      location.href = `order.html?id=${order.order_id}&pay=1`;
    } catch (err) { toastError(err); }   // stock / trigger errors surface here
  };
}
load();
