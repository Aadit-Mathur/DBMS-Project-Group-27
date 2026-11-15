import { APP_NAME, API_BASE } from './config.js';
import { api } from './api.js';
import { session, customer, adminKey, cart, cached } from './state.js';
import { icon, logoMark } from './icons.js';
import { themeButton, initTheme } from './theme.js';
import { esc, int } from './format.js';

export const ROOT = (location.pathname.match(/\/(customer|seller|admin)\//) ? '../' : './');
export const url = (p) => ROOT + p;
const shop = (q = {}) => url('customer/shop.html') + (Object.keys(q).length ? '?' + new URLSearchParams(q) : '');
const logo = (sub = '') => `<a class="logo" href="${url('index.html')}" aria-label="${APP_NAME} home">${logoMark()}<span>${APP_NAME}${sub ? `<small>${sub}</small>` : ''}</span></a>`;
const firstName = (n) => esc(String(n || '').split(/\s+/)[0]);

export const loadCategories = () => cached('cats', 10 * 60 * 1000, () => api.categories());

export function signInUrl(role = 'customer', next = location.pathname.split('/').slice(-2).join('/') + location.search) {
  return url(`login.html?role=${role}&next=${encodeURIComponent(next)}`);
}
export function requireRole(role) {
  const s = session.get();
  if (!s || s.role !== role || (role === 'admin' && !adminKey.get())) { location.replace(signInUrl(role)); throw new Error('Not signed in'); }
  return s;
}
export function signOut(to = 'index.html') { session.clear(); location.href = url(to); }

// ================= storefront shell =================
function accountMenu() {
  const s = session.get();
  if (s?.role === 'customer') return `<div class="menu__who"><b>${esc(s.name)}</b><span>${esc(s.email || '')}</span></div>
    <a href="${url('customer/orders.html')}">${icon('package')} Your orders</a><a href="${url('customer/cart.html')}">${icon('cart')} Your cart</a>
    <hr><button type="button" data-signout>${icon('logout')} Sign out</button>`;
  if (s?.role === 'seller') return `<div class="menu__who"><b>${esc(s.name)}</b><span>Seller account</span></div>
    <a href="${url('seller/seller.html')}">${icon('store')} Seller hub</a><a href="${signInUrl('customer', 'customer/orders.html')}">${icon('user')} Sign in as a customer</a><hr><button type="button" data-signout>${icon('logout')} Sign out</button>`;
  if (s?.role === 'admin') return `<div class="menu__who"><b>Administrator</b><span>Admin key active this session</span></div>
    <a href="${url('admin/admin.html')}">${icon('dashboard')} Admin dashboard</a><a href="${signInUrl('customer', 'customer/orders.html')}">${icon('user')} Sign in as a customer</a><hr><button type="button" data-signout>${icon('logout')} Sign out</button>`;
  return `<a class="btn btn--cta btn--block" href="${signInUrl()}" style="justify-content:center;font-weight:700">Sign in</a>
    <p class="xsmall muted" style="margin:.5rem .4rem .6rem">Customers sign in with their email. There is no password in this demo.</p><hr>
    <a href="${signInUrl('seller', 'seller/seller.html')}">${icon('store')} Seller sign in</a><a href="${signInUrl('admin', 'admin/admin.html')}">${icon('dashboard')} Admin dashboard</a>`;
}

export function mountStore(active, { requireCustomer = false } = {}) {
  const me = requireCustomer ? requireRole('customer') : session.get();
  const qs = new URLSearchParams(location.search);
  const hello = me ? `Hello, ${firstName(me.name)}` : 'Hello, sign in';
  document.body.innerHTML = `<a class="skip" href="#main">Skip to content</a>
  <header class="hdr">
    <div class="container hdr__bar">${logo()}
      <form class="search" role="search" action="${shop()}" id="hsearch">
        <label class="sr-only" for="hcat">Search in</label><select id="hcat" name="category_id"><option value="">All categories</option></select>
        <label class="sr-only" for="hq">Search Bazaar</label><input id="hq" type="search" name="q" placeholder="Search for products, brands and more" autocomplete="off" value="${esc(active === 'shop' ? qs.get('q') || '' : '')}">
        <button type="submit" aria-label="Search">${icon('search')}</button></form>
      <div class="hdr__actions">
        <div class="menu" id="acct"><button type="button" class="hlink hlink--account" aria-haspopup="true" aria-expanded="false"><small>${hello}</small><b><span>Account</span>${icon('chev-d', 14)}</b></button><div class="menu__pop" role="menu">${accountMenu()}</div></div>
        <a class="hlink hlink--orders" href="${url('customer/orders.html')}"><small>Track</small><b>Orders</b></a>
        <a class="hlink hlink--cart" href="${url('customer/cart.html')}" aria-label="Cart">${icon('cart')}<span class="cart-count" id="cart-count" hidden>0</span><b>Cart</b></a>
      </div></div>
    <nav class="catbar" aria-label="Categories"><div class="container catbar__in">
      <button type="button" class="catbar__all" id="all-cats" aria-controls="drawer" aria-expanded="false">${icon('menu')} All</button>
      <div class="catbar__links" id="catlinks"></div>
      <a class="catbar__sell" href="${signInUrl('seller', 'seller/seller.html')}">Sell on ${APP_NAME}</a></div></nav>
  </header>
  <div class="drawer" id="drawer" aria-hidden="true"><div class="drawer__scrim" data-close-drawer></div>
    <div class="drawer__panel" role="dialog" aria-modal="true" aria-label="All categories"><div class="drawer__head"><span>${me ? `Hello, ${firstName(me.name)}` : 'Shop by category'}</span><button type="button" data-close-drawer aria-label="Close">${icon('x')}</button></div>
    <nav><h4>Shop by category</h4><div id="drawer-cats"></div><hr><h4>Your account</h4>
      <a href="${url('customer/orders.html')}">Your orders</a><a href="${url('customer/cart.html')}">Your cart</a>${me ? '<a href="#" data-signout>Sign out</a>' : `<a href="${signInUrl()}">Sign in</a>`}
      <hr><h4>Sell and manage</h4><a href="${signInUrl('seller', 'seller/seller.html')}">Seller hub</a><a href="${signInUrl('admin', 'admin/admin.html')}">Admin dashboard</a></nav></div></div>
  <main id="main" class="app-main" tabindex="-1"><div class="container page" id="page"></div></main>
  ${footer()}`;
  wireStore(active, qs);
  return document.getElementById('page');
}

function footer() {
  return `<footer class="ftr"><button type="button" class="ftr__top" id="totop">Back to top</button>
  <div class="container ftr__cols">
    <div><h4>Shop</h4><ul id="ftr-cats"></ul></div>
    <div><h4>Your account</h4><ul><li><a href="${signInUrl()}">Sign in</a></li><li><a href="${url('customer/orders.html')}">Your orders</a></li><li><a href="${url('customer/cart.html')}">Your cart</a></li><li><a href="${url('customer/shop.html')}">All products</a></li></ul></div>
    <div><h4>Sell on ${APP_NAME}</h4><ul><li><a href="${url('login.html?role=seller&mode=register')}">Register as a seller</a></li><li><a href="${signInUrl('seller', 'seller/seller.html')}">Seller hub</a></li><li><a href="${signInUrl('admin', 'admin/admin.html')}">Admin dashboard</a></li></ul></div>
    <div><h4>About this project</h4><ul><li>CS F212 Database Systems, Group 27</li><li>BITS Pilani, Hyderabad Campus</li><li><a href="${API_BASE || location.origin}/docs" target="_blank" rel="noopener">API documentation</a></li><li><a href="${url('credits.html')}">Photo credits</a></li></ul></div>
  </div>
  <div class="container ftr__bottom">${logo()}<span>Demo storefront over a PostgreSQL database. Prices in Indian rupees.</span>${themeButton('ftr__theme', true)}</div></footer>`;
}

function wireStore(active, qs) {
  initTheme();
  const sync = () => { const n = cart.count(), b = document.getElementById('cart-count'); if (!b) return; b.textContent = n > 99 ? '99+' : n; b.hidden = !n; };
  window.addEventListener('cartchange', sync); window.addEventListener('storage', sync); sync();
  document.addEventListener('click', (e) => { if (e.target.closest('[data-signout]')) { e.preventDefault(); signOut(); } });
  // account menu
  const menu = document.getElementById('acct'), mbtn = menu.querySelector('button');
  const setMenu = (o) => { menu.classList.toggle('open', o); mbtn.setAttribute('aria-expanded', o); };
  mbtn.onclick = (e) => { e.stopPropagation(); setMenu(!menu.classList.contains('open')); };
  menu.addEventListener('mouseenter', () => matchMedia('(hover:hover)').matches && setMenu(true));
  menu.addEventListener('mouseleave', () => matchMedia('(hover:hover)').matches && setMenu(false));
  document.addEventListener('click', (e) => { if (!menu.contains(e.target)) setMenu(false); });
  // drawer
  const dr = document.getElementById('drawer'), allb = document.getElementById('all-cats');
  const setDrawer = (o) => { dr.classList.toggle('open', o); dr.setAttribute('aria-hidden', !o); allb.setAttribute('aria-expanded', o); document.body.style.overflow = o ? 'hidden' : ''; if (o) dr.querySelector('[data-close-drawer]:not(.drawer__scrim)').focus(); else allb.focus({ preventScroll: true }); };
  allb.onclick = () => setDrawer(true);
  dr.addEventListener('click', (e) => { if (e.target.closest('[data-close-drawer]')) setDrawer(false); });
  document.addEventListener('keydown', (e) => { if (e.key === 'Escape') { if (dr.classList.contains('open')) setDrawer(false); setMenu(false); } });
  document.getElementById('totop').onclick = () => window.scrollTo({ top: 0, behavior: matchMedia('(prefers-reduced-motion: reduce)').matches ? 'auto' : 'smooth' });
  // search: drop empty params so URLs stay clean
  document.getElementById('hsearch').addEventListener('submit', (e) => {
    e.preventDefault(); const f = e.target, p = {};
    if (f.q.value.trim()) p.q = f.q.value.trim(); if (f.category_id.value) p.category_id = f.category_id.value;
    location.href = shop(p);
  });
  loadCategories().then((cats) => {
    const cur = active === 'shop' ? qs.get('category_id') : null;
    document.getElementById('hcat').insertAdjacentHTML('beforeend', cats.map((c) => `<option value="${c.category_id}" ${String(c.category_id) === cur ? 'selected' : ''}>${esc(c.category_name)}</option>`).join(''));
    const byCount = [...cats].sort((a, b) => b.active_products - a.active_products);
    document.getElementById('catlinks').innerHTML = byCount.map((c) => `<a href="${shop({ category_id: c.category_id })}" ${String(c.category_id) === cur ? 'aria-current="page"' : ''}>${esc(c.category_name)}</a>`).join('');
    document.getElementById('drawer-cats').innerHTML = cats.map((c) => `<a href="${shop({ category_id: c.category_id })}">${esc(c.category_name)}<span>${int(c.active_products)}</span></a>`).join('');
    document.getElementById('ftr-cats').innerHTML = byCount.slice(0, 5).map((c) => `<li><a href="${shop({ category_id: c.category_id })}">${esc(c.category_name)}</a></li>`).join('') + `<li><a href="#" data-open-drawer>All categories</a></li>`;
    document.querySelector('[data-open-drawer]').onclick = (e) => { e.preventDefault(); setDrawer(true); };
  }).catch(() => { document.getElementById('catlinks').innerHTML = `<a href="${shop()}">All products</a>`; });
}

// ================= seller / admin shell =================
export function mountPortal(role, tabs, title) {
  const s = requireRole(role);
  const tag = role === 'seller' ? 'Seller hub' : 'Admin';
  document.body.innerHTML = `<a class="skip" href="#main">Skip to content</a>
  <header class="portal-hdr"><div class="portal-hdr__in">
    <button class="btn btn--ghost btn--icon menu-btn on-shell" id="menu" aria-label="Open menu" aria-controls="side">${icon('menu')}</button>
    ${logo()}<span class="portal-hdr__tag">${tag}</span>
    <div class="portal-hdr__right">${themeButton('btn btn--ghost btn--icon on-shell')}
      <a class="hlink" href="${url('index.html')}">${icon('store')}<b>View store</b></a>
      <span class="hlink" aria-label="Signed in as ${esc(s.name)}"><span class="avatar" aria-hidden="true">${esc((s.name || '?')[0].toUpperCase())}</span><b class="hide-sm">${esc(s.name)}</b></span>
    </div></div></header>
  <div class="portal"><aside class="side" id="side" aria-label="${tag} navigation">
    <nav>${tabs.map((t) => `<a href="#${t.id}" data-tab="${t.id}">${icon(t.icon)}${esc(t.label)}</a>`).join('')}</nav>
    <div class="side__foot"><a href="${url('index.html')}">${icon('store')} Back to the store</a><button class="btn btn--block" id="signout">${icon('logout')} Sign out</button></div></aside>
  <div class="side-scrim" id="scrim"></div>
  <main id="main" class="portal-main" tabindex="-1"><div class="portal-title"><h1 id="ptitle">${esc(title)}</h1><div id="pactions" class="row"></div></div><div id="pbody"></div></main></div>`;
  const sb = document.getElementById('side'), sc = document.getElementById('scrim');
  const toggle = (o) => { sb.classList.toggle('open', o); sc.classList.toggle('open', o); };
  document.getElementById('menu').onclick = () => toggle(true); sc.onclick = () => toggle(false);
  document.getElementById('signout').onclick = () => signOut();
  const route = () => {
    const id = tabs.some((t) => t.id === location.hash.slice(1)) ? location.hash.slice(1) : tabs[0].id;
    document.querySelectorAll('[data-tab]').forEach((a) => (a.dataset.tab === id ? a.setAttribute('aria-current', 'page') : a.removeAttribute('aria-current')));
    document.getElementById('ptitle').textContent = tabs.find((t) => t.id === id).label; document.getElementById('pactions').innerHTML = ''; toggle(false);
    document.title = `${tabs.find((t) => t.id === id).label} · ${tag} · ${APP_NAME}`;
    return id;
  };
  initTheme();
  return { main: document.getElementById('pbody'), actions: document.getElementById('pactions'), route, session: s };
}
