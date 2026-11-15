import { api } from '../js/api.js';
import { mountStore } from '../js/layout.js';
import { cart } from '../js/state.js';
import { art, money, esc, stockBadge } from '../js/format.js';
import { skeletonCards, emptyState, errorState, $, $$ } from '../js/dom.js';
import { toast, toastError } from '../js/toast.js';
import { icon } from '../js/icons.js';

const main = mountStore('shop'), LIMIT = 12;
const qs = new URLSearchParams(location.search);
const f = { q: qs.get('q') || '', category_id: qs.get('category_id') || '', min_price: qs.get('min_price') || '', max_price: qs.get('max_price') || '', in_stock_only: qs.get('in_stock_only') === 'true' };
let offset = 0, shown = [], cats = [];

main.innerHTML = `<div class="page-head"><div><h1>Shop</h1><p class="muted" id="sub">Everything from our sellers.</p></div></div>
<div class="chips" id="chips" role="group" aria-label="Categories" style="margin-bottom:var(--s4)"></div>
<div class="shop-layout"><aside class="card filters" aria-label="Filters"><form id="ff" novalidate>
  <div class="field"><label for="q">Search</label><input class="input" id="q" name="q" type="search" placeholder="Name or brand"></div>
  <div class="form-grid" style="grid-template-columns:1fr 1fr"><div class="field"><label for="min">Min ₹</label><input class="input" id="min" name="min_price" type="number" min="0" step="any"><span class="error"></span></div>
  <div class="field"><label for="max">Max ₹</label><input class="input" id="max" name="max_price" type="number" min="0" step="any"><span class="error"></span></div></div>
  <label class="check" style="margin-bottom:var(--s4)"><input type="checkbox" name="in_stock_only" id="stock"> In stock only</label>
  <div class="row"><button class="btn btn--primary grow" type="submit">Apply</button><button class="btn" type="button" id="reset">Reset</button></div></form></aside>
<section><div id="grid" class="grid-products" aria-live="polite"></div><div id="more" class="row" style="justify-content:center;margin-top:var(--s5)"></div></section></div>`;
const grid = $('#grid'), more = $('#more'), form = $('#ff');

const syncForm = () => { form.q.value = f.q; form.min_price.value = f.min_price; form.max_price.value = f.max_price; form.in_stock_only.checked = f.in_stock_only; };
const syncUrl = () => { const p = new URLSearchParams(); for (const [k, v] of Object.entries(f)) if (v) p.set(k, v); history.replaceState(null, '', '?' + p); };
function chips() {
  $('#chips').innerHTML = [{ category_id: '', category_name: 'All' }, ...cats].map((c) => `<button class="chip" aria-pressed="${String(c.category_id) === String(f.category_id)}" data-cat="${c.category_id}">${esc(c.category_name)}${c.active_products != null ? ` <span class="muted">${c.active_products}</span>` : ''}</button>`).join('');
}
const card = (p) => `<article class="card card--hover pcard"><a href="product.html?id=${p.product_id}" aria-label="${esc(p.product_name)}">${art(p.product_name, p.category_id)}</a>
  <div class="pcard__body"><span class="pcard__cat">${esc(p.category_name)}</span><h3 class="pcard__name"><a href="product.html?id=${p.product_id}">${esc(p.product_name)}</a></h3>
  <span class="muted small">${p.brand ? esc(p.brand) + ' · ' : ''}Sold by ${esc(p.seller_name)}</span>
  <div>${stockBadge(undefined, undefined, p.in_stock)}</div>
  <div class="pcard__foot"><span class="price">${money(p.price)}</span><button class="btn btn--primary btn--sm" data-add="${p.product_id}" ${p.in_stock ? '' : 'disabled'}>${icon('plus')} Add</button></div></div></article>`;

async function load(reset = true) {
  if (reset) { offset = 0; shown = []; grid.innerHTML = skeletonCards(8); more.innerHTML = ''; }
  try {
    const rows = await api.products.search({ q: f.q.trim(), category_id: f.category_id, min_price: f.min_price, max_price: f.max_price, in_stock_only: f.in_stock_only || undefined, limit: LIMIT, offset });
    shown.push(...rows); offset += rows.length;
    if (!shown.length) { grid.innerHTML = `<div style="grid-column:1/-1">${emptyState({ icon: 'search', title: 'No products found', text: 'Try different keywords or clear the filters.', action: '<button class="btn" id="clear">Clear filters</button>' })}</div>`; $('#clear').onclick = reset_; }
    else grid.innerHTML = shown.map(card).join('');
    $('#sub').textContent = shown.length ? `Showing ${shown.length}${rows.length === LIMIT ? '+' : ''} product${shown.length > 1 ? 's' : ''}, sorted by price` : 'Nothing matches';
    more.innerHTML = rows.length === LIMIT ? '<button class="btn" id="loadmore">Load more</button>' : '';
    const lm = $('#loadmore'); if (lm) lm.onclick = async () => { lm.classList.add('is-loading'); await load(false); };
  } catch (e) { grid.innerHTML = `<div style="grid-column:1/-1">${errorState(e.message)}</div>`; $('[data-retry]').onclick = () => load(); }
}
const reset_ = () => { Object.assign(f, { q: '', category_id: '', min_price: '', max_price: '', in_stock_only: false }); syncForm(); syncUrl(); chips(); load(); };
form.onsubmit = (e) => {
  e.preventDefault();
  const lo = form.min_price.value, hi = form.max_price.value;
  if (lo && hi && Number(lo) > Number(hi)) { toast('Minimum price cannot be higher than maximum price.', 'warn'); return; }
  Object.assign(f, { q: form.q.value, min_price: lo, max_price: hi, in_stock_only: form.in_stock_only.checked }); syncUrl(); load();
};
$('#reset').onclick = reset_;
main.addEventListener('click', (e) => {
  const c = e.target.closest('[data-cat]'); if (c) { f.category_id = c.dataset.cat; syncUrl(); chips(); load(); }
  const a = e.target.closest('[data-add]');
  if (a) { const p = shown.find((x) => x.product_id === Number(a.dataset.add)); cart.add({ product_id: p.product_id, product_name: p.product_name, price: p.price, brand: p.brand, category_id: p.category_id, category_name: p.category_name, seller_name: p.seller_name }, 1); toast(`Added “${p.product_name}” to your cart`, 'success', 2500); }
});
syncForm();
api.categories().then((c) => { cats = c; chips(); }).catch(toastError); chips();
load();
