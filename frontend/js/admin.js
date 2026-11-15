async function loadAdminDashboard() {
    try {
        const response = await fetch(
            `${API_BASE_URL}/reports/dashboard`
        );

        const data = await response.json();

        if (!response.ok) {
            throw new Error(data.detail || "Unable to load dashboard");
        }

        document.getElementById("dashboard").innerHTML = `
            <h2>Overview</h2>

            <div class="product-grid">

                <div class="product-card">
                    <h3>Customers</h3>
                    <p>${data.total_customers}</p>
                </div>

                <div class="product-card">
                    <h3>Sellers</h3>
                    <p>${data.total_sellers}</p>
                </div>

                <div class="product-card">
                    <h3>Products</h3>
                    <p>${data.total_products}</p>
                </div>

                <div class="product-card">
                    <h3>Orders</h3>
                    <p>${data.total_orders}</p>
                </div>

                <div class="product-card">
                    <h3>Total Order Value</h3>
                    <p>₹${Number(data.total_order_value).toFixed(2)}</p>
                </div>

            </div>
        `;

    } catch (error) {
        console.error(error);
        document.getElementById("dashboard").innerHTML =
            `<p>Unable to load dashboard: ${error.message}</p>`;
    }
}


async function loadTopProducts() {
    try {
        const response = await fetch(
            `${API_BASE_URL}/reports/top-products`
        );

        const products = await response.json();

        if (!response.ok) {
            throw new Error(products.detail || "Unable to load top products");
        }

        let html = `
            <h2>Top Products</h2>

            <table border="1">
                <tr>
                    <th>Product</th>
                    <th>Units Sold</th>
                    <th>Revenue</th>
                </tr>
        `;

        products.forEach(product => {
            html += `
                <tr>
                    <td>${product.product_name}</td>
                    <td>${product.units_sold}</td>
                    <td>₹${Number(product.revenue).toFixed(2)}</td>
                </tr>
            `;
        });

        html += `</table>`;

        document.getElementById("topProducts").innerHTML = html;

    } catch (error) {
        console.error(error);
        document.getElementById("topProducts").innerHTML =
            `<p>Unable to load top products: ${error.message}</p>`;
    }
}


async function loadCategorySales() {
    try {
        const response = await fetch(
            `${API_BASE_URL}/reports/categories`
        );

        const categories = await response.json();

        if (!response.ok) {
            throw new Error(
                categories.detail || "Unable to load category sales"
            );
        }

        let html = `
            <h2>Category Sales</h2>

            <table border="1">
                <tr>
                    <th>Category</th>
                    <th>Units Sold</th>
                    <th>Revenue</th>
                </tr>
        `;

        categories.forEach(category => {
            html += `
                <tr>
                    <td>${category.category_name}</td>
                    <td>${category.units_sold}</td>
                    <td>₹${Number(category.revenue).toFixed(2)}</td>
                </tr>
            `;
        });

        html += `</table>`;

        document.getElementById("categorySales").innerHTML = html;

    } catch (error) {
        console.error(error);
        document.getElementById("categorySales").innerHTML =
            `<p>Unable to load category sales: ${error.message}</p>`;
    }
}


async function loadOrderStatus() {
    try {
        const response = await fetch(
            `${API_BASE_URL}/reports/order-status`
        );

        const statuses = await response.json();

        if (!response.ok) {
            throw new Error(
                statuses.detail || "Unable to load order status"
            );
        }

        let html = `
            <h2>Order Status</h2>

            <table border="1">
                <tr>
                    <th>Status</th>
                    <th>Number of Orders</th>
                </tr>
        `;

        statuses.forEach(status => {
            html += `
                <tr>
                    <td>${status.order_status}</td>
                    <td>${status.order_count}</td>
                </tr>
            `;
        });

        html += `</table>`;

        document.getElementById("orderStatus").innerHTML = html;

    } catch (error) {
        console.error(error);
        document.getElementById("orderStatus").innerHTML =
            `<p>Unable to load order status: ${error.message}</p>`;
    }
}


loadAdminDashboard();
loadTopProducts();
loadCategorySales();
loadOrderStatus();