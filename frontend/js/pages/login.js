import { api } from '../api.js';
import { mountStore, url } from '../layout.js';
import { session, adminKey, cart } from '../state.js';
import { icon } from '../icons.js';
import { validateForm, clearErrorOnInput, busy } from '../dom.js';
import { toast, toastError } from '../toast.js';
import { typeImage } from '../format.js';

const HOME = { customer: 'customer/orders.html', seller: 'seller/seller.html', admin: 'admin/admin.html' };
const DEMO = { customer: 'customer0001@example.in', seller: 'seller0001@example.in' };
const qs = new URLSearchParams(location.search);
let role = HOME[qs.get('role')] ? qs.get('role') : 'customer', mode = qs.get('mode') === 'register' ? 'register' : 'signin';
// Only same-site relative paths are accepted as the return address.
// The return address must be a page in the signed-in role's own folder.
const nextUrl = () => { const n = qs.get('next'); return n && n.startsWith(role + '/') && /^[a-z]+\/[\w.-]+\.html(\?[\w=&%.-]*)?$/i.test(n) ? n : HOME[role]; };

const page = mountStore('login');
document.title = 'Sign in · Bazaar';

const SIDE = {
  customer: ['Sign in to shop', 'Your cart, orders and delivery tracking in one place.', [['package', 'Follow every order from payment to your door'], ['cart', 'Items you added before signing in stay in your cart'], ['shield-check', 'Stock and prices are checked by the database at checkout']]],
  seller: ['Sell on Bazaar', 'Run your catalog from the seller hub.', [['store', 'List products with price, stock and reorder level'], ['alert', 'Low-stock alerts before you run out'], ['truck', 'Mark paid orders shipped, in transit and delivered']]],
  admin: ['Admin dashboard', 'Revenue, orders and catalog health for the whole marketplace.', [['trend', 'Revenue trend by day, week or month'], ['layers', 'Sales by category and top sellers'], ['clock', 'Clear out orders left unpaid']]],
};

function field(name, label, type, extra = '') {
  return `<div class="field"><label for="${name}">${label}</label><input class="input" id="${name}" name="${name}" type="${type}" required ${extra}><span class="error" role="alert"></span></div>`;
}
function formHtml() {
  if (role === 'customer') return `<h2>Sign in</h2><p class="muted small">Enter the email of your Bazaar customer account.</p>
    <form novalidate data-form>${field('email', 'Email', 'email', 'autocomplete="email" placeholder="name@example.in"')}<button class="btn btn--cta btn--block btn--lg" type="submit">Continue</button></form>
    <div class="auth__demo">This demo has no passwords or customer sign-up: any customer already in the database can sign in by email. <button type="button" class="btn--link btn" data-demo>Use ${DEMO.customer}</button></div>`;
  if (role === 'admin') return `<h2>Admin access</h2><p class="muted small">Enter the admin key. It is <code>ADMIN_API_KEY</code> in the server's <code>.env</code> file and is kept only for this browser tab.</p>
    <form novalidate data-form>${field('key', 'Admin key', 'password', 'autocomplete="current-password"')}<button class="btn btn--primary btn--block btn--lg" type="submit">Open dashboard</button></form>`;
  const reg = mode === 'register';
  return `<div class="tabs" role="tablist"><button role="tab" aria-selected="${!reg}" data-mode="signin">Seller sign in</button><button role="tab" aria-selected="${reg}" data-mode="register">Register as a seller</button></div>
    <form novalidate data-form>${reg
      ? `${field('name', 'Business name', 'text', 'minlength="2" autocomplete="organization"')}${field('email', 'Business email', 'email', 'autocomplete="email"')}${field('phone', 'Phone', 'tel', 'pattern="[0-9]{10,15}" inputmode="numeric" autocomplete="tel" data-msg="Enter 10 to 15 digits, numbers only."')}`
      : field('email', 'Seller email', 'email', 'autocomplete="email" placeholder="name@example.in"')}
      <button class="btn btn--primary btn--block btn--lg" type="submit">${reg ? 'Create seller account' : 'Continue to seller hub'}</button></form>
    ${reg ? '<p class="xsmall muted" style="margin-top:var(--s3)">Email and phone must be unique. The database rejects a phone that is not 10 to 15 digits.</p>' : `<div class="auth__demo">No password needed in this demo. <button type="button" class="btn--link btn" data-demo>Use ${DEMO.seller}</button></div>`}`;
}

function render() {
  const [title, sub, points] = SIDE[role];
  page.innerHTML = `<div class="auth"><aside class="auth__side"><h1>${title}</h1><p>${sub}</p><ul>${points.map(([ic, t]) => `<li>${icon(ic)}<span>${t}</span></li>`).join('')}</ul>
      <div class="auth__art">${['Electric Kettle 1.5L', "Women's Cotton Kurta", 'Over-Ear Wireless Headphones'].map((t) => typeImage(t)).join('')}</div></aside>
    <div class="auth__main"><div class="chips" role="group" aria-label="Sign in as" style="margin-bottom:var(--s5)">${[['customer', 'user', 'Customer'], ['seller', 'store', 'Seller'], ['admin', 'dashboard', 'Admin']].map(([r, ic, l]) => `<button type="button" class="chip" data-role="${r}" aria-pressed="${role === r}">${icon(ic)}${l}</button>`).join('')}</div>
      <div id="panel">${formHtml()}</div></div></div>`;
  const form = page.querySelector('[data-form]');
  clearErrorOnInput(form); form.querySelector('input')?.focus({ preventScroll: true });
  form.onsubmit = (e) => { e.preventDefault(); submit(form); };
  page.querySelector('[data-demo]')?.addEventListener('click', () => { form.email.value = DEMO[role]; submit(form); });
}

async function submit(form) {
  if (!validateForm(form)) return;
  const v = Object.fromEntries(new FormData(form)), btn = form.querySelector('[type=submit]');
  try {
    await busy(btn, async () => {
      if (role === 'customer') {
        const c = await api.customers.find(v.email.trim());
        session.set({ role, id: c.customer_id, name: c.name, email: c.email });
        const moved = cart.mergeGuestInto(c.customer_id);
        if (moved) toast(`${moved} item${moved > 1 ? 's' : ''} from before you signed in ${moved > 1 ? 'are' : 'is'} in your cart.`, 'info');
      } else if (role === 'seller') {
        const s = mode === 'register' ? await api.sellers.register({ name: v.name.trim(), email: v.email.trim(), phone: v.phone.trim() }) : await api.sellers.find(v.email.trim());
        if (mode === 'register') toast('Seller account created. Add your first product.', 'success');
        session.set({ role, id: s.seller_id, name: s.name, email: s.email });
      } else {
        adminKey.set(v.key);
        await api.admin.overview();
        session.set({ role, id: 0, name: 'Administrator' }); adminKey.set(v.key);
      }
    });
    location.href = url(nextUrl());
  } catch (e) {
    if (role === 'admin') toastError(e.status === 401 ? new Error('That admin key is not correct.') : e.status === 503 ? new Error('The server has no ADMIN_API_KEY set in its .env file.') : e);
    else if (e.status === 404) toastError(new Error(role === 'customer' ? 'No customer account uses that email. Check the spelling, or use the demo account.' : 'No seller account uses that email. Register as a seller to create one.'));
    else toastError(e);
  }
}

page.addEventListener('click', (e) => {
  const r = e.target.closest('[data-role]'); if (r) { role = r.dataset.role; mode = 'signin'; history.replaceState(null, '', `?role=${role}${qs.get('next') ? '&next=' + encodeURIComponent(qs.get('next')) : ''}`); render(); }
  const m = e.target.closest('[data-mode]'); if (m) { mode = m.dataset.mode; render(); }
});
render();
