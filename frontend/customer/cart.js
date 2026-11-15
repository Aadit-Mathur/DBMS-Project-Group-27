import { api } from '../js/api.js';
import { mountStore, signInUrl } from '../js/layout.js';
import { cart, customer } from '../js/state.js';
import { esc, price, int, productImage, displayName } from '../js/format.js';
import { emptyState } from '../js/dom.js';
import { icon } from '../js/icons.js';
import { toast } from '../js/toast.js';
import { productUrl } from '../js/components.js';

const page = mountStore('cart'), me = customer();
// product_id -> {state:'ok'|'gone'|'delisted'|'unknown', qty, reorder}; refreshed from GET /products/{id}
const live = {};
let checked = false;

function lineState(i) {
  const s = live[i.product_id];
  if (!s) return { ok: true, html: checked ? '' : '<span class="muted xsmall">Checking stock…</span>' };
  if (s.state === 'gone') return { ok: false, html: '<span class="stock stock--low">This product no longer exists. Remove it to check out.</span>' };
  if (s.state === 'delisted') return { ok: false, html: '<span class="stock stock--low">The seller has delisted this product. Remove it to check out.</span>' };
  if (s.state === 'unknown') return { ok: true, html: '<span class="stock stock--out">Stock could not be checked right now</span>' };
  if (s.qty === 0) return { ok: false, html: '<span class="stock stock--low">Out of stock. Remove it to check out.</span>' };
  if (s.qty < i.quantity) return { ok: false, html: `<span class="stock stock--low">Only ${s.qty} in stock. Lower the quantity to check out.</span>` };
  if (s.qty <= (s.reorder ?? 10)) return { ok: true, html: `<span class="stock stock--low">Only ${s.qty} left in stock</span>` };
  return { ok: true, html: '<span class="stock stock--in">In stock</span>' };
}

function render() {
  const items = cart.items();
  if (!items.length) {
    page.innerHTML = `<div class="panel" style="margin-top:var(--s4)">${emptyState({ icon: 'cart', title: 'Your cart is empty', text: me ? 'Add products from the shop and they will wait for you here.' : 'Items you add stay here. Sign in at checkout to place the order.', action: '<a class="btn btn--cta btn--lg" href="shop.html">Start shopping</a>' })}</div>`;
    return;
  }
  const states = items.map(lineState), blocked = states.some((s) => !s.ok), count = cart.count();
  page.innerHTML = `<div class="cols" style="margin-top:var(--s4)">
    <section class="panel" aria-labelledby="ctitle"><div class="panel__head" style="border-bottom:1px solid var(--line);padding-bottom:var(--s3);margin-bottom:0"><h1 id="ctitle" style="font-size:var(--t-xl)">Shopping cart</h1><span class="muted small">Price</span></div>
      ${blocked ? `<div class="alert alert--warn" role="alert" style="margin-top:var(--s4)">${icon('alert')}<span>Some items cannot be ordered as they are. Fix the items marked below to continue to checkout.</span></div>` : ''}
      ${items.map((i, k) => `<div class="line" data-id="${i.product_id}"><a href="${productUrl(i.product_id)}" tabindex="-1" aria-hidden="true">${productImage(i)}</a>
        <div><a class="line__name" href="${productUrl(i.product_id)}">${esc(displayName(i.product_name))}</a>
          <div class="line__meta">${i.brand ? esc(i.brand) + ', ' : ''}sold by ${esc(i.seller_name || 'seller')}</div>
          <div style="margin-top:.35rem">${states[k].html}</div>
          <div class="line__actions"><div class="qty"><button type="button" data-dec aria-label="Decrease quantity of ${esc(displayName(i.product_name))}" ${i.quantity <= 1 ? 'disabled' : ''}>${icon('minus', 14)}</button><input type="number" min="1" max="1000" value="${i.quantity}" aria-label="Quantity of ${esc(displayName(i.product_name))}" inputmode="numeric"><button type="button" data-inc aria-label="Increase quantity of ${esc(displayName(i.product_name))}">${icon('plus', 14)}</button></div>
            <button class="btn btn--link small" data-rm>Remove</button></div></div>
        <div class="line__price">${price(i.price * i.quantity)}${i.quantity > 1 ? `<div class="xsmall muted">${price(i.price)} each</div>` : ''}</div></div>`).join('')}
      <p class="right" style="margin:var(--s3) 0 0;font-size:var(--t-md)">Subtotal (${int(count)} item${count === 1 ? '' : 's'}): ${price(cart.total())}</p>
    </section>
    <aside class="panel summary sticky-side" aria-label="Price details"><h2>Price details</h2>
      <dl class="kv"><dt>Price (${int(count)} item${count === 1 ? '' : 's'})</dt><dd>${price(cart.total())}</dd><dt>Delivery charges</dt><dd class="free">Free</dd></dl>
      <div class="summary__total"><span>Total amount</span>${price(cart.total())}</div>
      ${me ? `<a class="btn btn--cta btn--block btn--lg" href="checkout.html" ${blocked ? 'aria-disabled="true"' : ''}>Proceed to checkout</a>`
        : `<a class="btn btn--cta btn--block btn--lg" href="${signInUrl('customer', 'customer/checkout.html')}" ${blocked ? 'aria-disabled="true"' : ''}>Sign in to check out</a>`}
      <p class="xsmall muted" style="margin:var(--s3) 0 0">Stock is reserved only when the order is placed. The database refuses the order if a product sells out first.</p>
      <button class="btn btn--ghost btn--block btn--sm" id="clear" style="margin-top:var(--s3)">Empty cart</button></aside></div>`;
  document.getElementById('clear').onclick = () => { const n = cart.items().length; cart.clear(); toast(`Removed ${n} item${n === 1 ? '' : 's'} from your cart.`, 'info'); };
}

page.addEventListener('click', (e) => {
  const row = e.target.closest('[data-id]'); if (!row) return; const id = Number(row.dataset.id), cur = cart.items().find((i) => i.product_id === id); if (!cur) return;
  if (e.target.closest('[data-inc]')) cart.setQty(id, cur.quantity + 1);
  if (e.target.closest('[data-dec]')) cart.setQty(id, cur.quantity - 1);
  if (e.target.closest('[data-rm]')) { cart.remove(id); toast(`Removed ${displayName(cur.product_name)}.`, 'info', 3000); }
});
page.addEventListener('change', (e) => { const row = e.target.closest('[data-id]'); if (row && e.target.type === 'number') cart.setQty(Number(row.dataset.id), Math.floor(Number(e.target.value)) || 1); });
window.addEventListener('cartchange', render);
render();

// Refresh price, stock and availability from GET /products/{id}. A 404 means the product was deleted.
await Promise.all(cart.items().map(async (i) => {
  try {
    const p = await api.products.get(i.product_id);
    live[i.product_id] = { state: p.is_active ? 'ok' : 'delisted', qty: p.quantity_in_stock, reorder: p.reorder_level };
    if (Number(p.price) !== Number(i.price)) { cart.update(i.product_id, { price: p.price }); toast(`The price of ${displayName(i.product_name)} changed. Your cart shows the current price.`, 'info', 6000); }
  } catch (e) { live[i.product_id] = { state: e.status === 404 ? 'gone' : 'unknown' }; }
}));
checked = true;
render();
