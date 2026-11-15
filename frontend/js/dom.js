import { icon } from './icons.js';
import { esc } from './format.js';
export const $ = (s, r = document) => r.querySelector(s);
export const $$ = (s, r = document) => [...r.querySelectorAll(s)];

export function skeletonTiles(n = 8) {
  return Array.from({ length: n }, () => `<div class="tile" aria-hidden="true"><div class="skeleton" style="aspect-ratio:1"></div><div class="tile__body"><div class="skeleton" style="height:13px"></div><div class="skeleton" style="height:13px;width:70%"></div><div class="skeleton" style="height:22px;width:45%;margin-top:6px"></div><div class="skeleton" style="height:32px;margin-top:10px"></div></div></div>`).join('');
}
export const skeletonCards = skeletonTiles;
export const skeletonRows = (n = 5) => `<div class="stack" aria-busy="true">${Array.from({ length: n }, () => '<div class="skeleton" style="height:48px"></div>').join('')}</div>`;
export const emptyState = ({ icon: ic = 'package', title, text = '', action = '' }) =>
  `<div class="empty"><div class="empty__art">${icon(ic)}</div><h3>${esc(title)}</h3>${text ? `<p>${esc(text)}</p>` : ''}${action}</div>`;
export const errorState = (msg) =>
  `<div class="empty empty--error" role="alert"><div class="empty__art">${icon('alert')}</div><h3>This page could not load</h3><p>${esc(msg)}</p><button class="btn" data-retry>${icon('refresh')} Try again</button></div>`;

// Run async fn while the button shows a spinner.
export async function busy(btn, fn) {
  if (btn) btn.classList.add('is-loading');
  try { return await fn(); } finally { if (btn) btn.classList.remove('is-loading'); }
}

const VALIDITY = (el, label) => {
  const v = el.validity;
  if (v.valueMissing) return `Enter the ${label.toLowerCase()}.`;
  if (v.typeMismatch) return el.type === 'email' ? 'Enter an email address like name@example.in.' : 'Enter a valid value.';
  if (v.rangeUnderflow) return `${label} must be at least ${el.min}.`;
  if (v.rangeOverflow) return `${label} must be at most ${el.max}.`;
  if (v.stepMismatch) return `${label} must be a whole number.`;
  if (v.patternMismatch) return el.dataset.msg || `${label} has an invalid format.`;
  if (v.tooShort) return `${label} needs at least ${el.minLength} characters.`;
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
