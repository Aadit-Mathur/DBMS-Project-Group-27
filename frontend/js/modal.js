import { esc } from './format.js';
import { icon } from './icons.js';
import { validateForm, clearErrorOnInput, busy } from './dom.js';
import { toastError } from './toast.js';

// Native <dialog>: focus trap, Esc to close and inert background come from the browser.
export function openModal({ title, body = '', footer = '', wide = false, onClose } = {}) {
  const d = document.createElement('dialog');
  d.className = 'modal' + (wide ? ' modal--wide' : '');
  d.setAttribute('aria-labelledby', 'm-title');
  d.innerHTML = `<div class="modal__head"><h3 id="m-title">${esc(title)}</h3><button type="button" class="btn btn--ghost btn--icon" aria-label="Close" data-close>${icon('x')}</button></div><div class="modal__body"></div>${footer ? '<div class="modal__foot"></div>' : ''}`;
  const bodyEl = d.querySelector('.modal__body');
  typeof body === 'string' ? (bodyEl.innerHTML = body) : bodyEl.append(body);
  if (footer) typeof footer === 'string' ? (d.querySelector('.modal__foot').innerHTML = footer) : d.querySelector('.modal__foot').append(footer);
  d.addEventListener('click', (e) => { if (e.target === d || e.target.closest('[data-close]')) d.close(); });
  d.addEventListener('close', () => { d.remove(); onClose?.(); });
  document.body.append(d); d.showModal();
  return { el: d, body: bodyEl, close: () => d.close() };
}

export function confirmDialog({ title, message, confirmLabel = 'Confirm', danger = false }) {
  return new Promise((resolve) => {
    let ok = false;
    const m = openModal({ title, body: `<p>${esc(message)}</p>`, footer: `<button class="btn" data-close>Cancel</button><button class="btn ${danger ? 'btn--danger-solid' : 'btn--primary'}" data-ok>${esc(confirmLabel)}</button>`, onClose: () => resolve(ok) });
    m.el.querySelector('[data-ok]').onclick = () => { ok = true; m.close(); };
    m.el.querySelector('[data-ok]').focus();
  });
}

function fieldHtml(f) {
  const id = 'f-' + f.name, a = (k, v) => (v !== undefined && v !== '' && v !== false ? ` ${k}="${esc(v === true ? '' : v)}"` : '');
  const common = `id="${id}" name="${f.name}"${a('required', f.required)}${a('placeholder', f.placeholder)}${a('autocomplete', f.autocomplete || 'off')}`;
  let ctl;
  if (f.type === 'select') ctl = `<select class="select" ${common}>${f.options.map((o) => `<option value="${esc(o.value)}"${String(o.value) === String(f.value ?? '') ? ' selected' : ''}>${esc(o.label)}</option>`).join('')}</select>`;
  else if (f.type === 'textarea') ctl = `<textarea class="textarea" ${common}${a('maxlength', f.maxlength)}>${esc(f.value ?? '')}</textarea>`;
  else ctl = `<input class="input" type="${f.type || 'text'}" ${common}${a('value', f.value)}${a('min', f.min)}${a('max', f.max)}${a('step', f.step)}${a('pattern', f.pattern)}${a('data-msg', f.patternMsg)}${a('minlength', f.minlength)}${a('maxlength', f.maxlength)}>`;
  return `<div class="field${f.full ? ' full' : ''}"><label for="${id}">${esc(f.label)}${f.required ? ' <span aria-hidden="true">*</span>' : ''}</label>${ctl}${f.hint ? `<span class="hint">${esc(f.hint)}</span>` : ''}<span class="error" role="alert"></span></div>`;
}

// Generic validated form in a modal. onSubmit(values) may throw an ApiError; it is shown as a toast and the modal stays open.
export function formModal({ title, intro = '', fields, submitLabel = 'Save', danger = false, onSubmit, wide = false }) {
  const form = document.createElement('form');
  form.noValidate = true;
  form.innerHTML = `${intro ? `<p class="muted">${intro}</p>` : ''}<div class="form-grid">${fields.map(fieldHtml).join('')}</div><button type="submit" hidden></button>`;
  clearErrorOnInput(form);
  const foot = document.createElement('div'); foot.style.display = 'contents';
  foot.innerHTML = `<button type="button" class="btn" data-close>Cancel</button><button type="button" class="btn ${danger ? 'btn--danger-solid' : 'btn--primary'}" data-submit>${esc(submitLabel)}</button>`;
  const m = openModal({ title, body: form, footer: foot, wide });
  const submit = async () => {
    if (!validateForm(form)) return;
    const values = Object.fromEntries(new FormData(form));
    try { await busy(foot.querySelector('[data-submit]'), () => onSubmit(values, m)); m.close(); } catch (e) { toastError(e); }
  };
  foot.querySelector('[data-submit]').onclick = submit;
  form.addEventListener('submit', (e) => { e.preventDefault(); submit(); });
  form.querySelector('input,select,textarea')?.focus();
  return m;
}
