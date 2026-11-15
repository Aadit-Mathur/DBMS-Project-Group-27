import { api } from '../js/api.js';
import { mountPortal } from '../js/layout.js';
import { money, int, date, dateTime, esc, badge, stockBadge, art } from '../js/format.js';
import { emptyState, errorState, skeletonRows, $, $$ } from '../js/dom.js';
import { toast, toastError } from '../js/toast.js';
import { formModal, confirmDialog } from '../js/modal.js';
import { icon } from '../js/icons.js';

const portal = mountPortal('seller', [{ id: 'dashboard', label: 'Dashboard', icon: 'dashboard' }, { id: 'products', label: 'Products', icon: 'package' }, { id: 'orders', label: 'Orders', icon: 'truck' }], 'Dashboard');
const { main, session: me } = portal;
let cats = [];
const catOptions = () => cats.map((c) => ({ value: c.category_id, label: c.category_name }));
const stat = (ic, v, l, cls = '') => `<div class="card stat ${cls}"><span class="stat__ic">${icon(ic)}</span><div><div class="stat__v">${v}</div><div class="stat__l">${l}</div></div></div>`;
const loading = () => { main.innerHTML = skeletonRows(6); };
const fail = (e, retry) => { main.innerHTML = errorState(e.message); $('[data-retry]').onclick = retry; };

// ---- shared product dialogs -------------------------------------------------------------------
function restockDialog(p, done) {
  formModal({ title: `Restock “${p.product_name}”`, submitLabel: 'Add stock', intro: `Currently ${p.quantity_in_stock} in stock (reorder level ${p.reorder_level}).`,
    fields: [{ name: 'quantity', label: 'Units to add', type: 'number', min: 1, step: 1, required: true, value: Math.max(1, (p.reorder_level || 10) * 2 - p.quantity_in_stock), full: true }],
    onSubmit: async (v) => { const r = await api.products.restock(p.product_id, Number(v.quantity)); toast(`Stock updated: ${r.quantity_in_stock} units now in stock.`, 'success'); done(); } });
}
const productFields = (p = {}) => [
  { name: 'product_name', label: 'Product name', required: true, value: p.product_name, full: true, maxlength: 150 },
  { name: 'category_id', label: 'Category', type: 'select', required: true, value: p.category_id, options: catOptions() },
  { name: 'brand', label: 'Brand', value: p.brand ?? '' },
  { name: 'price', label: 'Price (₹)', type: 'number', min: 0, step: '0.01', required: true, value: p.price },
  { name: 'reorder_level', label: 'Reorder level', type: 'number', min: 0, step: 1, required: true, value: p.reorder_level ?? 10, hint: 'Low-stock alert threshold' },
  ...(p.product_id ? [] : [{ name: 'quantity_in_stock', label: 'Opening stock', type: 'number', min: 0, step: 1, required: true, value: 0 }]),
  { name: 'description', label: 'Description', type: 'textarea', value: p.description ?? '', full: true }];

// ---- Dashboard ---------------------------------------------------------------------------------
async function dashboard() {
  loading();
  try {
    const [d, low, orders] = await Promise.all([api.sellers.dashboard(me.id), api.sellers.lowStock(me.id), api.sellers.orders(me.id)]);
    const recent = groupOrders(orders).slice(0, 5);
    main.innerHTML = `<div class="grid-stats">${stat('package', int(d.active_products), 'Active products')}${stat('bag', int(d.units_in_stock), 'Units in stock', 'stat--info')}${stat('rupee', money(d.inventory_value), 'Inventory value', 'stat--ok')}${stat('alert', int(d.low_stock_products), 'Low-stock products', Number(d.low_stock_products) ? 'stat--warn' : '')}</div>
    <div class="cols"><section class="card"><div class="row row--between"><h3>${icon('alert')} Low-stock alerts</h3></div>${low.length ? `<div class="table-wrap"><table class="table"><thead><tr><th>Product</th><th class="num">In stock</th><th class="num">Reorder at</th><th></th></tr></thead><tbody>${low.map((p) => `<tr><td>${esc(p.product_name)}<div class="muted small">${esc(p.category_name)}</div></td><td class="num">${p.quantity_in_stock === 0 ? '<span class="badge badge--danger">0</span>' : p.quantity_in_stock}</td><td class="num">${p.reorder_level}</td><td class="right"><button class="btn btn--sm btn--primary" data-restock="${p.product_id}">Restock</button></td></tr>`).join('')}</tbody></table></div>` : emptyState({ icon: 'check', title: 'All stocked up', text: 'No products are below their reorder level.' })}</section>
    <section class="card"><h3>${icon('receipt')} Recent orders</h3>${recent.length ? recent.map((o) => `<div class="row row--between" style="padding:.5rem 0;border-bottom:1px solid var(--border)"><span><b>#${o.order_id}</b> <span class="muted small">${date(o.order_date)}</span></span><span>${badge(o.status)}</span></div>`).join('') + '<p style="margin:var(--s3) 0 0"><a href="#orders">View all orders →</a></p>' : '<p class="muted">No orders contain your products yet.</p>'}</section></div>`;
    $$('[data-restock]').forEach((b) => (b.onclick = () => { const p = low.find((x) => x.product_id === Number(b.dataset.restock)); restockDialog(p, dashboard); }));
  } catch (e) { fail(e, dashboard); }
}

// ---- Products ----------------------------------------------------------------------------------
let showDelisted = true, filter = '';
async function products() {
  loading();
  try {
    const all = await api.sellers.products(me.id, true);
    const draw = () => {
      const rows = all.filter((p) => (showDelisted || p.is_active) && (!filter || (p.product_name + (p.brand || '') + p.category_name).toLowerCase().includes(filter.toLowerCase())));
      $('#ptable').innerHTML = rows.length ? `<table class="table"><thead><tr><th>Product</th><th>Category</th><th class="num">Price</th><th class="num">Stock</th><th>Status</th><th class="right">Actions</th></tr></thead><tbody>${rows.map((p) => `<tr style="${p.is_active ? '' : 'opacity:.65'}"><td><div class="row" style="flex-wrap:nowrap">${art(p.product_name, p.category_id, 'product-art--sm')}<div><b>${esc(p.product_name)}</b><div class="muted small">${esc(p.brand || '—')}</div></div></div></td><td>${esc(p.category_name)}</td><td class="num">${money(p.price)}</td><td class="num">${p.quantity_in_stock}</td><td>${p.is_active ? stockBadge(p.quantity_in_stock, p.reorder_level) : '<span class="badge badge--plain badge--danger">Delisted</span>'}</td>
        <td class="right nowrap">${p.is_active ? `<button class="btn btn--sm" data-act="restock" data-id="${p.product_id}">Restock</button> <button class="btn btn--sm" data-act="edit" data-id="${p.product_id}" aria-label="Edit ${esc(p.product_name)}">${icon('edit')}</button> <button class="btn btn--sm btn--danger" data-act="delist" data-id="${p.product_id}" aria-label="Delist ${esc(p.product_name)}">${icon('trash')}</button>` : `<button class="btn btn--sm btn--primary" data-act="relist" data-id="${p.product_id}">Relist</button>`}</td></tr>`).join('')}</tbody></table>` : emptyState({ icon: 'package', title: all.length ? 'No matching products' : 'No products yet', text: all.length ? 'Try another search.' : 'Add your first product to start selling.' });
    };
    main.innerHTML = `<div class="page-head"><div class="row"><input class="input" id="pf" type="search" placeholder="Filter products" aria-label="Filter products" style="width:240px" value="${esc(filter)}"><label class="check"><input type="checkbox" id="sd" ${showDelisted ? 'checked' : ''}> Show delisted</label></div><button class="btn btn--primary" id="add">${icon('plus')} Add product</button></div><div class="table-wrap" id="ptable"></div>`;
    draw();
    $('#pf').oninput = (e) => { filter = e.target.value; draw(); }; $('#sd').onchange = (e) => { showDelisted = e.target.checked; draw(); };
    $('#add').onclick = () => formModal({ title: 'Add product', wide: true, submitLabel: 'Add product', fields: productFields(), onSubmit: async (v) => {
      await api.sellers.addProduct(me.id, { category_id: Number(v.category_id), product_name: v.product_name.trim(), price: Number(v.price), description: v.description || null, brand: v.brand || null, quantity_in_stock: Number(v.quantity_in_stock), reorder_level: Number(v.reorder_level) });
      toast('Product added.', 'success'); products(); } });
    $('#ptable').onclick = async (e) => {
      const b = e.target.closest('[data-act]'); if (!b) return; const p = all.find((x) => x.product_id === Number(b.dataset.id)), act = b.dataset.act;
      try {
        if (act === 'restock') restockDialog(p, products);
        if (act === 'edit') formModal({ title: 'Edit product', wide: true, intro: 'Stock is changed through restocking and orders only.', fields: productFields(p), onSubmit: async (v) => {
          await api.products.update(p.product_id, { category_id: Number(v.category_id), product_name: v.product_name.trim(), price: Number(v.price), brand: v.brand, description: v.description, reorder_level: Number(v.reorder_level) }); toast('Product updated.', 'success'); products(); } });
        if (act === 'delist' && await confirmDialog({ title: 'Remove product?', message: `“${p.product_name}” will be removed. If it appears in past orders it is hidden from customers instead of deleted.`, confirmLabel: 'Remove', danger: true })) {
          const r = await api.products.remove(p.product_id); toast(r.status === 'delisted' ? (r.reason || 'Product delisted.') : 'Product deleted.', 'success'); products(); }
        if (act === 'relist') { await api.products.relist(p.product_id); toast('Product relisted.', 'success'); products(); }
      } catch (err) { toastError(err); }
    };
  } catch (e) { fail(e, products); }
}

// ---- Orders ------------------------------------------------------------------------------------
function groupOrders(rows) {
  const m = new Map();
  for (const r of rows) { if (!m.has(r.order_id)) m.set(r.order_id, { ...r, items: [] }); m.get(r.order_id).items.push(r); }
  return [...m.values()];
}
const NEXT = { Pending: 'Shipped', Shipped: 'In Transit', 'In Transit': 'Delivered' };
let ostatus = '';
async function orders() {
  loading();
  try {
    const all = groupOrders(await api.sellers.orders(me.id));
    const draw = () => {
      const rows = all.filter((o) => !ostatus || o.status === ostatus);
      $('#olist').innerHTML = rows.length ? rows.map((o) => {
        const ship = o.shipment_status, next = o.status === 'Confirmed' || o.status === 'Shipped' ? NEXT[ship || 'Pending'] : null;
        return `<article class="card" style="margin-bottom:var(--s4)"><div class="row row--between"><div><b>Order #${o.order_id}</b> <span class="muted small">· ${dateTime(o.order_date)}</span></div><div class="row">${badge(o.status)}${ship && ship !== o.status ? badge(ship) : ''}${next ? `<button class="btn btn--sm btn--primary" data-ship="${o.order_id}" data-next="${next}">${icon('truck')} Mark ${next === 'Shipped' ? 'shipped' : next.toLowerCase()}</button>` : ''}</div></div>
          <div class="table-wrap" style="margin-top:var(--s3)"><table class="table"><thead><tr><th>Product</th><th class="num">Qty</th><th class="num">Price</th><th class="num">Subtotal</th></tr></thead><tbody>${o.items.map((i) => `<tr><td>${esc(i.product_name)}</td><td class="num">${i.quantity}</td><td class="num">${money(i.unit_price)}</td><td class="num">${money(i.subtotal)}</td></tr>`).join('')}</tbody></table></div>
          ${o.tracking_number ? `<p class="muted small" style="margin:var(--s3) 0 0">${esc(o.carrier || 'Carrier')} · ${esc(o.tracking_number)}</p>` : ''}${o.status === 'Pending' ? '<p class="muted small" style="margin:var(--s3) 0 0">Awaiting customer payment before it can be shipped.</p>' : ''}</article>`;
      }).join('') : emptyState({ icon: 'truck', title: 'No orders here', text: ostatus ? `No ${ostatus.toLowerCase()} orders.` : 'Orders containing your products will appear here.' });
    };
    main.innerHTML = `<div class="tabs" id="otabs" role="tablist">${['', 'Pending', 'Confirmed', 'Shipped', 'Delivered', 'Cancelled'].map((s) => `<button role="tab" data-s="${s}" aria-selected="${s === ostatus}">${s || 'All'}</button>`).join('')}</div><p class="muted small">Shipment status applies to the whole order (all sellers’ items).</p><div id="olist"></div>`;
    draw();
    $('#otabs').onclick = (e) => { const b = e.target.closest('[data-s]'); if (!b) return; ostatus = b.dataset.s; $$('#otabs button').forEach((x) => x.setAttribute('aria-selected', x === b)); draw(); };
    $('#olist').onclick = (e) => {
      const b = e.target.closest('[data-ship]'); if (!b) return; const id = Number(b.dataset.ship), next = b.dataset.next;
      const go = async (v = {}, m) => { await api.orders.shipment(id, { status: next, ...(v.carrier ? { carrier: v.carrier.trim() } : {}) }); toast(`Order #${id} marked ${next}.`, 'success'); orders(); };
      if (next === 'Shipped') formModal({ title: `Ship order #${id}`, submitLabel: 'Mark shipped', fields: [{ name: 'carrier', label: 'Carrier', placeholder: 'e.g. BlueDart', maxlength: 50, full: true, hint: 'Optional' }], onSubmit: go });
      else confirmDialog({ title: `Mark order #${id} as ${next}?`, message: 'The customer will see the updated tracking status.', confirmLabel: `Mark ${next}` }).then((ok) => ok && go().catch(toastError));
    };
  } catch (e) { fail(e, orders); }
}

const routes = { dashboard, products, orders };
const go = () => routes[portal.route()]();
window.addEventListener('hashchange', go);
api.categories().then((c) => (cats = c)).catch(toastError);
go();
