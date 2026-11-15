// Session (who is "signed in": there are no passwords in the backend) + per-customer cart store.
const SKEY = 'mk_session', AKEY = 'mk_admin_key';
const ls = {
  get(k) { try { return localStorage.getItem(k); } catch { return null; } },
  set(k, v) { try { localStorage.setItem(k, v); } catch { /* storage blocked */ } },
  del(k) { try { localStorage.removeItem(k); } catch { /* storage blocked */ } },
};
export const session = {
  get() { try { return JSON.parse(ls.get(SKEY)); } catch { return null; } },
  set(s) { ls.set(SKEY, JSON.stringify(s)); },
  clear() { ls.del(SKEY); try { sessionStorage.removeItem(AKEY); } catch { /* blocked */ } },
};
export const customer = () => { const s = session.get(); return s?.role === 'customer' ? s : null; };
export const adminKey = {
  get: () => { try { return sessionStorage.getItem(AKEY) || ''; } catch { return ''; } },
  set: (k) => { try { sessionStorage.setItem(AKEY, k); } catch { /* blocked */ } },
  clear: () => { try { sessionStorage.removeItem(AKEY); } catch { /* blocked */ } },
};

// Guests get their own cart; it is merged into the customer's cart when they sign in.
const ckey = (id) => 'mk_cart_' + (id ?? (customer()?.id ?? 'guest'));
const read = (id) => { try { return JSON.parse(ls.get(ckey(id))) || []; } catch { return []; } };
const write = (items, id) => { ls.set(ckey(id), JSON.stringify(items)); window.dispatchEvent(new Event('cartchange')); };
export const cart = {
  items: () => read(),
  count: () => read().reduce((n, i) => n + i.quantity, 0),
  total: () => read().reduce((n, i) => n + i.quantity * Number(i.price), 0),
  has: (id) => read().some((i) => i.product_id === id),
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
  mergeGuestInto(customerId) {
    const guest = read('guest'); if (!guest.length) return 0;
    const mine = read(customerId);
    for (const g of guest) { const f = mine.find((i) => i.product_id === g.product_id); if (f) f.quantity = Math.min(1000, f.quantity + g.quantity); else mine.push(g); }
    write(mine, customerId); ls.del(ckey('guest'));
    return guest.length;
  },
};

// Small session cache so every page does not refetch the category list.
export async function cached(key, ttlMs, load) {
  try { const c = JSON.parse(sessionStorage.getItem('mk_c_' + key)); if (c && Date.now() - c.t < ttlMs) return c.v; } catch { /* ignore */ }
  const v = await load();
  try { sessionStorage.setItem('mk_c_' + key, JSON.stringify({ t: Date.now(), v })); } catch { /* ignore */ }
  return v;
}
