import { CURRENCY } from './config.js';
import { IMG } from './images.js';
import { icon } from './icons.js';

const cur = new Intl.NumberFormat('en-IN', { style: 'currency', currency: CURRENCY, maximumFractionDigits: 2 });
const whole = new Intl.NumberFormat('en-IN', { maximumFractionDigits: 0 });
const dfmt = new Intl.DateTimeFormat('en-IN', { day: 'numeric', month: 'short', year: 'numeric' });
const dshort = new Intl.DateTimeFormat('en-IN', { day: 'numeric', month: 'short' });
const dtfmt = new Intl.DateTimeFormat('en-IN', { day: 'numeric', month: 'short', year: 'numeric', hour: 'numeric', minute: '2-digit' });
export const money = (v) => cur.format(Number(v || 0));
export const moneyShort = (v) => new Intl.NumberFormat('en-IN', { style: 'currency', currency: CURRENCY, maximumFractionDigits: 0 }).format(Number(v || 0));
export const int = (v) => new Intl.NumberFormat('en-IN').format(Number(v || 0));
export const date = (d) => (d ? dfmt.format(new Date(d)) : '—');
export const dateShort = (d) => (d ? dshort.format(new Date(d)) : '—');
export const dateTime = (d) => (d ? dtfmt.format(new Date(d)) : '—');
export const esc = (s) => String(s ?? '').replace(/[&<>"']/g, (c) => ({ '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' }[c]));
export const addressLine = (a) => [a.house_no, a.street, a.locality, a.city, a.district, a.state].filter(Boolean).map(esc).join(', ') + (a.pin_code ? ` ${esc(a.pin_code)}` : '');

// Price with a raised rupee sign, the way Indian marketplaces set it. Paise shown only when present.
export function price(v, cls = '') {
  const n = Number(v || 0), r = Math.floor(n), p = Math.round((n - r) * 100);
  return `<span class="price ${cls}"><sup>₹</sup>${whole.format(r)}${p ? `<sup>.${String(p).padStart(2, '0')}</sup>` : ''}</span>`;
}

const TONES = { Pending: 'warn', Confirmed: 'info', Shipped: 'info', 'In Transit': 'info', Delivered: 'success', Cancelled: 'danger',
  Successful: 'success', Failed: 'danger', Refunded: 'plain', Declined: 'danger' };
export const badge = (status, label) => status ? `<span class="badge badge--${TONES[status] || 'plain'}">${esc(label || status)}</span>` : '<span class="muted">—</span>';

// Stock line for the shopper. Quantities are only known on the product page and in seller views.
export function stockText(qty, reorder, inStock = qty > 0) {
  if (!inStock || qty === 0) return '<span class="stock stock--out">Out of stock</span>';
  if (qty !== undefined && qty <= (reorder ?? 10)) return `<span class="stock stock--low">Only ${qty} left in stock</span>`;
  return '<span class="stock stock--in">In stock</span>';
}
export function stockBadge(qty, reorder, inStock = qty > 0) {
  if (!inStock || qty === 0) return '<span class="badge badge--danger">Out of stock</span>';
  if (qty !== undefined && qty <= (reorder ?? 10)) return `<span class="badge badge--warn">Low stock, ${qty} left</span>`;
  return '<span class="badge badge--success">In stock</span>';
}

// ---- product imagery -------------------------------------------------------------------------
// Product names follow "Brand Product type (Seller)". The photo is chosen by product type.
export function productType(name, brand) {
  let n = String(name || '').replace(/\s*\([^)]*\)\s*$/, '').trim();
  if (brand && n.toLowerCase().startsWith(String(brand).toLowerCase() + ' ')) n = n.slice(String(brand).length + 1);
  return n;
}
// Display name without the "(Seller)" suffix: the seller is shown separately.
export const displayName = (name) => String(name || '').replace(/\s*\([^)]*\)\s*$/, '').trim();

const ROOT = new URL('../img/products/', import.meta.url).href;
// Order lines carry no brand, so when the exact type is unknown drop leading words (the brand) until one matches.
export function imgSrc(p) {
  const words = productType(p.product_name, p.brand).toLowerCase().split(/\s+/);
  for (let k = 0; k < Math.min(4, words.length); k++) { const f = IMG[words.slice(k).join(' ')]; if (f) return ROOT + f; }
  return null;
}
export function productImage(p, cls = '', { eager = false } = {}) {
  const src = imgSrc(p);
  if (!src) return `<span class="pimg pimg--fallback ${cls}" aria-hidden="true">${icon('image')}</span>`;
  return `<span class="pimg ${cls}"><img src="${src}" alt="" ${eager ? 'fetchpriority="high"' : 'loading="lazy"'} decoding="async"></span>`;
}
export const typeImage = (type, cls = '') => {
  const f = IMG[String(type).toLowerCase()];
  return f ? `<span class="pimg ${cls}"><img src="${ROOT + f}" alt="" loading="lazy" decoding="async"></span>` : `<span class="pimg pimg--fallback ${cls}">${icon('image')}</span>`;
};
export const typeSrc = (type) => { const f = IMG[String(type).toLowerCase()]; return f ? ROOT + f : ''; };

// One representative product type per category (for category tiles and banners).
export const CATEGORY_TYPE = {
  'Automotive': 'Car Vacuum Cleaner', 'Beauty & Personal Care': 'Vitamin C Face Serum', 'Books': 'Database Systems',
  'Clothing': "Women's Cotton Kurta", 'Computers & Laptops': '14-inch Business Laptop', 'Electronics': 'Over-Ear Wireless Headphones',
  'Footwear': "Men's Casual Sneakers", 'Furniture': 'Accent Chair', 'Grocery & Food': 'Basmati Rice 5kg',
  'Home & Kitchen': 'Stainless Steel Cookware Set', 'Home Appliances': 'Ceiling Fan', 'Kitchen Appliances': 'Air Fryer 4L',
  'Mobiles & Accessories': '5G Smartphone 128GB', 'Pet Supplies': 'Pet Bed', 'Sports & Fitness': 'Cricket Bat',
  'Stationery & Office Supplies': 'Gel Pen Pack', 'Toys & Games': 'Building Blocks Set', 'Travel & Luggage': 'Cabin Trolley Bag',
};
