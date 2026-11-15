async function loadSeller() {

    const email =
        document.getElementById("sellerEmail").value.trim();

    if (!email) {
        alert("Please enter seller email.");
        return;
    }

    try {

        const response = await fetch(
            `${API_BASE_URL}/sellers?email=${encodeURIComponent(email)}`
        );

        const seller = await response.json();

        if (!response.ok) {
            throw new Error(
                seller.detail || "Seller not found"
            );
        }

        // Save seller ID for later use
        localStorage.setItem(
            "seller_id",
            seller.seller_id
        );

        document.getElementById("sellerDetails").innerHTML = `
            <div class="product-card">

                <h2>Seller Information</h2>

                <p>
                    <strong>Name:</strong>
                    ${seller.name}
                </p>

                <p>
                    <strong>Email:</strong>
                    ${seller.email}
                </p>

                <p>
                    <strong>Phone:</strong>
                    ${seller.phone}
                </p>

            </div>
        `;

        await loadSellerDashboard(seller.seller_id);
        await loadSellerProducts(seller.seller_id);
        await loadLowStock(seller.seller_id);
        await loadSellerOrders(seller.seller_id);

    } catch (error) {

        console.error(error);

        document.getElementById("sellerDetails").innerHTML =
            `<p>Unable to find seller: ${error.message}</p>`;

    }
}

async function loadSellerDashboard(sellerId) {

    const dashboardContainer =
        document.getElementById("sellerDashboard");

    try {

        const response = await fetch(
            `${API_BASE_URL}/sellers/${sellerId}/dashboard`
        );

        const dashboard = await response.json();

        if (!response.ok) {
            throw new Error(
                dashboard.detail || "Unable to load dashboard"
            );
        }

        dashboardContainer.innerHTML = `

            <div class="product-card">

                <h2>Dashboard</h2>

                <p>
                    <strong>Active Products:</strong>
                    ${dashboard.active_products}
                </p>

                <p>
                    <strong>Units in Stock:</strong>
                    ${dashboard.units_in_stock}
                </p>

                <p>
                    <strong>Inventory Value:</strong>
                    ₹${Number(dashboard.inventory_value).toFixed(2)}
                </p>

                <p>
                    <strong>Low Stock Products:</strong>
                    ${dashboard.low_stock_products}
                </p>

            </div>
        `;

    } catch (error) {

        console.error(error);

        dashboardContainer.innerHTML =
            `<p>Unable to load dashboard: ${error.message}</p>`;
    }
}

async function loadSellerProducts(sellerId) {

    console.log("LOAD SELLER PRODUCTS CALLED");

    const productsContainer =
        document.getElementById("sellerProducts");

    try {

        const response = await fetch(
            `${API_BASE_URL}/sellers/${sellerId}/products?include_inactive=true`
        );

        const products = await response.json();

        console.log("SELLER PRODUCTS:", products);

        console.log(
            "INACTIVE PRODUCTS:",
            products.filter(product => !product.is_active)
        );

        if (!response.ok) {
            throw new Error(
                products.detail || "Unable to load products"
            );
        }

        if (products.length === 0) {

            productsContainer.innerHTML =
                "<p>No products found for this seller.</p>";

            return;
        }

        let productsHTML = `
            <h2>My Products</h2>
        `;

        products.forEach(product => {

            let actionButtons = `
                <button onclick="showEditProductForm(${product.product_id})">
                    Edit Product
                </button>

                <button onclick="deleteSellerProduct(${product.product_id})">
                    Delete / Delist
                </button>

                <button onclick="restockSellerProduct(${product.product_id})">
                    Restock Product
                </button>
            `;

            if (!product.is_active) {
                actionButtons += `
                    <button onclick="relistSellerProduct(${product.product_id})">
                        Relist Product
                    </button>
                `;
            };

            productsHTML += `

                <div class="product-card">

                    <h3>
                        ${product.product_name}
                    </h3>

                    <p>
                        <strong>Brand:</strong>
                        ${product.brand}
                    </p>

                    <p>
                        <strong>Category:</strong>
                        ${product.category_name}
                    </p>

                    <p>
                        <strong>Price:</strong>
                        ₹${Number(product.price).toFixed(2)}
                    </p>

                    <p>
                        <strong>Stock:</strong>
                        ${product.quantity_in_stock}
                    </p>

                    <p>
                        <strong>Reorder Level:</strong>
                        ${product.reorder_level}
                    </p>

                    <p>
                        <strong>Status:</strong>
                        ${product.is_active ? "Active" : "Inactive"}
                    </p>

                    ${actionButtons}

                </div>
            `;
        });

        productsContainer.innerHTML = productsHTML;

    } catch (error) {

        console.error(error);

        productsContainer.innerHTML =
            `<p>Unable to load products: ${error.message}</p>`;
    }
}

async function loadLowStock(sellerId) {

    const lowStockContainer =
        document.getElementById("lowStock");

    try {

        const response = await fetch(
            `${API_BASE_URL}/sellers/${sellerId}/low-stock`
        );

        const products = await response.json();

        if (!response.ok) {
            throw new Error(
                products.detail || "Unable to load low-stock products"
            );
        }

        if (products.length === 0) {

            lowStockContainer.innerHTML = `
                <div class="product-card">
                    <h2>Low Stock Alerts</h2>
                    <p>All products have sufficient stock.</p>
                </div>
            `;

            return;
        }

        let html = `
            <h2>Low Stock Alerts</h2>
        `;

        products.forEach(product => {

            html += `

                <div class="product-card">

                    <h3>
                        ${product.product_name}
                    </h3>

                    <p>
                        Current Stock:
                        ${product.quantity_in_stock}
                    </p>

                    <p>
                        Reorder Level:
                        ${product.reorder_level}
                    </p>

                    <p>
                        Shortfall:
                        ${product.shortfall}
                    </p>

                </div>

            `;
        });

        lowStockContainer.innerHTML = html;

    } catch (error) {

        console.error(error);

        lowStockContainer.innerHTML =
            `<p>Unable to load low-stock products: ${error.message}</p>`;
    }
}

async function loadSellerOrders(sellerId) {

    const ordersContainer =
        document.getElementById("sellerOrders");

    try {

        const response = await fetch(
            `${API_BASE_URL}/sellers/${sellerId}/orders`
        );

        const orders = await response.json();

        if (!response.ok) {
            throw new Error(
                orders.detail || "Unable to load seller orders"
            );
        }

        if (orders.length === 0) {

            ordersContainer.innerHTML =
                "<p>No orders found for this seller.</p>";

            return;
        }

        let html = `
            <h2>My Orders</h2>
        `;

        orders.forEach(order => {

            html += `

                <div class="product-card">

                    <h3>
                        Order #${order.order_id}
                    </h3>

                    <p>
                        <strong>Date:</strong>
                        ${order.order_date}
                    </p>

                    <p>
                        <strong>Order Status:</strong>
                        ${order.status}
                    </p>

                    <p>
                        <strong>Product:</strong>
                        ${order.product_name}
                    </p>

                    <p>
                        <strong>Quantity:</strong>
                        ${order.quantity}
                    </p>

                    <p>
                        <strong>Unit Price:</strong>
                        ₹${Number(order.unit_price).toFixed(2)}
                    </p>

                    <p>
                        <strong>Subtotal:</strong>
                        ₹${Number(order.subtotal).toFixed(2)}
                    </p>

                    <p>
                        <strong>Order Total:</strong>
                        ₹${Number(order.total_amount).toFixed(2)}
                    </p>

                    <p>
                        <strong>Shipment:</strong>
                        ${order.shipment_status || "Not shipped"}
                    </p>

                    <p>
                        <strong>Carrier:</strong>
                        ${order.carrier || "Not assigned"}
                    </p>

                    <p>
                        <strong>Tracking Number:</strong>
                        ${order.tracking_number || "Not available"}
                    </p>
                    
                    <div>

                        <label>
                            <strong>Update Shipment:</strong>
                        </label>

                        <select id="status-${order.order_id}">
                            <option value="Shipped">Shipped</option>
                            <option value="In Transit">In Transit</option>
                            <option value="Delivered">Delivered</option>
                        </select>

                        <input
                            type="text"
                            id="carrier-${order.order_id}"
                            placeholder="Carrier"
                            value="${order.carrier || ""}"
                        >

                        <button onclick="updateShipment(${order.order_id})">
                            Update Shipment
                        </button>

                    </div>

                    

                </div>

            `;
        });

        ordersContainer.innerHTML = html;

    } catch (error) {

        console.error(error);

        ordersContainer.innerHTML =
            `<p>Unable to load orders: ${error.message}</p>`;
    }
}

async function updateShipment(orderId) {

    const status =
        document.getElementById(`status-${orderId}`).value;

    const carrier =
        document.getElementById(`carrier-${orderId}`).value.trim();

    try {

        const response = await fetch(
            `${API_BASE_URL}/orders/${orderId}/shipment`,
            {
                method: "POST",
                headers: {
                    "Content-Type": "application/json"
                },
                body: JSON.stringify({
                    status: status,
                    carrier: carrier || null
                })
            }
        );

        const result = await response.json();

        if (!response.ok) {
            throw new Error(
                result.detail || "Unable to update shipment"
            );
        }

        alert("Shipment updated successfully.");

        const sellerId =
            localStorage.getItem("seller_id");

        await loadSellerOrders(Number(sellerId));

    } catch (error) {

        console.error(error);

        alert(
            `Unable to update shipment: ${error.message}`
        );
    }
}

async function addSellerProduct() {
    const sellerId = Number(localStorage.getItem("seller_id"));

    const categoryId =
        Number(document.getElementById("productCategoryId").value);

    const productName =
        document.getElementById("productName").value.trim();

    const price =
        Number(document.getElementById("productPrice").value);

    const brand =
        document.getElementById("productBrand").value.trim();

    const description =
        document.getElementById("productDescription").value.trim();

    const stock =
        Number(document.getElementById("productStock").value);

    const reorderLevel =
        Number(document.getElementById("productReorderLevel").value);

    if (!sellerId || !categoryId || !productName || !price) {
        alert("Please fill in seller, category, product name and price.");
        return;
    }

    try {
        const response = await fetch(
            `${API_BASE_URL}/sellers/${sellerId}/products`,
            {
                method: "POST",
                headers: {
                    "Content-Type": "application/json"
                },
                body: JSON.stringify({
                    category_id: categoryId,
                    product_name: productName,
                    price: price,
                    description: description || null,
                    brand: brand || null,
                    quantity_in_stock: stock,
                    reorder_level: reorderLevel
                })
            }
        );

        const result = await response.json();

        if (!response.ok) {
            throw new Error(
                result.detail || "Unable to add product"
            );
        }

        alert("Product added successfully.");

        document.getElementById("productCategoryId").value = "";
        document.getElementById("productName").value = "";
        document.getElementById("productPrice").value = "";
        document.getElementById("productBrand").value = "";
        document.getElementById("productDescription").value = "";
        document.getElementById("productStock").value = "0";
        document.getElementById("productReorderLevel").value = "10";

        await loadSellerProducts(sellerId);
        await loadSellerDashboard(sellerId);
        await loadLowStock(sellerId);

    } catch (error) {
        console.error(error);

        alert(
            `Unable to add product: ${error.message}`
        );
    }
}


function showEditProductForm(productId) {
    // Stock is not edited here: it only changes through "Restock Product" and orders.
    // Leave a prompt blank to keep the current value.
    const productName = prompt("New product name (blank = keep):");
    if (productName === null) return;

    const price = prompt("New price (blank = keep):");
    if (price === null) return;

    const reorderLevel = prompt("New reorder level (blank = keep):");
    if (reorderLevel === null) return;

    updateSellerProduct(productId, productName.trim(), price.trim(), reorderLevel.trim());
}

async function updateSellerProduct(productId, productName, price, reorderLevel) {
    const sellerId = Number(localStorage.getItem("seller_id"));

    // Send only the fields that were filled in (PATCH /products/{id}).
    const changes = {};
    if (productName) changes.product_name = productName;
    if (price) changes.price = Number(price);
    if (reorderLevel) changes.reorder_level = Number(reorderLevel);

    if (Object.keys(changes).length === 0) {
        alert("Nothing to update.");
        return;
    }

    try {
        const response = await fetch(
            `${API_BASE_URL}/products/${productId}`,
            {
                method: "PATCH",
                headers: {
                    "Content-Type": "application/json",
                    "X-Seller-Id": sellerId
                },
                body: JSON.stringify(changes)
            }
        );

        const result = await response.json();

        if (!response.ok) {
            throw new Error(
                typeof result.detail === "string" ? result.detail : "Unable to update product"
            );
        }

        alert("Product updated successfully.");

        await loadSellerProducts(sellerId);
        await loadSellerDashboard(sellerId);
        await loadLowStock(sellerId);

    } catch (error) {
        console.error(error);

        alert(
            `Unable to update product: ${error.message}`
        );
    }
}

async function deleteSellerProduct(productId) {
    const sellerId = Number(localStorage.getItem("seller_id"));

    const confirmed = confirm(
        "Are you sure you want to delete/delist this product?"
    );

    if (!confirmed) {
        return;
    }

    try {
        const response = await fetch(
            `${API_BASE_URL}/products/${productId}`,
            {
                method: "DELETE",
                headers: {
                    "X-Seller-Id": sellerId
                }
            }
        );

        const result = await response.json().catch(() => null);

        if (!response.ok) {
            throw new Error(
                result?.detail || "Unable to delete product"
            );
        }

        if (response.status === 204) {
            alert("Product deleted successfully.");
        } else {
            alert(
                result?.status === "delisted"
                    ? "Product was delisted because it appears in past orders."
                    : "Product deleted successfully."
            );
        }

        await loadSellerProducts(sellerId);
        await loadSellerDashboard(sellerId);
        await loadLowStock(sellerId);

    } catch (error) {
        console.error(error);

        alert(
            `Unable to delete product: ${error.message}`
        );
    }
}

async function restockSellerProduct(productId) {
    const sellerId = Number(localStorage.getItem("seller_id"));

    const quantity = prompt("Enter quantity to add to stock:");

    if (quantity === null) {
        return;
    }

    const amount = Number(quantity);

    if (!Number.isInteger(amount) || amount <= 0) {
        alert("Please enter a positive whole number.");
        return;
    }

    try {
        const response = await fetch(
            `${API_BASE_URL}/products/${productId}/restock`,
            {
                method: "POST",
                headers: {
                    "Content-Type": "application/json",
                    "X-Seller-Id": sellerId
                },
                body: JSON.stringify({
                    quantity: amount
                })
            }
        );

        const result = await response.json();

        if (!response.ok) {
            throw new Error(
                result.detail || "Unable to restock product"
            );
        }

        alert(
            `Product restocked successfully. New stock: ${result.quantity_in_stock}`
        );

        await loadSellerProducts(sellerId);
        await loadSellerDashboard(sellerId);
        await loadLowStock(sellerId);

    } catch (error) {
        console.error(error);

        alert(
            `Unable to restock product: ${error.message}`
        );
    }
}

async function relistSellerProduct(productId) {
    const sellerId = Number(localStorage.getItem("seller_id"));

    try {
        const response = await fetch(
            `${API_BASE_URL}/products/${productId}/relist`,
            {
                method: "POST",
                headers: {
                    "X-Seller-Id": sellerId
                }
            }
        );

        const result = await response.json();

        if (!response.ok) {
            throw new Error(
                result.detail || "Unable to relist product"
            );
        }

        alert("Product relisted successfully.");

        await loadSellerProducts(sellerId);
        await loadSellerDashboard(sellerId);
        await loadLowStock(sellerId);

    } catch (error) {
        console.error(error);
        alert(`Unable to relist product: ${error.message}`);
    }
}