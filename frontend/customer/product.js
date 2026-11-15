import { api } from '../js/api.js';
import { mountStore } from '../js/layout.js';
import { cart } from '../js/state.js';
import { art, money, esc, stockBadge, date } from '../js/format.js';
import { errorState, emptyState } from '../js/dom.js';
import { toast } from '../js/toast.js';
import { icon } from '../js/icons.js';

const main = mountStore('shop'), id = new URLSearchParams(location.search).get('id');
main.innerHTML = `<div class="detail"><div class="skeleton" style="aspect-ratio:1;border-radius:var(--r-lg)"></div><div class="stack"><div class="skeleton" style="height:30px"></div><div class="skeleton" style="height:20px;width:50%"></div><div class="skeleton" style="height:120px"></div></div></div>`;

async function load() {
  if (!id) { main.innerHTML = emptyState({ title: 'No product selected', action: '<a class="btn btn--primary" href="shop.html">Browse products</a>' }); return; }
  try {
    const p = await api.products.get(id), avail = p.is_active && p.in_stock, max = Math.min(p.quantity_in_stock, 1000);
    document.title = `${p.product_name} · Bazaar`;
    main.innerHTML = `<p><a href="shop.html">${icon('back')} Back to shop</a></p>
    <div class="detail">${art(p.product_name, p.category_id)}
    <div><span class="pcard__cat">${esc(p.category_name)}</span><h1>${esc(p.product_name)}</h1>
      <p class="muted">${p.brand ? `Brand: <b>${esc(p.brand)}</b> · ` : ''}Sold by <b>${esc(p.seller_name)}</b></p>
      <p class="price" style="font-size:2rem">${money(p.price)}</p>
      <p>${p.is_active ? stockBadge(p.quantity_in_stock, p.reorder_level, p.in_stock) : '<span class="badge badge--danger">No longer available</span>'}</p>
      ${p.is_active ? '' : '<div class="alert alert--warn" role="alert">This product has been delisted by the seller and cannot be ordered.</div>'}
      <p>${p.description ? esc(p.description) : '<span class="muted">No description provided.</span>'}</p>
      <div class="row" style="margin:var(--s5) 0"><div class="qty"><button type="button" id="dec" aria-label="Decrease">−</button><input id="qty" type="number" min="1" max="${max}" value="1" aria-label="Quantity"><button type="button" id="inc" aria-label="Increase">+</button></div>
        <button class="btn btn--primary btn--lg" id="add" ${avail ? '' : 'disabled'}>${icon('cart')} Add to cart</button><button class="btn btn--lg" id="buy" ${avail ? '' : 'disabled'}>Buy now</button></div>
      <p class="muted small">Last updated ${date(p.last_updated)}</p></div></div>`;
    const q = document.getElementById('qty'), clamp = () => (q.value = Math.max(1, Math.min(max || 1, Number(q.value) || 1)));
    document.getElementById('dec').onclick = () => { q.value = Number(q.value) - 1; clamp(); };
    document.getElementById('inc').onclick = () => { q.value = Number(q.value) + 1; clamp(); };
    q.onchange = clamp;
    const add = () => { clamp(); cart.add({ product_id: p.product_id, product_name: p.product_name, price: p.price, brand: p.brand, category_id: p.category_id, category_name: p.category_name, seller_name: p.seller_name }, Number(q.value)); };
    document.getElementById('add').onclick = () => { add(); toast('Added to your cart', 'success', 2500); };
    document.getElementById('buy').onclick = () => { add(); location.href = 'cart.html'; };
  } catch (e) { main.innerHTML = errorState(e.status === 404 ? 'We could not find that product.' : e.message); main.querySelector('[data-retry]').onclick = load; }
}
load();
