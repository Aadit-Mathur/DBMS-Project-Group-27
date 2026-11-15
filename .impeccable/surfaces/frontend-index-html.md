---
version: 1
slug: "frontend-index-html"
primary_target: "frontend/index.html"
related_targets: ["frontend/customer/shop.html","frontend/customer/product.html","frontend/customer/cart.html","frontend/customer/checkout.html","frontend/customer/orders.html","frontend/customer/order.html","frontend/seller/seller.html","frontend/admin/admin.html"]
---

# Bazaar storefront and portals (frontend-v2)

Scope: every page in `frontend/` (home, sign-in, search/shop, product, cart, checkout, orders, order detail, seller portal, admin dashboard). Mode: Operate for shop, product, cart, checkout, orders, seller and admin; the home page is the store's front door (Persuade in an Operate world): its action is search and add to cart, in working form.

Audience and job: Indian shoppers who know Flipkart and Amazon.in by heart, plus sellers and one admin; evaluators watching a live DBMS demo. Success: a category-fluent shopper finds search, categories, cart and orders without thinking, and every number on screen comes from the database.

Constraints: plain HTML/CSS/vanilla ES modules, no build; no backend changes; no invented ratings, discounts, MRP or delivery dates; product photos are openly licensed stock, one per product type, credited.

## Direction contract

THESIS: Bazaar plays the Indian general-marketplace canon straight (Flipkart/Amazon.in, user-pinned): photo-led white product tiles on a cool grey ground under a committed coloured header, dense filters, sticky buy box. It refuses the incumbent SaaS look: indigo gradients, monogram tiles, a role-picker landing page, cards-in-cards.

OWN-WORLD: Peacock-teal shell (header #0b3a47, category bar #0f4b5a) with white type; cool grey ground #eef1f3; white surfaces with 1px #dde2e6 hairlines and tight 4-8px corners; marigold #ffc53d "Add to cart" on ink, peacock #0b6377 "Buy now" and primary actions; green #067d48 for in stock and success, vermilion #c4321a for low stock and errors. One family, Figtree 400-800; prices in 700 ink with a lighter ₹ sign and tabular numerals. Photos sit on white, cropped square.

STORY: The shopper lands on a store, not a role picker: categories and real products are visible at once. They search or filter, open a product, add to cart, and sign in by email only when checkout needs an identity. They pay through the simulated gateway and follow the order down its delivery line. Sellers and the admin reach their portals from "Sell on Bazaar" and the account menu.

FIRST VIEWPORT: Home at 1440x900: 64px peacock header (Bazaar wordmark left; wide search with category select and marigold search button centre; Account, Orders, Cart with count right). Under it a 40px darker category bar listing all 18 categories. Then a 300px banner band (one large slide, real category photo, real "from ₹N" price from the cheapest product) beside nothing else; below it, four white "shop the category" panels, each a 2x2 grid of product-type photos linking to filtered search. Primary action: the search field, then add to cart on the product rows that follow.

FORM: canon, Flipkart/Amazon.in marketplace conventions at their craft level, position 1 (user-pinned via question round 2026-11-15). Signature move: order progress drawn as a metro line, stations Placed, Paid, Shipped, In transit, Delivered, full size on the order page and as a mini line on order lists and seller orders. seed: none (direction pinned by the user; concept-seed not run)

FINISH: unreviewed and undocumented is unfinished; this build ends with the finish review, the verdict, DESIGN.md, and every shipping raster carrying its provenance
