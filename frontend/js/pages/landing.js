import { api } from '../api.js';
import { session, adminKey } from '../state.js';
import { icon } from '../icons.js';
import { themeButton, initTheme } from '../theme.js';
import { validateForm, clearErrorOnInput, busy } from '../dom.js';
import { toastError, toast } from '../toast.js';
import { esc } from '../format.js';
import { APP_NAME } from '../config.js';

const HOME = { customer: 'customer/shop.html', seller: 'seller/seller.html', admin: 'admin/admin.html' };
const ROLES = [
  { id: 'customer', ic: 'bag', title: 'Customer', text: 'Browse products, place orders and track shipments.' },
  { id: 'seller', ic: 'store', title: 'Seller', text: 'Manage your catalog, stock and fulfil orders.' },
  { id: 'admin', ic: 'shield', title: 'Admin', text: 'Sales analytics and operations dashboards.' },
];
const app = document.getElementById('app');
let role = new URLSearchParams(location.search).get('role'), mode = 'signin';
if (!HOME[role]) role = null;

function field(name, label, type, extra = '') {
  return `<div class="field"><label for="${name}">${label}</label><input class="input" id="${name}" name="${name}" type="${type}" required ${extra}><span class="error" role="alert"></span></div>`;
}
function formHtml() {
  if (role === 'customer') return `<h3>Customer sign in</h3><p class="muted small">There are no passwords in this project: enter the email of an existing customer (e.g. <code>customer0001@example.in</code>).</p>
    <form novalidate data-form>${field('email', 'Email', 'email', 'autocomplete="email" placeholder="you@example.com"')}<button class="btn btn--primary btn--block" type="submit">Continue</button></form>`;
  if (role === 'admin') return `<h3>Admin access</h3><p class="muted small">Enter the admin key (<code>ADMIN_API_KEY</code> from the server's .env).</p>
    <form novalidate data-form>${field('key', 'Admin key', 'password', 'autocomplete="current-password"')}<button class="btn btn--primary btn--block" type="submit">Open dashboard</button></form>`;
  const reg = mode === 'register';
  return `<div class="tabs" role="tablist" style="margin-bottom:var(--s4)"><button role="tab" aria-selected="${!reg}" data-mode="signin">Sign in</button><button role="tab" aria-selected="${reg}" data-mode="register">Register as seller</button></div>
    <form novalidate data-form>${reg
      ? `${field('name', 'Business name', 'text', 'minlength="2"')}${field('email', 'Email', 'email')}${field('phone', 'Phone', 'tel', 'pattern="[0-9]{10,15}" data-msg="Phone must be 10 to 15 digits (numbers only)."')}`
      : `<p class="muted small">Enter your registered seller email (e.g. <code>seller0001@example.in</code>).</p>${field('email', 'Email', 'email')}`}
      <button class="btn btn--primary btn--block" type="submit">${reg ? 'Create seller account' : 'Continue'}</button></form>`;
}
function render() {
  const s = session.get();
  app.innerHTML = `<div class="container"><header class="row row--between" style="padding:var(--s4) 0"><span class="brand"><span class="brand__logo">${icon('bag', 20)}</span>${APP_NAME}</span>${themeButton()}</header>
  <section class="hero"><h1>One marketplace for <span>buyers, sellers and admins</span></h1><p>Pick your role to continue.</p>
  ${s && HOME[s.role] ? `<p><a class="btn btn--primary" href="${HOME[s.role]}">Continue as ${esc(s.name)} (${s.role})</a></p>` : ''}</section>
  <div class="roles" role="group" aria-label="Choose a role">${ROLES.map((r) => `<button class="card card--hover role" data-role="${r.id}" aria-pressed="${role === r.id}">${icon(r.ic)}<h3>${r.title}</h3><p>${r.text}</p></button>`).join('')}</div>
  <div class="card signin ${role ? '' : 'hide'}" id="panel" aria-live="polite">${role ? formHtml() : ''}</div></div>`;
  initTheme();
  const panel = document.getElementById('panel'), form = panel.querySelector('[data-form]');
  if (form) { clearErrorOnInput(form); form.querySelector('input')?.focus({ preventScroll: true }); form.onsubmit = (e) => { e.preventDefault(); submit(form); }; }
}
async function submit(form) {
  if (!validateForm(form)) return;
  const v = Object.fromEntries(new FormData(form)), btn = form.querySelector('[type=submit]');
  try {
    await busy(btn, async () => {
      if (role === 'customer') { const c = await api.customers.find(v.email.trim()); session.set({ role, id: c.customer_id, name: c.name, email: c.email }); }
      else if (role === 'seller') {
        const s = mode === 'register' ? await api.sellers.register({ name: v.name.trim(), email: v.email.trim(), phone: v.phone.trim() }) : await api.sellers.find(v.email.trim());
        if (mode === 'register') toast('Seller account created. Welcome!', 'success');
        session.set({ role, id: s.seller_id, name: s.name, email: s.email });
      } else { adminKey.set(v.key); await api.admin.overview(); session.set({ role, id: 0, name: 'Administrator' }); adminKey.set(v.key); }
    });
    location.href = HOME[role];
  } catch (e) {
    if (e.status === 404) toastError(new Error(role === 'customer' ? 'No customer found with that email. The backend has no customer sign-up, so use an existing customer email.' : 'No seller found with that email. Use "Register as seller" to create one.'));
    else toastError(e.status === 401 ? new Error('That admin key is not correct.') : e);
  }
}
app.addEventListener('click', (e) => {
  const r = e.target.closest('[data-role]'); if (r) { role = r.dataset.role; mode = 'signin'; history.replaceState(null, '', '?role=' + role); render(); document.getElementById('panel').scrollIntoView({ behavior: 'smooth', block: 'center' }); }
  const m = e.target.closest('[data-mode]'); if (m) { mode = m.dataset.mode; render(); }
});
render();
