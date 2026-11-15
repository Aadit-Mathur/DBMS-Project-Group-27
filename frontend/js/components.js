// Shared storefront pieces: product tile, rail item, rails, metro line (order progress).
import { esc, price, productImage, displayName, dateShort } from './format.js';
import { icon } from './icons.js';
import { cart } from './state.js';
import { toast } from './toast.js';
import { url } from './layout.js';

export const productUrl = (id) => url(`customer/product.html?id=${id}`);
export const shopUrl = (q = {}) => url('customer/shop.html') + (Object.keys(q).length ? '?' + new URLSearchParams(q) : '');

// What the cart stores for a product (enough to render the cart without refetching).
export const cartItem = (p) => ({ product_id: p.product_id, product_name: p.product_name, price: p.price, brand: p.brand, category_id: p.category_id, category_name: p.category_name, seller_name: p.seller_name });
export function addToCart(p, qty = 1) {
  cart.add(cartItem(p), qty);
  toast(`Added to cart: ${displayName(p.product_name)}`, 'success', 3500, { href: url('customer/cart.html'), label: 'View cart' });
}

export function tile(p) {
  const out = !p.in_stock;
  return `<article class="tile ${out ? 'tile--out' : ''}">${productImage(p)}
  <div class="tile__body"><h3 class="tile__name clamp-2"><a href="${productUrl(p.product_id)}">${esc(displayName(p.product_name))}</a></h3>
    <span class="tile__brand">${p.brand ? esc(p.brand) : 'Unbranded'}</span>
    <div class="tile__price">${price(p.price)}</div>
    <span class="tile__meta">${out ? '<span class="stock stock--out">Out of stock</span>' : 'Free delivery'}. Sold by ${esc(p.seller_name)}</span>
    <div class="tile__foot"><button class="btn btn--cta btn--sm btn--block" data-add="${p.product_id}" ${out ? 'disabled' : ''}>${out ? 'Currently unavailable' : 'Add to cart'}</button></div></div></article>`;
}

export const mini = (p) => `<a class="mini" href="${productUrl(p.product_id)}">${productImage(p)}<span class="mini__name clamp-2">${esc(displayName(p.product_name))}</span>${price(p.price)}<span class="mini__brand">${esc(p.brand || '')}</span></a>`;

// Horizontal scroller with previous/next buttons that hide at the ends.
export function rail(items) {
  return `<div class="rail"><button class="rail__btn rail__btn--prev" type="button" aria-label="Scroll left" hidden>${icon('chev-l')}</button><div class="rail__track">${items}</div><button class="rail__btn rail__btn--next" type="button" aria-label="Scroll right">${icon('chev-r')}</button></div>`;
}
export function wireRails(root = document) {
  root.querySelectorAll('.rail').forEach((r) => {
    if (r.dataset.wired) return; r.dataset.wired = 1;
    const t = r.querySelector('.rail__track'), prev = r.querySelector('.rail__btn--prev'), next = r.querySelector('.rail__btn--next');
    const sync = () => { prev.hidden = t.scrollLeft < 8; next.hidden = t.scrollLeft + t.clientWidth >= t.scrollWidth - 8; };
    prev.onclick = () => t.scrollBy({ left: -t.clientWidth * 0.9 }); next.onclick = () => t.scrollBy({ left: t.clientWidth * 0.9 });
    t.addEventListener('scroll', sync, { passive: true }); new ResizeObserver(sync).observe(t); sync();
  });
}

// ---- metro line: the order's journey as stations ---------------------------------------------
// rank: 1 placed, 2 paid, 3 shipped, 4 in transit, 5 delivered.
export function orderRank(status, shipStatus, payStatus) {
  const paid = ['Successful', 'Refunded'].includes(payStatus) || ['Confirmed', 'Shipped', 'Delivered'].includes(status);
  return { Shipped: 3, 'In Transit': 4, Delivered: 5 }[shipStatus] ?? (status === 'Delivered' ? 5 : status === 'Shipped' ? 3 : paid ? 2 : 1);
}
const STATIONS = ['Ordered', 'Paid', 'Shipped', 'In transit', 'Delivered'];
export function metro(o) {
  const cancelled = o.status === 'Cancelled', rank = orderRank(o.status, o.shipment?.status, o.payment?.status);
  const when = { 1: o.order_date, 2: o.payment?.payment_date, 3: o.shipment?.shipment_date, 5: o.shipment?.delivery_date };
  return `<ol class="metro ${cancelled ? 'is-cancelled' : ''}" aria-label="Order progress">${STATIONS.map((l, i) => {
    const n = i + 1, done = cancelled ? n === 1 : n < rank || (n === rank && n !== 5 ? true : n <= rank), cur = !cancelled && n === rank && n < 5;
    const label = cancelled && n === 2 ? 'Cancelled' : l;
    return `<li class="${done ? 'done' : ''} ${cur ? 'current' : ''}" ${cur ? 'aria-current="step"' : ''}><span class="stn">${done && !cur ? icon('check') : ''}</span>${label}${done && when[n] ? `<span class="when">${dateShort(when[n])}</span>` : ''}</li>`;
  }).join('')}</ol>`;
}
export function metroMini(status, shipStatus, payStatus) {
  const cancelled = status === 'Cancelled', rank = cancelled ? 1 : orderRank(status, shipStatus, payStatus);
  const label = cancelled ? 'Cancelled' : { 1: 'Awaiting payment', 2: 'Paid, preparing to ship', 3: 'Shipped', 4: 'In transit', 5: 'Delivered' }[rank];
  return `<div class="metro-mini-wrap"><span class="metro-mini-label" style="color:${cancelled ? 'var(--danger)' : rank === 5 ? 'var(--success)' : 'var(--ink)'}">${label}</span><span class="metro-mini ${cancelled ? 'is-cancelled' : ''}" aria-hidden="true">${STATIONS.map((_, i) => `<i class="${i < rank ? 'on' : ''}"></i><b class="${i < rank ? 'on' : ''}"></b>`).join('')}</span></div>`;
}
