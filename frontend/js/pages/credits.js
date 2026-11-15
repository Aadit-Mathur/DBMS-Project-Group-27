import { mountStore } from '../layout.js';
import { CREDITS } from '../credits.js';
import { esc } from '../format.js';

const page = mountStore('credits');
const rows = Object.entries(CREDITS).sort((a, b) => a[1].type.localeCompare(b[1].type));
// Wikimedia "Artist" fields arrive as HTML; show them as plain text.
const plain = (s) => { const d = document.createElement('div'); d.innerHTML = s || ''; return d.textContent.trim() || 'Unknown'; };
page.innerHTML = `<nav aria-label="Breadcrumb"><ol class="crumbs"><li><a href="index.html">Home</a></li><li><span aria-current="page">Photo credits</span></li></ol></nav>
<div class="page-head"><div><h1>Photo credits</h1><p class="muted" style="max-width:70ch">The project database stores no product images. Each product type is shown with one openly licensed photo found on Wikimedia Commons or Openverse. The photos represent the kind of product; they are not the sellers' own pictures. ${rows.length} photos, all used under the licence named below.</p></div></div>
<div class="table-wrap"><table class="table"><thead><tr><th>Photo</th><th>Used for</th><th>Original</th><th>Author</th><th>Licence</th></tr></thead><tbody>
${rows.map(([file, c]) => `<tr><td><span class="pimg pimg--xs"><img src="img/products/${esc(file)}" alt="" loading="lazy"></span></td><td><b>${esc(c.type)}</b></td><td><a href="${esc(c.source)}" target="_blank" rel="noopener">${esc(plain(c.title).replace(/^File:/, ''))}</a></td><td class="small">${esc(plain(c.creator))}</td><td class="small">${c.license_url ? `<a href="${esc(c.license_url)}" target="_blank" rel="noopener">${esc(c.license)}</a>` : esc(c.license)}</td></tr>`).join('')}
</tbody></table></div>`;
