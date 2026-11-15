import { api } from '../js/api.js';
import { mountStore, signOut } from '../js/layout.js';
import { cart, customer } from '../js/state.js';
import { esc, price, int, addressLine, productImage, displayName } from '../js/format.js';
import { emptyState, errorState, busy, $ } from '../js/dom.js';
import { toast, toastError } from '../js/toast.js';
import { PAYMENT_METHODS } from '../js/config.js';
import { icon } from '../js/icons.js';

const page = mountStore('checkout', { requireCustomer: true });
const me = customer();
const PAY_IC = { UPI: 'phone', 'Credit Card': 'card', 'Debit Card': 'card', 'Net Banking': 'bank', Wallet: 'wallet' };
const PAY_HINT = { UPI: 'Pay with any UPI app', 'Credit Card': 'Visa, Mastercard, RuPay', 'Debit Card': 'All Indian bank debit cards', 'Net Banking': 'All major banks', Wallet: 'Prepaid wallets' };

const step = (n, title, body, done = false) => `<section class="step"><div class="step__head"><span class="step__no">${n}</span><h2>${title}</h2>${done ? `<span class="step__done">${icon('check')}</span>` : ''}</div><div class="step__body">${body}</div></section>`;

async function load() {
  const items = cart.items();
  if (!items.length) { page.innerHTML = `<div class="panel" style="margin-top:var(--s4)">${emptyState({ icon: 'cart', title: 'Your cart is empty', text: 'Add something to your cart before checking out.', action: '<a class="btn btn--cta" href="shop.html">Browse products</a>' })}</div>`; return; }
  page.innerHTML = `<div class="cols" style="margin-top:var(--s4)"><div class="steps">${[1, 2, 3].map(() => '<div class="skeleton" style="height:120px"></div>').join('')}</div><div class="skeleton" style="height:260px"></div></div>`;
  let addrs;
  try { addrs = await api.customers.addresses(me.id); } catch (e) { page.innerHTML = `<div class="panel">${errorState(e.message)}</div>`; $('[data-retry]').onclick = load; return; }
  const count = cart.count();
  page.innerHTML = `<h1 class="sr-only">Checkout</h1><form id="co" novalidate class="cols" style="margin-top:var(--s4)"><div class="steps">
    ${step(1, 'Signed in', `<div class="row row--between"><span><b>${esc(me.name)}</b> <span class="muted small">${esc(me.email || '')}</span></span><button type="button" class="btn btn--link small" id="change">Change account</button></div>`, true)}
    ${step(2, 'Delivery address', addrs.length ? `<div class="opt-list" role="radiogroup" aria-label="Delivery address">${addrs.map((a, i) => `<label class="opt"><input type="radio" name="address_id" value="${a.address_id}" ${i === 0 ? 'checked' : ''}><span><b>${esc(me.name)}</b> <span class="badge badge--plain">${esc(a.address_type || 'Address')}</span><br><span class="small" style="color:var(--ink-2)">${addressLine(a)}</span></span></label>`).join('')}</div>`
      : `<div class="alert alert--warn" role="alert">${icon('alert')}<span>Your account has no saved delivery address, and this demo cannot add one (there is no address endpoint). Sign in as a customer who has an address, such as customer0001@example.in.</span></div>`)}
    ${step(3, `Order summary <span class="muted" style="font-weight:500">(${int(count)} item${count === 1 ? '' : 's'})</span>`, `<div class="items">${items.map((i) => `<div class="line">${productImage(i)}<div><span class="line__name" style="font-size:var(--t-sm)">${esc(displayName(i.product_name))}</span><div class="line__meta">Sold by ${esc(i.seller_name || 'seller')}. Quantity ${i.quantity}</div></div><div class="line__price">${price(i.price * i.quantity)}</div></div>`).join('')}</div><a class="small" href="cart.html">Change items in the cart</a>`)}
    ${step(4, 'Payment method', `<div class="opt-list opt-list--2" role="radiogroup" aria-label="Payment method">${PAYMENT_METHODS.map((m, i) => `<label class="opt"><input type="radio" name="payment_method" value="${m}" ${i === 0 ? 'checked' : ''}><span class="row" style="gap:var(--s3)">${icon(PAY_IC[m] || 'card')}<span><b>${m}</b><br><span class="xsmall muted">${PAY_HINT[m] || ''}</span></span></span></label>`).join('')}</div>
      <p class="xsmall muted" style="margin:var(--s3) 0 0">You confirm the payment on the next screen. Payments go through the project's simulated gateway.</p>`)}
  </div>
  <aside class="panel summary sticky-side" aria-label="Price details"><h2>Price details</h2>
    <dl class="kv"><dt>Price (${int(count)} item${count === 1 ? '' : 's'})</dt><dd>${price(cart.total())}</dd><dt>Delivery charges</dt><dd class="free">Free</dd></dl>
    <div class="summary__total"><span>Amount payable</span>${price(cart.total())}</div>
    <button class="btn btn--cta btn--block btn--lg" id="place" ${addrs.length ? '' : 'disabled'}>Place order</button>
    <p class="xsmall muted" style="margin:var(--s3) 0 0">Placing the order runs one database transaction: it checks stock, reserves it and records the order. If any item has run out, nothing is ordered.</p></aside></form>`;
  $('#change').onclick = () => signOut('login.html?role=customer&next=' + encodeURIComponent('customer/checkout.html'));
  $('#co').onsubmit = async (e) => {
    e.preventDefault(); const v = Object.fromEntries(new FormData(e.target));
    try {
      const order = await busy($('#place'), () => api.orders.place({ customer_id: me.id, address_id: Number(v.address_id), payment_method: v.payment_method, items: items.map((i) => ({ product_id: i.product_id, quantity: i.quantity })) }));
      cart.clear(); toast(`Order #${order.order_id} placed. Pay now to confirm it.`, 'success');
      location.href = `order.html?id=${order.order_id}&pay=1`;
    } catch (err) { toastError(err); }   // stock CHECK / delisted product / trigger errors surface here
  };
}
load();
