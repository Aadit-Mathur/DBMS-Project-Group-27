import { api } from '../js/api.js';
import { mountPortal } from '../js/layout.js';
import { money, moneyShort, int, date, dateTime, esc, badge, stockBadge, productImage, displayName } from '../js/format.js';
import { emptyState, errorState, skeletonRows, $, $$ } from '../js/dom.js';
import { toast, toastError } from '../js/toast.js';
import { formModal, confirmDialog } from '../js/modal.js';
import { icon } from '../js/icons.js';
import { metroMini, productUrl } from '../js/components.js';

const portal = mountPortal('seller', [{ id: 'dashboard', label: 'Dashboard', icon: 'dashboard' }, { id: 'products', label: 'Products', icon: 'package' }, { id: 'orders', label: 'Orders', icon: 'truck' }], 'Dashboard');
const { main, actions, session: me } = portal;
let cats = [];
const catOptions = () => cats.map((c) => ({ value: c.category_id, label: c.category_name }));
const stat = (ic, v, l, cls = '') => `<div class="stat ${cls}"><span class="stat__ic">${icon(ic)}</span><div><div class="stat__v">${v}</div><div class="stat__l">${l}</div></div></div>`;
const loading = () => { main.innerHTML = skeletonRows(6); };
const fail = (e, retry) => { main.innerHTML = `<div class="panel">${errorState(e.message)}</div>`; $('[data-retry]').onclick = retry; };
const addButton = () => { actions.innerHTML = `<button class="btn btn--primary" id="add">${icon('plus')} Add product</button>`; $('#add').onclick = addDialog; };

// ---- product dialogs -------------------------------------------------------------------------
function restockDialog(p, done) {
  formModal({ title: `Restock ${displayName(p.product_name)}`, submitLabel: 'Add stock', intro: `${p.quantity_in_stock} in stock now. Low-stock alert at ${p.reorder_level} or fewer.`,
    fields: [{ name: 'quantity', label: 'Units to add', type: 'number', min: 1, step: 1, required: true, value: Math.max(1, (p.reorder_level || 10) * 2 - p.quantity_in_stock), full: true, hint: 'Runs the restock_product() function in the database.' }],
    onSubmit: async (v) => { const r = await api.products.restock(p.product_id, Number(v.quantity)); toast(`Restocked. ${r.quantity_in_stock} units in stock now.`, 'success'); done(); } });
}
const productFields = (p = {}) => [
  { name: 'product_name', label: 'Product name', required: true, value: p.product_name, full: true, maxlength: 150, hint: 'Shoppers search this name and the brand.' },
  { name: 'category_id', label: 'Category', type: 'select', required: true, value: p.category_id, options: catOptions() },
  { name: 'brand', label: 'Brand', value: p.brand ?? '' },
  { name: 'price', label: 'Price (₹)', type: 'number', min: 0, step: '0.01', required: true, value: p.price },
  { name: 'reorder_level', label: 'Low-stock alert at', type: 'number', min: 0, step: 1, required: true, value: p.reorder_level ?? 10, hint: 'Units left when the alert shows' },
  ...(p.product_id ? [] : [{ name: 'quantity_in_stock', label: 'Opening stock', type: 'number', min: 0, step: 1, required: true, value: 0 }]),
  { name: 'description', label: 'Description', type: 'textarea', value: p.description ?? '', full: true }];
function addDialog() {
  formModal({ title: 'Add a product', wide: true, submitLabel: 'Add product', fields: productFields(), onSubmit: async (v) => {
    await api.sellers.addProduct(me.id, { category_id: Number(v.category_id), product_name: v.product_name.trim(), price: Number(v.price), description: v.description || null, brand: v.brand || null, quantity_in_stock: Number(v.quantity_in_stock), reorder_level: Number(v.reorder_level) });
    toast('Product added and listed in the shop.', 'success'); location.hash === '#products' ? products() : (location.hash = '#products'); } });
}
function editDialog(p, done) {
  formModal({ title: 'Edit product', wide: true, intro: 'Stock changes only through restocking and orders, so it is not editable here.', fields: productFields(p), onSubmit: async (v) => {
    const body = { category_id: Number(v.category_id), product_name: v.product_name.trim(), price: Number(v.price), brand: v.brand || null, reorder_level: Number(v.reorder_level) };
    // Only send the description when it was loaded, so saving can never blank a description the form did not show.
    if ('description' in p) body.description = v.description || null;
    await api.products.update(p.product_id, body); toast('Product updated.', 'success'); done(); } });
}

// ---- Dashboard -------------------------------------------------------------------------------
async function dashboard() {
  loading(); addButton();
  try {
    const [d, low, orders] = await Promise.all([api.sellers.dashboard(me.id), api.sellers.lowStock(me.id), api.sellers.orders(me.id)]);
    const grouped = groupOrders(orders), recent = grouped.slice(0, 6), toShip = grouped.filter((o) => o.status === 'Confirmed' || (o.status === 'Shipped' && o.shipment_status !== 'Delivered')).length;
    main.innerHTML = `<p class="muted" style="margin-top:-.75rem">Signed in as ${esc(me.name)}.</p>
    <div class="grid-stats">${stat('package', int(d.active_products), 'Products listed')}${stat('layers', int(d.units_in_stock), 'Units in stock')}${stat('rupee', moneyShort(d.inventory_value), 'Stock value at list price', 'stat--ok')}${stat('alert', int(d.low_stock_products), 'Low on stock', Number(d.low_stock_products) ? 'stat--warn' : '')}${stat('truck', int(toShip), 'Orders to ship or deliver', toShip ? 'stat--cta' : '')}</div>
    <div class="cols"><section class="panel"><div class="panel__head"><h2>${icon('alert')} Low-stock alerts</h2><span class="muted small">From the view v_low_stock_products</span></div>${low.length ? `<div class="table-wrap"><table class="table"><thead><tr><th>Product</th><th class="num">In stock</th><th class="num">Alert at</th><th></th></tr></thead><tbody>${low.map((p) => `<tr><td><div class="prod-cell">${productImage(p, 'pimg--xs')}<div><b>${esc(displayName(p.product_name))}</b><span class="muted xsmall">${esc(p.category_name)}</span></div></div></td><td class="num">${p.quantity_in_stock === 0 ? '<span class="badge badge--danger">0</span>' : p.quantity_in_stock}</td><td class="num">${p.reorder_level}</td><td class="right"><button class="btn btn--sm btn--primary" data-restock="${p.product_id}">Restock</button></td></tr>`).join('')}</tbody></table></div>` : emptyState({ icon: 'check', title: 'Everything is well stocked', text: 'No product is at or below its alert level.' })}</section>
    <section class="panel"><div class="panel__head"><h2>${icon('receipt')} Recent orders</h2><a class="small" href="#orders">All orders</a></div>${recent.length ? recent.map((o) => `<div class="row row--between" style="padding:.6rem 0;border-bottom:1px solid var(--line)"><span><b>#${o.order_id}</b> <span class="muted xsmall">${date(o.order_date)}</span><br><span class="xsmall muted">${o.items.length} of your item${o.items.length === 1 ? '' : 's'}</span></span>${metroMini(o.status, o.shipment_status)}</div>`).join('') : emptyState({ icon: 'receipt', title: 'No orders yet', text: 'Orders that include your products show up here.' })}</section></div>`;
    $$('[data-restock]').forEach((b) => (b.onclick = () => restockDialog(low.find((x) => x.product_id === Number(b.dataset.restock)), dashboard)));
  } catch (e) { fail(e, dashboard); }
}

// ---- Products --------------------------------------------------------------------------------
let showDelisted = true, filter = '';
async function products() {
  loading(); addButton();
  try {
    const all = await api.sellers.products(me.id, true);
    const draw = () => {
      const rows = all.filter((p) => (showDelisted || p.is_active) && (!filter || (p.product_name + (p.brand || '') + p.category_name).toLowerCase().includes(filter.toLowerCase())));
      $('#count').textContent = `${rows.length} of ${all.length} products`;
      $('#ptable').innerHTML = rows.length ? `<table class="table"><thead><tr><th>Product</th><th>Category</th><th class="num">Price</th><th class="num">Stock</th><th>Status</th><th class="right">Actions</th></tr></thead><tbody>${rows.map((p) => `<tr class="${p.is_active ? '' : 'is-muted'}"><td><div class="prod-cell">${productImage(p, 'pimg--xs')}<div><a href="${productUrl(p.product_id)}" target="_blank" rel="noopener"><b>${esc(displayName(p.product_name))}</b></a><span class="muted xsmall">${esc(p.brand || 'No brand')}</span></div></div></td><td>${esc(p.category_name)}</td><td class="num">${money(p.price)}</td><td class="num">${int(p.quantity_in_stock)}</td><td>${p.is_active ? stockBadge(p.quantity_in_stock, p.reorder_level) : '<span class="badge badge--plain">Delisted</span>'}</td>
        <td class="right nowrap">${p.is_active ? `<button class="btn btn--sm" data-act="restock" data-id="${p.product_id}">Restock</button> <button class="btn btn--sm btn--icon" data-act="edit" data-id="${p.product_id}" aria-label="Edit ${esc(displayName(p.product_name))}" title="Edit">${icon('edit')}</button> <button class="btn btn--sm btn--icon btn--danger" data-act="delist" data-id="${p.product_id}" aria-label="Remove ${esc(displayName(p.product_name))}" title="Remove">${icon('trash')}</button>` : `<button class="btn btn--sm btn--primary" data-act="relist" data-id="${p.product_id}">Relist</button>`}</td></tr>`).join('')}</tbody></table>` : emptyState({ icon: 'package', title: all.length ? 'No products match' : 'You have no products yet', text: all.length ? 'Try another search, or show delisted products.' : 'Add your first product to start selling.', action: all.length ? '' : `<button class="btn btn--primary" data-act="add">${icon('plus')} Add product</button>` });
    };
    main.innerHTML = `<div class="toolbar"><div class="field grow" style="max-width:340px"><label for="pf">Search your products</label><input class="input" id="pf" type="search" placeholder="Name, brand or category" value="${esc(filter)}"></div>
      <label class="check" style="margin-bottom:.55rem"><input type="checkbox" id="sd" ${showDelisted ? 'checked' : ''}> Show delisted</label><span class="muted small" id="count" style="margin:0 0 .6rem auto"></span></div><div class="table-wrap" id="ptable"></div>`;
    draw();
    $('#pf').oninput = (e) => { filter = e.target.value; draw(); }; $('#sd').onchange = (e) => { showDelisted = e.target.checked; draw(); };
    $('#ptable').onclick = async (e) => {
      const b = e.target.closest('[data-act]'); if (!b) return; const act = b.dataset.act, p = all.find((x) => x.product_id === Number(b.dataset.id));
      try {
        if (act === 'add') addDialog();
        if (act === 'restock') restockDialog(p, products);
        if (act === 'edit') editDialog(p, products);
        if (act === 'delist' && await confirmDialog({ title: `Remove ${displayName(p.product_name)}?`, message: 'If this product is in any past order it is delisted (hidden from shoppers) instead of deleted, so order history stays intact. You can relist it later.', confirmLabel: 'Remove product', danger: true })) {
          const r = await api.products.remove(p.product_id); toast(r.status === 'delisted' ? 'Delisted: it is in past orders, so it was hidden instead of deleted.' : 'Product deleted.', 'success'); products(); }
        if (act === 'relist') { await api.products.relist(p.product_id); toast('Relisted. Shoppers can order it again.', 'success'); products(); }
      } catch (err) { toastError(err); }
    };
  } catch (e) { fail(e, products); }
}

// ---- Orders ----------------------------------------------------------------------------------
function groupOrders(rows) {
  const m = new Map();
  for (const r of rows) { if (!m.has(r.order_id)) m.set(r.order_id, { ...r, items: [] }); m.get(r.order_id).items.push(r); }
  return [...m.values()];
}
const NEXT = { Pending: 'Shipped', Shipped: 'In Transit', 'In Transit': 'Delivered' };
const OSTAT = [['', 'All'], ['Pending', 'Awaiting payment'], ['Confirmed', 'To ship'], ['Shipped', 'Shipped'], ['Delivered', 'Delivered'], ['Cancelled', 'Cancelled']];
let ostatus = '';
async function orders() {
  loading(); actions.innerHTML = '';
  try {
    const all = groupOrders(await api.sellers.orders(me.id));
    const draw = () => {
      const rows = all.filter((o) => !ostatus || o.status === ostatus);
      $('#olist').innerHTML = rows.length ? rows.map((o) => {
        const ship = o.shipment_status, next = o.status === 'Confirmed' || o.status === 'Shipped' ? NEXT[ship || 'Pending'] : null, mine = o.items.reduce((n, i) => n + Number(i.subtotal), 0);
        return `<article class="seller-order"><div class="seller-order__head"><div><b>Order #${o.order_id}</b><div class="xsmall muted">${dateTime(o.order_date)}</div></div>${metroMini(o.status, ship)}
          <div class="grow right">${next ? `<button class="btn btn--sm btn--primary" data-ship="${o.order_id}" data-next="${next}">${icon('truck')} Mark ${next === 'Shipped' ? 'shipped' : next.toLowerCase()}</button>` : ''}</div></div>
          <div class="seller-order__body">${o.items.map((i) => `<div class="seller-order__item">${productImage(i, 'pimg--xs')}<span>${esc(displayName(i.product_name))}</span><span class="num muted">${i.quantity} × ${money(i.unit_price)}</span><b class="num">${money(i.subtotal)}</b></div>`).join('')}
          <div class="row row--between xsmall muted" style="margin-top:var(--s2)"><span>${o.tracking_number ? `${esc(o.carrier || 'Carrier')}, tracking ${esc(o.tracking_number)}` : o.status === 'Pending' ? 'The customer has not paid yet, so this order cannot ship.' : ''}</span><span>Your items: <b style="color:var(--ink)">${money(mine)}</b> of ${money(o.total_amount)}</span></div></div></article>`;
      }).join('') : `<div class="panel">${emptyState({ icon: 'truck', title: ostatus ? 'No orders in this tab' : 'No orders yet', text: ostatus ? 'Try another tab.' : 'Orders that include your products show up here.' })}</div>`;
    };
    main.innerHTML = `<div class="tabs" id="otabs" role="tablist" aria-label="Filter orders">${OSTAT.map(([s, l]) => `<button role="tab" data-s="${s}" aria-selected="${s === ostatus}">${l} <span class="muted">${s ? all.filter((o) => o.status === s).length : all.length}</span></button>`).join('')}</div>
      <div class="alert" style="margin-bottom:var(--s4)">${icon('info')}<span>Shipping updates apply to the whole order, including other sellers' items in it. Only sellers with items in an order can update it.</span></div><div id="olist"></div>`;
    draw();
    $('#otabs').onclick = (e) => { const b = e.target.closest('[data-s]'); if (!b) return; ostatus = b.dataset.s; $$('#otabs button').forEach((x) => x.setAttribute('aria-selected', x === b)); draw(); };
    $('#olist').onclick = (e) => {
      const b = e.target.closest('[data-ship]'); if (!b) return; const id = Number(b.dataset.ship), next = b.dataset.next;
      const go = async (v = {}) => { await api.orders.shipment(id, { status: next, ...(v.carrier ? { carrier: v.carrier.trim() } : {}) }); toast(`Order #${id} marked ${next.toLowerCase()}.`, 'success'); orders(); };
      if (next === 'Shipped') formModal({ title: `Ship order #${id}`, submitLabel: 'Mark shipped', fields: [{ name: 'carrier', label: 'Carrier', placeholder: 'For example BlueDart or Delhivery', maxlength: 50, full: true, hint: 'Optional. A tracking number is generated by the database.' }], onSubmit: go });
      else confirmDialog({ title: `Mark order #${id} ${next.toLowerCase()}?`, message: 'The customer sees the new status on their order page straight away.', confirmLabel: `Mark ${next.toLowerCase()}` }).then((ok) => ok && go().catch(toastError));
    };
  } catch (e) { fail(e, orders); }
}

const routes = { dashboard, products, orders };
const go = () => routes[portal.route()]();
window.addEventListener('hashchange', go);
api.categories().then((c) => (cats = c)).catch(toastError);
go();
