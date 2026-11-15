import { esc } from './format.js';
import { icon } from './icons.js';
let stack;
const IC = { success: 'check-circle', error: 'x-circle', warn: 'alert', info: 'info' };
// msg is plain text; link = {href, label} adds an action link (e.g. "View cart").
export function toast(msg, type = 'info', ms = 4500, link) {
  if (!stack) { stack = document.createElement('div'); stack.className = 'toast-stack'; stack.setAttribute('role', 'status'); stack.setAttribute('aria-live', 'polite'); document.body.append(stack); }
  const t = document.createElement('div');
  t.className = `toast toast--${type}`;
  t.innerHTML = `${icon(IC[type] || 'info')}<span>${esc(msg)}${link ? ` <a href="${esc(link.href)}">${esc(link.label)}</a>` : ''}</span><button type="button" aria-label="Dismiss">${icon('x', 16)}</button>`;
  const close = () => t.remove();
  t.querySelector('button').onclick = close;
  stack.append(t);
  if (ms) setTimeout(close, ms);
}
export const toastError = (e) => toast(e?.message || String(e), 'error', 7000);
