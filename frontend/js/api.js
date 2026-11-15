import { API_BASE } from './config.js';
import { session, adminKey } from './state.js';

export class ApiError extends Error {
  constructor(status, message, data) { super(message); this.status = status; this.data = data; }
}

function messageFrom(data, status) {
  if (!data) return `Request failed (${status})`;
  if (typeof data.error === 'string') return data.error;                 // database constraint errors
  if (typeof data.detail === 'string') return data.detail;               // HTTPException
  if (Array.isArray(data.detail))                                        // FastAPI validation (422)
    return data.detail.map((d) => `${(d.loc || []).slice(1).join('.') || 'input'}: ${d.msg}`).join('; ');
  return `Request failed (${status})`;
}

async function request(method, path, { params, body, seller, admin } = {}) {
  const url = new URL(API_BASE + path, location.href);
  for (const [k, v] of Object.entries(params || {})) if (v !== undefined && v !== null && v !== '') url.searchParams.set(k, v);
  const headers = {};
  if (body !== undefined) headers['Content-Type'] = 'application/json';
  if (seller) headers['X-Seller-Id'] = String(session.get()?.id ?? '');
  if (admin) headers['X-Admin-Key'] = adminKey.get();
  let res;
  try { res = await fetch(url, { method, headers, body: body !== undefined ? JSON.stringify(body) : undefined }); }
  catch { throw new ApiError(0, `Cannot reach the server at ${API_BASE || location.origin}. Is the backend running?`); }
  let data = null;
  if (res.status !== 204) { try { data = await res.json(); } catch { /* empty body */ } }
  if (!res.ok) {
    if (admin && res.status === 401) { adminKey.clear(); }
    throw new ApiError(res.status, messageFrom(data, res.status), data);
  }
  return data ?? { status: res.status };
}
const get = (p, o) => request('GET', p, o), post = (p, body, o) => request('POST', p, { ...o, body });

export const api = {
  health: () => get('/health'),
  categories: () => get('/categories'),
  products: {
    search: (params) => get('/products', { params }),
    get: (id) => get(`/products/${id}`),
    update: (id, body) => request('PATCH', `/products/${id}`, { body, seller: true }),
    restock: (id, quantity) => post(`/products/${id}/restock`, { quantity }, { seller: true }),
    remove: (id) => request('DELETE', `/products/${id}`, { seller: true }),   // 204 = deleted, 200 = delisted
    relist: (id) => post(`/products/${id}/relist`, undefined, { seller: true }),
  },
  customers: {
    find: (email) => get('/customers', { params: { email } }),
    addresses: (id) => get(`/customers/${id}/addresses`),
    orders: (id, params) => get(`/customers/${id}/orders`, { params }),
  },
  // Seller routes send X-Seller-Id; the backend checks it against the seller in the URL.
  sellers: {
    register: (body) => post('/sellers', body),
    find: (email) => get('/sellers', { params: { email } }),
    dashboard: (id) => get(`/sellers/${id}/dashboard`, { seller: true }),
    products: (id, include_inactive = true) => get(`/sellers/${id}/products`, { params: { include_inactive }, seller: true }),
    addProduct: (id, body) => post(`/sellers/${id}/products`, body, { seller: true }),
    lowStock: (id) => get(`/sellers/${id}/low-stock`, { seller: true }),
    orders: (id) => get(`/sellers/${id}/orders`, { seller: true }),
  },
  orders: {
    place: (body) => post('/orders', body),
    get: (id) => get(`/orders/${id}`),
    tracking: (id) => get(`/orders/${id}/tracking`),
    pay: (id, body) => post(`/orders/${id}/payment`, body),
    cancel: (id, body) => post(`/orders/${id}/cancel`, body),
    // Only a seller with items in the order, or the admin, may move its shipment.
    shipment: (id, body, as = 'seller') => post(`/orders/${id}/shipment`, body, as === 'admin' ? { admin: true } : { seller: true }),
    expireUnpaid: (minutes) => request('POST', `/orders/expire-unpaid`, { params: { minutes }, admin: true }),
  },
  admin: Object.fromEntries(
    ['overview', 'summary', 'revenue-trend', 'orders-by-status', 'top-products', 'top-sellers', 'sales-by-category',
      'low-stock', 'payments', 'new-customers', 'shipments'].map((n) => [n, (params) => get(`/admin/${n}`, { params, admin: true })])),
};
