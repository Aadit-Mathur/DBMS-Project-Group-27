import { api } from '../js/api.js';
import { mountStore } from '../js/layout.js';
import { cart } from '../js/state.js';
import { art, money, esc, stockBadge } from '../js/format.js';
import { emptyState } from '../js/dom.js';
import { icon } from '../js/icons.js';

const main = mountStore('cart'), stock = {};  // product_id -> {stock, active}
const render = () => {
  const items = cart.items();
  if (!items.length) { main.innerHTML = `<h1>Your cart</h1>${emptyState({ icon: 'cart', title: 'Your cart is empty', text: 'Find something you like in the shop.', action: '<a class="btn btn--primary" href="shop.html">Start shopping</a>' })}`; return; }
  const bad = items.filter((i) => stock[i.product_id] && (!stock[i.product_id].active || stock[i.product_id].qty < i.quantity));
  main.innerHTML = `<h1>Your cart</h1>${bad.length ? `<div class="alert alert--warn" role="alert" style="margin-bottom:var(--s4)">${icon('alert')}<span>Some items are unavailable or exceed the stock. Adjust or remove them to check out.</span></div>` : ''}
  <div class="cols"><div class="card">${items.map((i) => { const s = stock[i.product_id], off = s && !s.active, over = s && s.active && s.qty < i.quantity;
    return `<div class="line-item" data-id="${i.product_id}">${art(i.product_name, i.category_id, 'product-art--sm')}
      <div class="grow"><a href="product.html?id=${i.product_id}"><b>${esc(i.product_name)}</b></a><div class="muted small">Sold by ${esc(i.seller_name || '')}</div>
      ${off ? '<span class="badge badge--danger">No longer available</span>' : over ? `<span class="badge badge--warn">Only ${s.qty} in stock</span>` : s ? stockBadge(s.qty, s.reorder, s.qty > 0) : ''}</div>
      <div class="qty"><button data-dec aria-label="Decrease">−</button><input type="number" min="1" max="1000" value="${i.quantity}" aria-label="Quantity of ${esc(i.product_name)}"><button data-inc aria-label="Increase">+</button></div>
      <b class="nowrap" style="min-width:90px;text-align:right">${money(i.price * i.quantity)}</b>
      <button class="btn btn--ghost btn--icon" data-rm aria-label="Remove ${esc(i.product_name)}">${icon('trash')}</button></div>`; }).join('')}</div>
  <aside class="card"><h3>Order summary</h3><dl class="kv"><dt>Items</dt><dd>${cart.count()}</dd><dt>Subtotal</dt><dd>${money(cart.total())}</dd><dt>Delivery</dt><dd>Free</dd></dl>
  <hr style="border:0;border-top:1px solid var(--border);margin:var(--s4) 0"><div class="row row--between"><b>Total</b><span class="price">${money(cart.total())}</span></div>
  <a class="btn btn--primary btn--block btn--lg " style="margin-top:var(--s4);${bad.length ? 'pointer-events:none;opacity:.5' : ''}" href="checkout.html" ${bad.length ? 'aria-disabled="true"' : ''}>Checkout</a>
  <button class="btn btn--ghost btn--block" id="clear" style="margin-top:var(--s2)">Clear cart</button></aside></div>`;
  const clear = document.getElementById('clear'); if (clear) clear.onclick = () => cart.clear();
};
main.addEventListener('click', (e) => {
  const row = e.target.closest('[data-id]'); if (!row) return; const id = Number(row.dataset.id), cur = cart.items().find((i) => i.product_id === id);
  if (e.target.closest('[data-inc]')) cart.setQty(id, cur.quantity + 1); if (e.target.closest('[data-dec]')) cart.setQty(id, cur.quantity - 1); if (e.target.closest('[data-rm]')) cart.remove(id);
});
main.addEventListener('change', (e) => { const row = e.target.closest('[data-id]'); if (row && e.target.type === 'number') cart.setQty(Number(row.dataset.id), Number(e.target.value) || 1); });
window.addEventListener('cartchange', render);
render();
// Refresh price/stock/availability from the real product endpoint.
await Promise.all(cart.items().map(async (i) => {
  try { const p = await api.products.get(i.product_id); stock[i.product_id] = { qty: p.quantity_in_stock, active: p.is_active, reorder: p.reorder_level }; if (Number(p.price) !== Number(i.price)) cart.update(i.product_id, { price: p.price }); } catch { /* keep cached item */ }
}));
render();
