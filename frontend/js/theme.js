import { icon } from './icons.js';
const KEY = 'mk_theme';
const saved = () => { try { return localStorage.getItem(KEY); } catch { return null; } };
export const currentTheme = () => document.documentElement.dataset.theme || 'light';
export function setTheme(t) {
  document.documentElement.dataset.theme = t; try { localStorage.setItem(KEY, t); } catch { /* blocked */ }
  window.dispatchEvent(new CustomEvent('themechange', { detail: t }));
  document.querySelectorAll('[data-theme-toggle]').forEach(syncBtn);
}
function syncBtn(b) {
  const dark = currentTheme() === 'dark', label = dark ? 'Light mode' : 'Dark mode';
  b.innerHTML = icon(dark ? 'sun' : 'moon') + (b.hasAttribute('data-labelled') ? `<span>${label}</span>` : '');
  b.setAttribute('aria-label', dark ? 'Switch to light mode' : 'Switch to dark mode');
  b.title = b.getAttribute('aria-label');
}
export function themeButton(cls = 'btn btn--ghost btn--icon', labelled = false) { return `<button type="button" class="${cls}" data-theme-toggle ${labelled ? 'data-labelled' : ''}></button>`; }
let bound = false;
export function initTheme() {
  document.documentElement.dataset.theme = saved() || (matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'light');
  if (!bound) { bound = true; document.addEventListener('click', (e) => { if (e.target.closest('[data-theme-toggle]')) setTheme(currentTheme() === 'dark' ? 'light' : 'dark'); }); }
  document.querySelectorAll('[data-theme-toggle]').forEach(syncBtn);
}
