import { icon } from './icons.js';
const KEY = 'mk_theme';
export const currentTheme = () => document.documentElement.dataset.theme || 'light';
export function setTheme(t) {
  document.documentElement.dataset.theme = t; localStorage.setItem(KEY, t);
  window.dispatchEvent(new CustomEvent('themechange', { detail: t }));
  document.querySelectorAll('[data-theme-toggle]').forEach(syncBtn);
}
function syncBtn(b) {
  const dark = currentTheme() === 'dark';
  b.innerHTML = icon(dark ? 'sun' : 'moon');
  b.setAttribute('aria-label', dark ? 'Switch to light mode' : 'Switch to dark mode');
  b.title = b.getAttribute('aria-label');
}
export function themeButton() { return `<button type="button" class="btn btn--ghost btn--icon" data-theme-toggle></button>`; }
export function initTheme() {
  const saved = localStorage.getItem(KEY);
  document.documentElement.dataset.theme = saved || (matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'light');
  document.addEventListener('click', (e) => { if (e.target.closest('[data-theme-toggle]')) setTheme(currentTheme() === 'dark' ? 'light' : 'dark'); });
  document.querySelectorAll('[data-theme-toggle]').forEach(syncBtn);
}
