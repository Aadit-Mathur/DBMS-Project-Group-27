// Session (who is "signed in": there are no passwords in the backend) + per-customer cart store.
const SKEY = 'mk_session', AKEY = 'mk_admin_key';
export const session = {
  get() { try { return JSON.parse(localStorage.getItem(SKEY)); } catch { return null; } },
  set(s) { localStorage.setItem(SKEY, JSON.stringify(s)); },
  clear() { localStorage.removeItem(SKEY); sessionStorage.removeItem(AKEY); },
};
export const adminKey = {
  get: () => sessionStorage.getItem(AKEY) || '',
  set: (k) => sessionStorage.setItem(AKEY, k),
  clear: () => sessionStorage.removeItem(AKEY),
};
const ckey = () => 'mk_cart_' + (session.get()?.id ?? 'guest');
const read = () => { try { return JSON.parse(localStorage.getItem(ckey())) || []; } catch { return []; } };
const write = (items) => { localStorage.setItem(ckey(), JSON.stringify(items)); window.dispatchEvent(new Event('cartchange')); };
export const cart = {
  items: read,
  count: () => read().reduce((n, i) => n + i.quantity, 0),
  total: () => read().reduce((n, i) => n + i.quantity * Number(i.price), 0),
  add(p, qty = 1) {
    const items = read(), f = items.find((i) => i.product_id === p.product_id);
    if (f) { f.quantity = Math.min(1000, f.quantity + qty); Object.assign(f, p, { quantity: f.quantity }); }
    else items.push({ ...p, quantity: qty });
    write(items);
  },
  setQty(id, q) { write(read().map((i) => (i.product_id === id ? { ...i, quantity: Math.max(1, Math.min(1000, q)) } : i))); },
  update(id, patch) { write(read().map((i) => (i.product_id === id ? { ...i, ...patch } : i))); },
  remove(id) { write(read().filter((i) => i.product_id !== id)); },
  clear() { write([]); },
};
