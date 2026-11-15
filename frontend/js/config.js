// Single place for the API base URL. Override at runtime:
//   localStorage.setItem('mk_api_base', 'https://my-api.example.com')
const stored = localStorage.getItem('mk_api_base');
export const API_BASE = (stored || (location.port === '8000' ? '' : 'http://127.0.0.1:8000')).replace(/\/$/, '');
export const APP_NAME = 'Bazaar';
export const CURRENCY = 'INR';
export const PAYMENT_METHODS = ['UPI', 'Credit Card', 'Debit Card', 'Net Banking', 'Wallet'];
