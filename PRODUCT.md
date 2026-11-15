# Product

<!-- impeccable:product-schema 1 -->

## Platform

web

## Users

- **Customers** (primary): shoppers in India browsing a mixed marketplace (groceries, home and kitchen, clothing, electronics, appliances, books and more), searching and filtering, adding to cart, checking out to a saved address, paying, and tracking orders.
- **Sellers**: small Indian businesses (about 200 in the data) managing their catalog, stock, low-stock alerts and order shipment status.
- **Administrator**: views platform analytics (revenue, orders, categories, top products and sellers, payments, shipments, low stock).
- **Evaluators**: the DBMS course staff during the live demo (17-19 Nov 2026), who grade database design and real use of DBMS features through this app.

## Product Purpose

Bazaar is the frontend of a course project (CS F212 DBMS, BITS Pilani Hyderabad, Group 27): a full-stack e-commerce marketplace over a PostgreSQL database. It exists to demonstrate the database (constraints, triggers, stored functions, transactions, views, aggregates) through convincing, working shopping, selling and admin workflows. Success means a demo that looks and behaves like a real Indian marketplace and every screen is backed by a real endpoint.

## Positioning

A multi-seller marketplace where every rule the shopper meets (stock limits, delisting, payment retries, cancellations and refunds, shipment progression) is enforced by the database itself, not by the page.

## Operating Context

- Plain HTML, CSS and vanilla JS ES modules in `frontend/`, no build step; served by any static server against the FastAPI backend at `http://127.0.0.1:8000`.
- No real authentication: customers and sellers identify by email (`GET /customers?email=`, `GET /sellers?email=`); admin uses the `ADMIN_API_KEY` header.
- Demo identities: `customer0001@example.in`, `seller0001@example.in`.
- Team branch: `frontend-v2` (Aarav Gang's restructure). Work stays local; nothing is pushed.

## Capabilities and Constraints

- Catalog: 801 products, 18 categories, about 200 product types; prices from ₹80 to ₹1,16,049. Product names follow "Brand Product Type (Seller)".
- Product search supports keyword, category, min/max price, in-stock only, limit/offset; results are always sorted by price ascending (no other sort exists).
- No product images, ratings, reviews, discounts, MRP, wishlists, coupons, or delivery dates exist in the data. These must not be invented as facts.
- No customer registration and no add-address endpoint; checkout uses existing saved addresses.
- Payments go through a simulated gateway (approve, decline, outage) exposed for demos.
- Shipment updates act on the whole order (Shipped, In Transit, Delivered).
- The backend is not to be changed for frontend work.

## Brand Commitments

- Name: **Bazaar** (kept from the frontend-v2 branch).
- The user asked for the look of a professional Indian general marketplace, explicitly closest to **Flipkart and Amazon.in** (category strip, deal rows, filter sidebar, product tiles, sticky buy box). Convention is the commitment; execute it at their craft level without copying either brand's logo, colors or trade dress.
- Product imagery: openly licensed photos, one per product type, stored locally with attribution.

## Evidence on Hand

- Real data from the shared Neon database (customers, sellers, products, orders, payments, shipments).
- Reference captures of Flipkart and Amazon.in pages (home, search, product, cart) taken 2026-11-15 for layout study only.
- Absent and not to be fabricated: ratings, reviews, discount percentages, delivery promises with dates, sales counts, customer testimonials.

## Product Principles

1. Every screen is backed by a real endpoint; nothing on the page claims what the database does not hold.
2. Familiar marketplace patterns over novelty: a shopper should know where everything is within a second.
3. Database rules surface as clear, friendly messages at the point of action (stock, delisted, payment declined).
4. Dense where shoppers scan (grids, filters, tables), calm where they decide (product page, checkout).

## Accessibility & Inclusion

WCAG 2.1 AA contrast and keyboard access; Indian number and currency formatting (en-IN, ₹); works on phone widths (390px) as well as desktop.
