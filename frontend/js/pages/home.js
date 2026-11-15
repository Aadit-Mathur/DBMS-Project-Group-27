import { api } from '../api.js';
import { mountStore, loadCategories, signInUrl } from '../layout.js';
import { esc, int, price, typeImage, typeSrc, CATEGORY_TYPE } from '../format.js';
import { mini, rail, wireRails, shopUrl } from '../components.js';
import { icon } from '../icons.js';
import { errorState } from '../dom.js';

const page = mountStore('home');
document.title = 'Bazaar: groceries, home, fashion and electronics from Indian sellers';

// Banner slides: one per category, each with a real "from" price (search results are sorted by price).
const SLIDES = [
  { cat: 'Kitchen Appliances', type: 'Air Fryer 6L', title: 'Kitchen appliances for every counter', text: 'Air fryers, mixer grinders, OTGs and kettles from sellers across India.', bg: '#0b3a47' },
  { cat: 'Grocery & Food', type: 'Basmati Rice 5kg', title: 'Stock up the pantry', text: 'Atta, rice, dal, tea and filter coffee in family-size packs.', bg: '#5b2a0f' },
  { cat: 'Travel & Luggage', type: 'Cabin Trolley Bag', title: 'Packed and ready to go', text: 'Trolleys, backpacks, duffles and travel kits for the next trip.', bg: '#1e3d2a' },
];
// "Shop the category" panels: four product types each, linked to a filtered search.
const QUADS = [
  { title: 'Upgrade your kitchen', cat: 'Kitchen Appliances', items: [['Air Fryer 4L', 'Air fryers', 'Air Fryer'], ['Mixer Grinder 750W', 'Mixer grinders', 'Mixer Grinder'], ['Electric Kettle 1.5L', 'Kettles', 'Kettle'], ['OTG 30L', 'OTG ovens', 'OTG']] },
  { title: 'Pantry staples', cat: 'Grocery & Food', items: [['Sona Masoori Rice 5kg', 'Rice', 'Rice'], ['Toor Dal 1kg', 'Dals', 'Dal'], ['Filter Coffee 500g', 'Coffee and tea', 'Coffee'], ['Mixed Nuts 500g', 'Dry fruits', 'Nuts']] },
  { title: 'Work and study', cat: 'Computers & Laptops', items: [['14-inch Business Laptop', 'Laptops', 'Laptop'], ['27-inch QHD Monitor', 'Monitors', 'Monitor'], ['Mechanical Keyboard', 'Keyboards', 'Keyboard'], ['Office Chair', 'Office chairs', 'Office Chair']] },
  { title: 'Pack for the trip', cat: 'Travel & Luggage', items: [['Medium Trolley Bag', 'Trolley bags', 'Trolley'], ['Laptop Backpack', 'Backpacks', 'Backpack'], ['Travel Neck Pillow', 'Neck pillows', 'Pillow'], ['Packing Cube Set', 'Packing cubes', 'Packing Cube']] },
];
const SHELVES = [
  { title: 'Everyday buys under ₹499', params: { max_price: 499, in_stock_only: true, limit: 60 }, more: { max_price: 499 } },
  { title: 'Best of electronics', cat: 'Electronics' },
  { title: 'Clothing for the whole family', cat: 'Clothing' },
  { title: 'Home and kitchen essentials', cat: 'Home & Kitchen' },
];

page.innerHTML = `<h1 class="sr-only">Bazaar home</h1>
  <section class="hero" aria-roledescription="carousel" aria-label="Featured categories" id="hero"><div class="skeleton" style="height:100%;border-radius:0"></div></section>
  <div class="quads" id="quads"></div>
  <div id="shelves"></div>
  <section class="shelf"><div class="shelf__head"><h2>Shop by category</h2><a href="${shopUrl()}">See all products</a></div><div class="catgrid" id="catgrid"></div></section>
  <section class="sellband"><div class="sellband__copy"><h2>Sell on Bazaar</h2>
    <p>List your products next to sellers from across India. Stock, low-stock alerts and shipping updates all run from the seller hub.</p>
    <ol><li>Register with your business name, email and phone</li><li>Add products with price, stock and a reorder level</li><li>Ship paid orders and mark them delivered</li></ol>
    <a class="btn btn--cta btn--lg" href="login.html?role=seller&mode=register">Register as a seller</a> <a class="btn btn--lg btn--on-dark" href="${signInUrl('seller', 'seller/seller.html')}">Seller sign in</a></div>
    <div class="sellband__art">${typeImage('Desk Organizer')}</div></section>`;

const byName = {};
function catLink(name, extra = {}) { const c = byName[name]; return shopUrl({ ...(c ? { category_id: c.category_id } : {}), ...extra }); }

async function hero() {
  const el = document.getElementById('hero');
  const from = await Promise.all(SLIDES.map((s) => byName[s.cat] ? api.products.search({ category_id: byName[s.cat].category_id, in_stock_only: true, limit: 1 }).then((r) => r[0]?.price).catch(() => null) : null));
  el.innerHTML = `<div class="hero__track" id="track">${SLIDES.map((s, i) => `<div class="slide" style="--slide-bg:${s.bg}" role="group" aria-roledescription="slide" aria-label="${i + 1} of ${SLIDES.length}" ${i ? 'aria-hidden="true"' : ''}>
      <div class="slide__copy"><h2>${esc(s.title)}</h2><p>${esc(s.text)}</p>${from[i] ? `<span class="slide__from">From <b>${price(from[i])}</b></span>` : ''}
      <a class="btn btn--cta btn--lg" href="${catLink(s.cat)}" ${i ? 'tabindex="-1"' : ''}>Shop ${esc(s.cat.toLowerCase())}</a></div>
      <div class="slide__art"><img src="${typeSrc(s.type)}" alt="" ${i ? 'loading="lazy"' : 'fetchpriority="high"'}></div></div>`).join('')}</div>
    <button class="hero__nav hero__nav--prev" type="button" aria-label="Previous slide">${icon('chev-l')}</button><button class="hero__nav hero__nav--next" type="button" aria-label="Next slide">${icon('chev-r')}</button>
    <div class="hero__dots">${SLIDES.map((_, i) => `<button type="button" aria-label="Show slide ${i + 1}" aria-current="${!i}"></button>`).join('')}</div>
    <button class="hero__pause" type="button" aria-label="Pause slides">${icon('pause')}</button>`;
  const track = el.querySelector('#track'), slides = [...el.querySelectorAll('.slide')], dots = [...el.querySelectorAll('.hero__dots button')], pause = el.querySelector('.hero__pause');
  let at = 0, timer = null, paused = matchMedia('(prefers-reduced-motion: reduce)').matches;
  const go = (n) => {
    at = (n + SLIDES.length) % SLIDES.length; track.style.transform = `translateX(-${at * 100}%)`;
    slides.forEach((s, i) => { s.setAttribute('aria-hidden', i !== at); s.querySelector('a').tabIndex = i === at ? 0 : -1; });
    dots.forEach((d, i) => d.setAttribute('aria-current', i === at));
  };
  const play = () => { clearInterval(timer); if (!paused) timer = setInterval(() => go(at + 1), 6000); };
  el.querySelector('.hero__nav--prev').onclick = () => { go(at - 1); play(); };
  el.querySelector('.hero__nav--next').onclick = () => { go(at + 1); play(); };
  dots.forEach((d, i) => (d.onclick = () => { go(i); play(); }));
  const syncPause = () => { pause.innerHTML = icon(paused ? 'play' : 'pause'); pause.setAttribute('aria-label', paused ? 'Play slides' : 'Pause slides'); };
  pause.onclick = () => { paused = !paused; syncPause(); play(); };
  el.addEventListener('mouseenter', () => clearInterval(timer)); el.addEventListener('mouseleave', play);
  el.addEventListener('focusin', () => clearInterval(timer)); el.addEventListener('focusout', play);
  syncPause(); play();
}

function quads() {
  document.getElementById('quads').innerHTML = QUADS.map((q) => `<section class="quad"><h2>${esc(q.title)}</h2><div class="quad__grid">${q.items.map(([type, label, query]) =>
    `<a href="${catLink(q.cat, { q: query })}">${typeImage(type)}<span>${esc(label)}</span></a>`).join('')}</div>
    <a class="quad__more" href="${catLink(q.cat)}">See all in ${esc(q.cat)}</a></section>`).join('');
}

// Spread a price-sorted list so the shelf is not only the cheapest items.
const spread = (rows, n = 14) => rows.length <= n ? rows : Array.from({ length: n }, (_, i) => rows[Math.floor(i * rows.length / n)]);
async function shelves() {
  const host = document.getElementById('shelves');
  host.innerHTML = SHELVES.map((s, i) => `<section class="shelf" id="sh${i}"><div class="shelf__head"><h2>${esc(s.title)}</h2></div>${rail(Array.from({ length: 6 }, () => '<div class="mini" aria-hidden="true"><div class="skeleton" style="aspect-ratio:1"></div><div class="skeleton" style="height:12px;margin-top:8px"></div><div class="skeleton" style="height:18px;width:50%"></div></div>').join(''))}</section>`).join('');
  await Promise.all(SHELVES.map(async (s, i) => {
    const sec = document.getElementById('sh' + i), cat = s.cat ? byName[s.cat] : null;
    try {
      const params = s.params || { category_id: cat?.category_id, in_stock_only: true, limit: 100 };
      let rows = await api.products.search(params);
      if (s.params) { const seen = new Set(); rows = rows.filter((p) => (seen.has(p.category_id + p.brand) ? false : seen.add(p.category_id + p.brand))); }
      const more = s.more ? shopUrl(s.more) : catLink(s.cat);
      sec.innerHTML = `<div class="shelf__head"><h2>${esc(s.title)}</h2><a href="${more}">See more</a></div>${rail(spread(rows).map(mini).join(''))}`;
    } catch { sec.remove(); }
  }));
  wireRails(host);
}

function catgrid(cats) {
  document.getElementById('catgrid').innerHTML = cats.map((c) => `<a class="cat" href="${shopUrl({ category_id: c.category_id })}">${typeImage(CATEGORY_TYPE[c.category_name] || '')}<span>${esc(c.category_name)}</span><small>${int(c.active_products)} products</small></a>`).join('');
}

try {
  const cats = await loadCategories();
  cats.forEach((c) => (byName[c.category_name] = c));
  quads(); catgrid(cats);
  await Promise.all([hero(), shelves()]);
} catch (e) {
  page.innerHTML = errorState(`${e.message}`);
  page.querySelector('[data-retry]').onclick = () => location.reload();
}
