# Bazaar – marketplace frontend (Group 27 DBMS project)

Plain HTML / CSS / vanilla JS (ES modules). **No build step.** Chart.js is the vendored `js/vendor/chart.umd.js`; the Figtree font from Google Fonts is the only CDN dependency (system fonts are the fallback).

The look follows the Indian general-marketplace convention (Flipkart, Amazon.in): a peacock header with search, a category bar, photo-led product tiles on a grey ground, a filter sidebar, a sticky buy box, and a marigold "Add to cart". Order progress is drawn as a metro line (Ordered, Paid, Shipped, In transit, Delivered).

## Run

```bash
# 1. backend (from the repo root); .env needs DATABASE_URL and ADMIN_API_KEY
uvicorn backend.app.main:app --reload            # http://127.0.0.1:8000

# 2. frontend (any static server)
cd frontend && python -m http.server 8080        # open http://127.0.0.1:8080
```

API base URL lives in `js/config.js` (`http://127.0.0.1:8000`; same-origin when served on port 8000). Override without editing: `localStorage.setItem('mk_api_base','https://host')`.

Demo identities (no passwords exist in the backend): customer `customer0001@example.in`, seller `seller0001@example.in`, admin key = `ADMIN_API_KEY` from `.env`.

## Pages

| Page | File | Who |
|---|---|---|
| Home: banner, category panels, product shelves, shop by category | `index.html`, `js/pages/home.js` | anyone |
| Sign in (customer, seller sign-in or registration, admin key) | `login.html`, `js/pages/login.js` | anyone |
| Search and filter results | `customer/shop.html` | anyone |
| Product page with buy box and similar products | `customer/product.html` | anyone |
| Cart (live stock and price check) | `customer/cart.html` | anyone; checkout needs sign-in |
| Checkout, orders, order detail with tracking | `customer/checkout.html`, `orders.html`, `order.html` | signed-in customer |
| Seller hub: dashboard, products, orders | `seller/seller.html` | signed-in seller |
| Admin dashboard: overview, operations | `admin/admin.html` | admin key |
| Photo credits | `credits.html` | anyone |

Shoppers can browse and fill a cart without signing in. The guest cart is merged into the customer's cart at sign-in.

## Structure

```
css/  tokens.css (design tokens, light + dark) · base.css · components.css · layout.css
js/   config.js · api.js (fetch wrapper, error mapping, seller/admin headers) · state.js (session, carts, cache)
      layout.js (store header, category bar, drawer, footer; seller/admin portal shell) · components.js (tiles, rails, metro line)
      format.js (money, dates, badges, product photos) · images.js (product type -> photo) · credits.js (photo attribution)
      theme.js · toast.js · modal.js · dom.js · icons.js · pages/home.js · pages/login.js · pages/credits.js
img/products/   one photo per product type (195 files)
```

## Feature → endpoint map

| UI | Endpoint(s) |
|---|---|
| Customer sign-in | `GET /customers?email=` |
| Home shelves, banner "from" prices, search, filters, load more | `GET /products?q&category_id&min_price&max_price&in_stock_only&limit&offset`, `GET /categories` |
| Product page, cart refresh | `GET /products/{id}` (a 404 marks a cart item as removed) |
| Delivery address in the buy box, checkout | `GET /customers/{id}/addresses`, `POST /orders` |
| Pay (incl. retry after decline) | `POST /orders/{id}/payment` |
| Order history, order detail and tracking | `GET /customers/{id}/orders?status&limit&offset`, `GET /orders/{id}` |
| Cancel order (refund if paid) | `POST /orders/{id}/cancel` |
| Seller sign-in / register | `GET /sellers?email=`, `POST /sellers` |
| Seller dashboard, low stock, products, orders | `GET /sellers/{id}/dashboard`, `/low-stock`, `/products?include_inactive`, `/orders`, `POST /sellers/{id}/products` (all send `X-Seller-Id`) |
| Edit / restock / delist / relist | `PATCH /products/{id}`, `POST /products/{id}/restock`, `DELETE /products/{id}` (204 deleted, 200 delisted), `POST /products/{id}/relist` (send `X-Seller-Id`) |
| Shipment update | `POST /orders/{id}/shipment` (seller with items in the order, `X-Seller-Id`; or `X-Admin-Key`) |
| Admin overview | `GET /admin/overview, summary, revenue-trend, orders-by-status, sales-by-category, top-products` (send `X-Admin-Key`) |
| Admin operations | `GET /admin/top-sellers, payments, shipments, low-stock, new-customers`, `POST /orders/expire-unpaid` (admin key) |

## Not available (no backend endpoint)

- **Customer registration** and **adding a delivery address**: only existing customers and addresses can be used; checkout explains this when no address exists.
- Sorting other than by price (the backend always sorts search results by price, low to high), ratings, reviews, discounts and delivery dates. None exist in the data, so none are shown.

## Product photos

The database stores no product images. Each of the 195 product types (for example "Gel Pen Pack", "OTG 30L") is shown with one openly licensed photo from Wikimedia Commons or Openverse, saved in `img/products/`. Products are matched to a photo by their name ("Brand Product type (Seller)"). The photos represent the kind of product, not the seller's own item; the product page says so and links the credit. Every photo's author and licence is listed in `js/credits.js` and on `credits.html`.

## Notes

- Shipment updates act on the whole order (backend `advance_shipment`), even if it contains other sellers' items; the seller hub says so.
- Payment uses the backend's simulated gateway; the pay dialog exposes its result (approve, decline, outage) for demos.
- There is no real authentication: customers and sellers are identified by email, the seller id travels in `X-Seller-Id`, and the admin key is kept in `sessionStorage` for the tab.
