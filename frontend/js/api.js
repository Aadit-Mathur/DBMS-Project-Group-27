const API_BASE_URL = "http://127.0.0.1:8000";

async function getProducts() {
    const response = await fetch(`${API_BASE_URL}/products`);

    if (!response.ok) {
        throw new Error("Failed to fetch products");
    }

    return await response.json();
}

async function getCategories() {
    const response = await fetch(`${API_BASE_URL}/categories`);

    if (!response.ok) {
        throw new Error("Failed to fetch categories");
    }

    return await response.json();
}

async function getCustomerByEmail(email) {

    const response = await fetch(
        `${API_BASE_URL}/customers?email=${encodeURIComponent(email)}`
    );

    if (!response.ok) {
        throw new Error("Customer not found");
    }

    return await response.json();
}

async function getProduct(productId) {

    const response = await fetch(
        `${API_BASE_URL}/products/${productId}`
    );

    if (!response.ok) {
        throw new Error("Failed to fetch product");
    }

    return await response.json();
}