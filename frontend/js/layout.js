import { APP_NAME } from './config.js';
import { session, adminKey, cart } from './state.js';
import { icon } from './icons.js';
import { themeButton, initTheme } from './theme.js';
import { esc } from './format.js';

const root = (location.pathname.match(/\/(customer|seller|admin)\//) ? '../' : './');
const logo = `<a class="brand" href="${root}index.html"><span class="brand__logo">${icon('bag', 20)}</span>${APP_NAME}</a>`;

export function requireRole(role) {
  const s = session.get();
  if (!s || s.role !== role || (role === 'admin' && !adminKey.get())) { location.replace(root + 'index.html?role=' + role); throw new Error('Not signed in'); }
  return s;
}
export function signOut() { session.clear(); location.href = root + 'index.html'; }
const initial = (s) => esc((s.name || '?')[0].toUpperCase());

export function mountStore(active) {
  const s = requireRole('customer');
  document.body.innerHTML = `<a class="skip" href="#main">Skip to content</a>
  <header class="site-header"><div class="container bar">${logo}
    <form class="search" role="search" action="shop.html">${icon('search')}<label class="sr-only" for="gs">Search products</label><input id="gs" class="input" type="search" name="q" placeholder="Search products or brands"></form>
    <nav class="nav" aria-label="Main"><a href="shop.html" ${active === 'shop' ? 'aria-current="page"' : ''}>Shop</a><a href="orders.html" ${active === 'orders' ? 'aria-current="page"' : ''}>My orders</a></nav>
    <div class="actions">${themeButton()}
      <a class="btn btn--ghost btn--icon cart-link" href="cart.html" aria-label="Cart">${icon('cart', 20)}<span class="cart-count" id="cart-count" hidden>0</span></a>
      <div class="userbox"><span class="avatar" aria-hidden="true">${initial(s)}</span><span class="uname">${esc(s.name)}</span><button class="btn btn--ghost btn--icon" id="signout" aria-label="Sign out" title="Sign out">${icon('logout')}</button></div></div></div></header>
  <main id="main" class="container page" tabindex="-1"></main>
  <footer class="site-footer"><div class="container">${APP_NAME} · Group 27 DBMS project</div></footer>`;
  const sync = () => { const n = cart.count(), b = document.getElementById('cart-count'); b.textContent = n > 99 ? '99+' : n; b.hidden = !n; };
  window.addEventListener('cartchange', sync); window.addEventListener('storage', sync); sync();
  document.getElementById('signout').onclick = signOut;
  const q = new URLSearchParams(location.search).get('q'); if (q && active === 'shop') document.getElementById('gs').value = q;
  initTheme();
  return document.getElementById('main');
}

// Sidebar layout for seller/admin. tabs: [{id, label, icon}] routed through location.hash.
export function mountPortal(role, tabs, title) {
  const s = requireRole(role);
  document.body.innerHTML = `<a class="skip" href="#main">Skip to content</a><div class="portal">
  <aside class="sidebar" id="sidebar" aria-label="${role} navigation">${logo}
    <nav>${tabs.map((t) => `<a href="#${t.id}" data-tab="${t.id}">${icon(t.icon)}${esc(t.label)}</a>`).join('')}</nav>
    <div class="foot"><div class="userbox"><span class="avatar" aria-hidden="true">${initial(s)}</span><div><b>${esc(s.name)}</b><div class="muted small">${esc(role)}</div></div></div>
    <button class="btn btn--block" id="signout">${icon('logout')} Sign out</button></div></aside>
  <div class="scrim" id="scrim"></div>
  <div><header class="topbar"><button class="btn btn--ghost btn--icon menu-btn" id="menu" aria-label="Open menu" aria-controls="sidebar">${icon('menu')}</button><h2 id="ptitle">${esc(title)}</h2>${themeButton()}</header>
  <main id="main" class="portal-content" tabindex="-1"></main></div></div>`;
  const sb = document.getElementById('sidebar'), sc = document.getElementById('scrim');
  const toggle = (o) => { sb.classList.toggle('open', o); sc.classList.toggle('open', o); };
  document.getElementById('menu').onclick = () => toggle(true); sc.onclick = () => toggle(false);
  document.getElementById('signout').onclick = signOut;
  const route = () => {
    const id = tabs.some((t) => t.id === location.hash.slice(1)) ? location.hash.slice(1) : tabs[0].id;
    document.querySelectorAll('[data-tab]').forEach((a) => (a.dataset.tab === id ? a.setAttribute('aria-current', 'page') : a.removeAttribute('aria-current')));
    document.getElementById('ptitle').textContent = tabs.find((t) => t.id === id).label; toggle(false);
    return id;
  };
  initTheme();
  return { main: document.getElementById('main'), route, session: s };
}
