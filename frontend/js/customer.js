async function loadProducts() {
    try {
        const products = await getProducts();
        displayProducts(products);

    } catch (error) {
        console.error(error);

        document.getElementById("products").innerHTML =
            "<p>Unable to load products.</p>";
    }
}


function displayProducts(products) {

    const productsContainer = document.getElementById("products");

    productsContainer.innerHTML = "";

    if (products.length === 0) {
        productsContainer.innerHTML =
            "<p>No products found.</p>";
        return;
    }

    products.forEach(product => {

        const productCard = document.createElement("div");

        productCard.classList.add("product-card");

        productCard.innerHTML = `
            <h2>${product.product_name}</h2>

            <p>Brand: ${product.brand}</p>

            <p>Price: ₹${product.price}</p>

            <p>Category: ${product.category_name}</p>

            <p>Seller: ${product.seller_name}</p>

            <p>
                Stock:
                ${product.in_stock ? "Available" : "Out of stock"}
            </p>

            <button onclick="addToCart(${product.product_id})">
                Add to Cart
            </button>
        `;

        productsContainer.appendChild(productCard);
    });
}


async function searchProducts() {

    const search =
        document.getElementById("searchInput").value;

    const minPrice =
        document.getElementById("minPrice").value;

    const maxPrice =
        document.getElementById("maxPrice").value;

    const stockOnly =
        document.getElementById("stockFilter").checked;
    
    const categoryId =
    document.getElementById("categoryFilter").value;

    let url = `${API_BASE_URL}/products?`;

    if (search) {
        url += `q=${encodeURIComponent(search)}&`;
    }

    if (minPrice) {
        url += `min_price=${minPrice}&`;
    }

    if (categoryId) {
        url += `category_id=${categoryId}&`;
    }

    if (maxPrice) {
        url += `max_price=${maxPrice}&`;
    }

    if (stockOnly) {
        url += `in_stock_only=true&`;
    }

    try {

        const response = await fetch(url);

        if (!response.ok) {
            throw new Error("Failed to search products");
        }

        const products = await response.json();

        displayProducts(products);

    } catch (error) {

        console.error(error);

        document.getElementById("products").innerHTML =
            "<p>Unable to search products.</p>";
    }
}

async function loadCategories() {

    try {

        const categories = await getCategories();

        const categorySelect =
            document.getElementById("categoryFilter");

        categories.forEach(category => {

            const option = document.createElement("option");

            option.value = category.category_id;
            option.textContent = category.category_name;

            categorySelect.appendChild(option);
        });

    } catch (error) {

        console.error(error);

    }
}

loadProducts();
loadCategories();

function addToCart(productId) {

    let cart = JSON.parse(localStorage.getItem("cart")) || [];

    const existingProduct = cart.find(
        item => item.product_id === productId
    );

    if (existingProduct) {
        existingProduct.quantity += 1;
    } else {
        cart.push({
            product_id: productId,
            quantity: 1
        });
    }

    localStorage.setItem("cart", JSON.stringify(cart));

    alert("Product added to cart!");
}