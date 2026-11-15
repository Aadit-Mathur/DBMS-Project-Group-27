// Single place for the API base URL. Override at runtime:
//   localStorage.setItem('mk_api_base', 'https://my-api.example.com')
let stored = null; try { stored = localStorage.getItem('mk_api_base'); } catch { /* storage blocked */ }
// Local dev: the API runs on 127.0.0.1:8000 (or serves the pages itself on port 8000).
// Deployed (e.g. Vercel): the API is mounted under /api on the same origin.
const local = ['localhost', '127.0.0.1', ''].includes(location.hostname);
export const API_BASE = (stored || (location.port === '8000' ? '' : local ? 'http://127.0.0.1:8000' : '/api')).replace(/\/$/, '');
export const APP_NAME = 'Bazaar';
export const CURRENCY = 'INR';
export const PAYMENT_METHODS = ['UPI', 'Credit Card', 'Debit Card', 'Net Banking', 'Wallet'];
