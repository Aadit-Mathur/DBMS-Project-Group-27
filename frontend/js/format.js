import { CURRENCY } from './config.js';
const cur = new Intl.NumberFormat('en-IN', { style: 'currency', currency: CURRENCY, maximumFractionDigits: 2 });
const dfmt = new Intl.DateTimeFormat('en-IN', { day: 'numeric', month: 'short', year: 'numeric' });
const dtfmt = new Intl.DateTimeFormat('en-IN', { day: 'numeric', month: 'short', year: 'numeric', hour: 'numeric', minute: '2-digit' });
export const money = (v) => cur.format(Number(v || 0));
export const moneyShort = (v) => new Intl.NumberFormat('en-IN', { style: 'currency', currency: CURRENCY, maximumFractionDigits: 0 }).format(Number(v || 0));
export const int = (v) => new Intl.NumberFormat('en-IN').format(Number(v || 0));
export const date = (d) => (d ? dfmt.format(new Date(d)) : '—');
export const dateTime = (d) => (d ? dtfmt.format(new Date(d)) : '—');
export const esc = (s) => String(s ?? '').replace(/[&<>"']/g, (c) => ({ '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' }[c]));
export const addressLine = (a) => [a.house_no, a.street, a.locality, a.city, a.district, a.state].filter(Boolean).map(esc).join(', ') + (a.pin_code ? ` – ${esc(a.pin_code)}` : '');

const TONES = { Pending: 'warn', Confirmed: 'info', Shipped: 'info', 'In Transit': 'info', Delivered: 'success', Cancelled: 'danger',
  Successful: 'success', Failed: 'danger', Refunded: 'plain', Declined: 'danger' };
export const badge = (status, label) => status ? `<span class="badge badge--${TONES[status] || 'plain'}">${esc(label || status)}</span>` : '<span class="muted">—</span>';

export function stockBadge(qty, reorder, inStock = qty > 0) {
  if (!inStock || qty === 0) return '<span class="badge badge--danger">Out of stock</span>';
  if (qty !== undefined && qty <= (reorder ?? 10)) return `<span class="badge badge--warn">Low stock · ${qty} left</span>`;
  return '<span class="badge badge--success">In stock</span>';
}

// Category-based placeholder art (the data has no images): a stable hue per category.
export function art(name, categoryId, cls = '') {
  const hue = ((Number(categoryId) || 0) * 47 + 215) % 360;
  const mono = esc(String(name || '?').trim().split(/\s+/).slice(0, 2).map((w) => w[0]).join('').toUpperCase());
  return `<div class="product-art ${cls}" style="background:linear-gradient(135deg,hsl(${hue} 72% 52%),hsl(${(hue + 45) % 360} 70% 40%))" aria-hidden="true">${mono}</div>`;
}
