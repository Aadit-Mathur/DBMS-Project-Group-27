import { api } from '../js/api.js';
import { mountStore } from '../js/layout.js';
import { customer, cart } from '../js/state.js';
import { esc, price, stockText, date, productImage, displayName, productType, imgSrc, addressLine } from '../js/format.js';
import { errorState, emptyState } from '../js/dom.js';
import { icon } from '../js/icons.js';
import { addToCart, cartItem, mini, rail, wireRails, shopUrl } from '../js/components.js';

const page = mountStore('product'), id = new URLSearchParams(location.search).get('id'), me = customer();
page.innerHTML = `<div class="skeleton" style="height:16px;width:320px;margin-bottom:var(--s4)"></div><div class="pdp" aria-busy="true"><div class="skeleton" style="aspect-ratio:1"></div><div class="stack"><div class="skeleton" style="height:28px"></div><div class="skeleton" style="height:16px;width:40%"></div><div class="skeleton" style="height:40px;width:30%"></div><div class="skeleton" style="height:120px"></div></div><div class="skeleton" style="height:280px"></div></div>`;

async function credit(p) {
  const src = imgSrc(p); if (!src) return '';
  try {
    const { CREDITS } = await import('../js/credits.js');
    const c = CREDITS[src.split('/').pop()]; if (!c) return '';
    return `Representative photo, not the seller's own: <a href="${esc(c.source)}" target="_blank" rel="noopener">${esc(c.title)}</a> by ${esc(c.creator)}, ${c.license_url ? `<a href="${esc(c.license_url)}" target="_blank" rel="noopener">${esc(c.license)}</a>` : esc(c.license)}.`;
  } catch { return ''; }
}

async function load() {
  if (!id) { page.innerHTML = `<div class="panel">${emptyState({ title: 'No product selected', text: 'Pick a product from the shop to see its details.', action: '<a class="btn btn--primary" href="shop.html">Browse products</a>' })}</div>`; return; }
  try {
    const p = await api.products.get(id), avail = p.is_active && p.in_stock, max = Math.min(p.quantity_in_stock, 1000), name = displayName(p.product_name);
    document.title = `${name} · Bazaar`;
    const inCart = cart.items().find((i) => i.product_id === p.product_id)?.quantity || 0;
    page.innerHTML = `<nav aria-label="Breadcrumb"><ol class="crumbs"><li><a href="../index.html">Home</a></li><li><a href="${shopUrl({ category_id: p.category_id })}">${esc(p.category_name)}</a></li><li><a href="${shopUrl({ category_id: p.category_id, q: productType(p.product_name, p.brand) })}">${esc(productType(p.product_name, p.brand))}</a></li></ol></nav>
    <div class="pdp">
      <div class="pdp__media">${productImage(p, '', { eager: true })}<p class="pdp__credit" id="credit"></p></div>
      <div class="pdp__info">
        ${p.brand ? `<a class="pdp__store" href="${shopUrl({ q: p.brand })}">Visit the ${esc(p.brand)} store</a>` : ''}
        <h1>${esc(name)}</h1>
        <p class="muted small" style="margin:0">Sold by <b style="color:var(--ink)">${esc(p.seller_name)}</b></p>
        <div class="pdp__price">${price(p.price, 'price--lg')}<small>Inclusive of all taxes</small></div>
        ${p.is_active ? '' : `<div class="alert alert--warn" role="alert" style="margin-bottom:var(--s4)">${icon('alert')}<span>The seller has delisted this product, so it can no longer be ordered. It stays visible here because past orders link to it.</span></div>`}
        <div class="pdp__facts">
          <div class="fact">${icon('truck')}<span>Free delivery</span></div>
          <div class="fact">${icon('rotate')}<span>Cancel before it ships</span></div>
          <div class="fact">${icon('shield-check')}<span>Pay online, refund on cancel</span></div></div>
        <h2 style="font-size:var(--t-md);margin-top:var(--s5)">About this item</h2>
        <p class="pdp__desc">${p.description ? esc(p.description.charAt(0).toUpperCase() + p.description.slice(1)) : '<span class="muted">The seller has not added a description.</span>'}</p>
        <h2 style="font-size:var(--t-md);margin-top:var(--s5)">Product details</h2>
        <table class="spec"><tbody>
          <tr><th scope="row">Brand</th><td>${esc(p.brand || 'Unbranded')}</td></tr>
          <tr><th scope="row">Category</th><td>${esc(p.category_name)}</td></tr>
          <tr><th scope="row">Product type</th><td>${esc(productType(p.product_name, p.brand))}</td></tr>
          <tr><th scope="row">Seller</th><td>${esc(p.seller_name)}</td></tr>
          <tr><th scope="row">Item number</th><td class="num">${p.product_id}</td></tr>
          <tr><th scope="row">Listing updated</th><td>${date(p.last_updated)}</td></tr></tbody></table>
      </div>
      <aside class="buybox" aria-label="Buy">
        ${price(p.price)}
        <div>${p.is_active ? stockText(p.quantity_in_stock, p.reorder_level, p.in_stock) : '<span class="stock stock--out">Currently unavailable</span>'}</div>
        <div class="buybox__ship">${icon('pin')}<span id="deliver">${me ? 'Finding your delivery address…' : '<a href="../login.html?role=customer&next=' + encodeURIComponent('customer/product.html?id=' + p.product_id) + '">Sign in</a> to see your delivery address'}</span></div>
        ${avail ? `<div class="buybox__row"><label for="qty">Quantity</label><div class="qty"><button type="button" id="dec" aria-label="Decrease quantity">${icon('minus', 14)}</button><input id="qty" type="number" min="1" max="${max}" value="1" inputmode="numeric"><button type="button" id="inc" aria-label="Increase quantity">${icon('plus', 14)}</button></div></div>` : ''}
        <button class="btn btn--cta btn--block btn--lg" id="add" ${avail ? '' : 'disabled'}>${icon('cart-plus')} Add to cart</button>
        <button class="btn btn--primary btn--block btn--lg" id="buy" ${avail ? '' : 'disabled'}>Buy now</button>
        ${inCart ? `<p class="small" style="margin:0;color:var(--success);font-weight:600">${inCart} already in your <a href="cart.html">cart</a></p>` : ''}
        <dl><dt>Ships from</dt><dd>${esc(p.seller_name)}</dd><dt>Sold by</dt><dd>${esc(p.seller_name)}</dd><dt>Payment</dt><dd>UPI, cards, net banking, wallet</dd></dl>
      </aside>
    </div>
    <section class="shelf" id="similar" hidden><div class="shelf__head"><h2>More in ${esc(p.category_name)}</h2><a href="${shopUrl({ category_id: p.category_id })}">See all</a></div><div id="simrail"></div></section>`;
    credit(p).then((h) => { const c = document.getElementById('credit'); if (c) c.innerHTML = h; });
    if (avail) {
      const q = document.getElementById('qty'), clamp = () => (q.value = Math.max(1, Math.min(max || 1, Math.floor(Number(q.value)) || 1)));
      const sync = () => { document.getElementById('dec').disabled = Number(q.value) <= 1; document.getElementById('inc').disabled = Number(q.value) >= max; };
      document.getElementById('dec').onclick = () => { q.value = Number(q.value) - 1; clamp(); sync(); };
      document.getElementById('inc').onclick = () => { q.value = Number(q.value) + 1; clamp(); sync(); };
      q.onchange = () => { clamp(); sync(); }; sync();
      document.getElementById('add').onclick = () => { clamp(); addToCart(p, Number(q.value)); };
      document.getElementById('buy').onclick = () => { clamp(); cart.add(cartItem(p), Number(q.value)); location.href = 'cart.html'; };
    }
    if (me) api.customers.addresses(me.id).then((a) => { const el = document.getElementById('deliver'); if (el) el.innerHTML = a.length ? `Deliver to <b>${esc(me.name.split(' ')[0])}</b>, ${esc(a[0].city)} ${esc(a[0].pin_code || '')}` : 'No saved delivery address on your account'; }).catch(() => {});
    api.products.search({ category_id: p.category_id, in_stock_only: true, limit: 100 }).then((rows) => {
      const others = rows.filter((r) => r.product_id !== p.product_id);
      if (!others.length) return;
      const near = others.sort((a, b) => Math.abs(a.price - p.price) - Math.abs(b.price - p.price)).slice(0, 12).sort((a, b) => a.price - b.price);
      document.getElementById('simrail').innerHTML = rail(near.map(mini).join('')); document.getElementById('similar').hidden = false; wireRails(page);
    }).catch(() => {});
  } catch (e) {
    page.innerHTML = `<div class="panel">${e.status === 404 ? emptyState({ icon: 'search', title: 'This product does not exist', text: 'It may have been removed by the seller.', action: '<a class="btn btn--primary" href="shop.html">Browse products</a>' }) : errorState(e.message)}</div>`;
    page.querySelector('[data-retry]')?.addEventListener('click', load);
  }
}
load();
