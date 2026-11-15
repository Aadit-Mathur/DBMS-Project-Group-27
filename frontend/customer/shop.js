import { api } from '../js/api.js';
import { mountStore, loadCategories } from '../js/layout.js';
import { esc, int, moneyShort } from '../js/format.js';
import { skeletonTiles, emptyState, errorState, $ } from '../js/dom.js';
import { toast, toastError } from '../js/toast.js';
import { icon } from '../js/icons.js';
import { tile, addToCart, shopUrl } from '../js/components.js';

const page = mountStore('shop'), LIMIT = 24;
const qs = new URLSearchParams(location.search);
const f = { q: qs.get('q') || '', category_id: qs.get('category_id') || '', min_price: qs.get('min_price') || '', max_price: qs.get('max_price') || '', in_stock_only: qs.get('in_stock_only') === 'true' };
const RANGES = [['', 499, 'Under ₹500'], [500, 999, '₹500 to ₹999'], [1000, 4999, '₹1,000 to ₹4,999'], [5000, 19999, '₹5,000 to ₹19,999'], [20000, '', '₹20,000 and above']];
let offset = 0, shown = [], cats = [];

page.innerHTML = `<nav aria-label="Breadcrumb"><ol class="crumbs" id="crumbs"></ol></nav>
<div class="filters-scrim" id="fscrim"></div>
<div class="shop" style="margin-top:0">
  <aside class="filters" id="filters" aria-label="Filters"><form id="ff" novalidate>
    <div class="filters__head"><h2>Filters</h2><button class="btn btn--link small" type="button" id="reset">Clear all</button></div>
    <div class="fgroup"><h3>Category</h3><ul class="fcats" id="fcats"></ul></div>
    <div class="fgroup"><h3>Price</h3>
      <div class="fprice"><label class="sr-only" for="min">Minimum price in rupees</label><input class="input" id="min" name="min_price" type="number" min="0" step="1" placeholder="Min ₹" inputmode="numeric">
        <span class="muted small">to</span><label class="sr-only" for="max">Maximum price in rupees</label><input class="input" id="max" name="max_price" type="number" min="0" step="1" placeholder="Max ₹" inputmode="numeric"></div>
      <button class="btn btn--sm btn--block" type="submit" style="margin-top:var(--s2)">Apply price</button>
      <div class="franges" id="ranges">${RANGES.map(([a, b, l]) => `<button type="button" data-min="${a}" data-max="${b}">${l}</button>`).join('')}</div></div>
    <div class="fgroup"><h3>Availability</h3><label class="check"><input type="checkbox" name="in_stock_only" id="stock"> Hide out-of-stock items</label></div>
    <div class="fgroup"><h3>Keyword</h3><label class="sr-only" for="q">Keyword</label><input class="input" id="q" name="q" type="search" placeholder="Name or brand"></div>
  </form></aside>
  <section aria-labelledby="rtitle">
    <div class="results__bar"><div class="row"><button class="btn btn--sm filters-toggle" type="button" id="fopen" aria-controls="filters">${icon('sliders')} Filters</button><h1 id="rtitle">Products</h1></div>
      <span class="results__sort">Sorted by <b>price, low to high</b></span></div>
    <div class="active-filters" id="active"></div>
    <div id="grid" class="grid" aria-live="polite" aria-busy="true"></div>
    <div id="more" class="more"></div>
  </section></div>`;
const grid = $('#grid'), more = $('#more'), form = $('#ff'), filters = $('#filters'), scrim = $('#fscrim');

const catName = (id) => cats.find((c) => String(c.category_id) === String(id))?.category_name;
const syncForm = () => { form.q.value = f.q; form.min_price.value = f.min_price; form.max_price.value = f.max_price; form.in_stock_only.checked = f.in_stock_only; };
const syncUrl = () => { const p = {}; for (const [k, v] of Object.entries(f)) if (v) p[k] = v; history.replaceState(null, '', shopUrl(p).split('/').pop()); };
const setFilters = (o) => { filters.classList.toggle('open', o); scrim.classList.toggle('open', o); };
$('#fopen').onclick = () => setFilters(true); scrim.onclick = () => setFilters(false);

function chrome() {
  const name = catName(f.category_id);
  $('#crumbs').innerHTML = `<li><a href="../index.html">Home</a></li>${name ? `<li><a href="shop.html">All products</a></li><li><span aria-current="page">${esc(name)}</span></li>` : '<li><span aria-current="page">All products</span></li>'}`;
  $('#fcats').innerHTML = [{ category_id: '', category_name: 'All categories', active_products: cats.reduce((n, c) => n + Number(c.active_products), 0) }, ...cats]
    .map((c) => `<li><a href="#" data-cat="${c.category_id}" aria-current="${String(c.category_id) === String(f.category_id)}">${esc(c.category_name)}<span>${int(c.active_products)}</span></a></li>`).join('');
  $$ranges();
  const chips = [];
  if (f.q) chips.push(['q', `“${f.q}”`]);
  if (name) chips.push(['category_id', name]);
  if (f.min_price || f.max_price) chips.push(['price', f.min_price && f.max_price ? `${moneyShort(f.min_price)} to ${moneyShort(f.max_price)}` : f.min_price ? `${moneyShort(f.min_price)} and above` : `Up to ${moneyShort(f.max_price)}`]);
  if (f.in_stock_only) chips.push(['in_stock_only', 'In stock only']);
  $('#active').innerHTML = chips.map(([k, l]) => `<button type="button" class="chip" aria-pressed="true" data-clear="${k}" aria-label="Remove filter ${esc(l)}">${esc(l)} ${icon('x')}</button>`).join('');
  document.title = `${f.q ? `${f.q} · ` : ''}${name || 'All products'} · Bazaar`;
}
function $$ranges() { document.querySelectorAll('#ranges button').forEach((b) => b.setAttribute('aria-pressed', String(b.dataset.min) === String(f.min_price) && String(b.dataset.max) === String(f.max_price))); }

function title(count, full) {
  const name = catName(f.category_id), where = name ? ` in ${esc(name)}` : '';
  const n = `${count}${full ? '+' : ''} result${count === 1 ? '' : 's'}`;
  $('#rtitle').innerHTML = f.q ? `${n} for <q>${esc(f.q)}</q>${where}` : `${name ? esc(name) : 'All products'} <span class="muted small" style="font-weight:500">(${n})</span>`;
}

async function load(reset = true) {
  if (reset) { offset = 0; shown = []; grid.innerHTML = skeletonTiles(8); more.innerHTML = ''; grid.setAttribute('aria-busy', 'true'); }
  try {
    const rows = await api.products.search({ q: f.q.trim(), category_id: f.category_id, min_price: f.min_price, max_price: f.max_price, in_stock_only: f.in_stock_only || undefined, limit: LIMIT, offset });
    shown.push(...rows); offset += rows.length;
    if (!shown.length) {
      grid.innerHTML = `<div style="grid-column:1/-1" class="panel">${emptyState({ icon: 'search', title: f.q ? `No results for “${f.q}”` : 'No products match these filters', text: 'Check the spelling, try a shorter word, or clear a filter.', action: '<button class="btn btn--primary" id="clear">Clear all filters</button>' })}</div>`;
      $('#clear').onclick = resetAll;
    } else grid.innerHTML = shown.map(tile).join('');
    title(shown.length, rows.length === LIMIT);
    more.innerHTML = rows.length === LIMIT ? `<button class="btn btn--lg" id="loadmore">Show more results</button>` : (shown.length > LIMIT ? '<p class="muted small">You have reached the end of the results.</p>' : '');
    const lm = $('#loadmore'); if (lm) lm.onclick = async () => { lm.classList.add('is-loading'); await load(false); };
  } catch (e) { grid.innerHTML = `<div style="grid-column:1/-1" class="panel">${errorState(e.message)}</div>`; $('[data-retry]').onclick = () => load(); }
  finally { grid.setAttribute('aria-busy', 'false'); }
}
const apply = () => { syncUrl(); chrome(); load(); setFilters(false); };
function resetAll() { Object.assign(f, { q: '', category_id: '', min_price: '', max_price: '', in_stock_only: false }); syncForm(); apply(); }

form.onsubmit = (e) => {
  e.preventDefault();
  const lo = form.min_price.value, hi = form.max_price.value;
  if ((lo && Number(lo) < 0) || (hi && Number(hi) < 0)) { toast('Prices cannot be negative.', 'warn'); return; }
  if (lo && hi && Number(lo) > Number(hi)) { toast('The minimum price is higher than the maximum. Swap them and try again.', 'warn'); form.min_price.focus(); return; }
  Object.assign(f, { q: form.q.value.trim(), min_price: lo, max_price: hi }); apply();
};
form.in_stock_only.onchange = () => { f.in_stock_only = form.in_stock_only.checked; apply(); };
form.q.addEventListener('search', () => { if (!form.q.value) { f.q = ''; apply(); } });
$('#reset').onclick = resetAll;
page.addEventListener('click', (e) => {
  const c = e.target.closest('[data-cat]'); if (c) { e.preventDefault(); f.category_id = c.dataset.cat; apply(); return; }
  const r = e.target.closest('#ranges [data-min]'); if (r) { const same = r.getAttribute('aria-pressed') === 'true'; f.min_price = same ? '' : r.dataset.min; f.max_price = same ? '' : r.dataset.max; syncForm(); apply(); return; }
  const x = e.target.closest('[data-clear]'); if (x) { const k = x.dataset.clear; if (k === 'price') { f.min_price = f.max_price = ''; } else f[k] = k === 'in_stock_only' ? false : ''; syncForm(); if (k === 'q') document.getElementById('hq').value = ''; apply(); return; }
  const a = e.target.closest('[data-add]'); if (a) { const p = shown.find((x) => x.product_id === Number(a.dataset.add)); if (p) addToCart(p); }
});
document.addEventListener('keydown', (e) => { if (e.key === 'Escape') setFilters(false); });

syncForm(); chrome(); load();
loadCategories().then((c) => { cats = c; chrome(); title(shown.length, shown.length && shown.length % LIMIT === 0); }).catch(toastError);
