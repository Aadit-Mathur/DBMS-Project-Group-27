import { icon } from './icons.js';
import { esc } from './format.js';
export const $ = (s, r = document) => r.querySelector(s);
export const $$ = (s, r = document) => [...r.querySelectorAll(s)];

export function skeletonCards(n = 8) {
  return Array.from({ length: n }, () => `<div class="card pcard" aria-hidden="true"><div class="skeleton" style="aspect-ratio:4/3;border-radius:0"></div><div class="pcard__body"><div class="skeleton" style="height:12px;width:40%"></div><div class="skeleton" style="height:18px"></div><div class="skeleton" style="height:14px;width:60%"></div><div class="skeleton" style="height:36px;margin-top:12px"></div></div></div>`).join('');
}
export const skeletonRows = (n = 5) => `<div class="stack" aria-busy="true">${Array.from({ length: n }, () => '<div class="skeleton" style="height:44px"></div>').join('')}</div>`;
export const emptyState = ({ icon: ic = 'package', title, text = '', action = '' }) =>
  `<div class="empty">${icon(ic)}<h3>${esc(title)}</h3><p>${esc(text)}</p>${action}</div>`;
export const errorState = (msg) =>
  `<div class="empty empty--error" role="alert">${icon('alert')}<h3>Something went wrong</h3><p>${esc(msg)}</p><button class="btn" data-retry>${icon('refresh')} Try again</button></div>`;

// Run async fn while the button shows a spinner.
export async function busy(btn, fn) {
  if (btn) btn.classList.add('is-loading');
  try { return await fn(); } finally { if (btn) btn.classList.remove('is-loading'); }
}

const VALIDITY = (el, label) => {
  const v = el.validity;
  if (v.valueMissing) return `${label} is required.`;
  if (v.typeMismatch) return el.type === 'email' ? 'Enter a valid email address (name@example.com).' : 'Enter a valid value.';
  if (v.rangeUnderflow) return `${label} must be at least ${el.min}.`;
  if (v.rangeOverflow) return `${label} must be at most ${el.max}.`;
  if (v.stepMismatch) return `${label} must be a whole number.`;
  if (v.patternMismatch) return el.dataset.msg || `${label} has an invalid format.`;
  if (v.tooShort) return `${label} must be at least ${el.minLength} characters.`;
  return el.validationMessage;
};
// Friendly inline validation. Returns true when the form is valid.
export function validateForm(form) {
  let first = null;
  for (const el of form.elements) {
    if (!el.name || el.type === 'submit' || el.type === 'button' || el.type === 'radio') continue;
    const err = el.closest('.field')?.querySelector('.error');
    const label = el.closest('.field')?.querySelector('label')?.textContent.replace('*', '').trim() || el.name;
    if (!el.checkValidity()) {
      el.setAttribute('aria-invalid', 'true'); if (err) err.textContent = VALIDITY(el, label); first ||= el;
    } else { el.removeAttribute('aria-invalid'); if (err) err.textContent = ''; }
  }
  first?.focus();
  return !first;
}
export function clearErrorOnInput(root) {
  root.addEventListener('input', (e) => { const el = e.target; el.removeAttribute?.('aria-invalid'); const er = el.closest?.('.field')?.querySelector('.error'); if (er) er.textContent = ''; });
}
