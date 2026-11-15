import { esc } from './format.js';
let stack;
export function toast(msg, type = 'info', ms = 4500) {
  if (!stack) { stack = document.createElement('div'); stack.className = 'toast-stack'; stack.setAttribute('role', 'status'); stack.setAttribute('aria-live', 'polite'); document.body.append(stack); }
  const t = document.createElement('div');
  t.className = `toast toast--${type}`;
  t.innerHTML = `<span>${esc(msg)}</span><button type="button" aria-label="Dismiss">×</button>`;
  const close = () => t.remove();
  t.querySelector('button').onclick = close;
  stack.append(t);
  if (ms) setTimeout(close, ms);
}
export const toastError = (e) => toast(e?.message || String(e), 'error', 7000);
