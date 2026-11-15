async function loadOrders() {

    const ordersContainer =
        document.getElementById("orders");

    // Get the customer ID saved during checkout
    const customerId =
        localStorage.getItem("customer_id");

    if (!customerId) {

        ordersContainer.innerHTML =
            "<p>No customer selected. Please go to checkout first.</p>";

        return;
    }

    try {

        const response = await fetch(
            `${API_BASE_URL}/customers/${customerId}/orders`
        );

        const orders = await response.json();

        if (!response.ok) {
            throw new Error(
                orders.detail || "Unable to load orders"
            );
        }

        if (orders.length === 0) {

            ordersContainer.innerHTML =
                "<p>You have not placed any orders yet.</p>";

            return;
        }

        ordersContainer.innerHTML = "";

        orders.forEach(order => {

            const orderCard =
                document.createElement("div");

            orderCard.classList.add("product-card");

            orderCard.innerHTML = `

                <h2>
                    Order #${order.order_id}
                </h2>

                <p>
                    <strong>Date:</strong>
                    ${order.order_date}
                </p>

                <p>
                    <strong>Status:</strong>
                    ${order.status}
                </p>

                <p>
                    <strong>Total:</strong>
                    ₹${order.total_amount}
                </p>

                <p>
                    <strong>Payment:</strong>
                    ${order.payment_status}
                </p>

                <p>
                    <strong>Shipment:</strong>
                    ${order.shipment_status || "Not shipped"}
                </p>

                <p>
                    <strong>Tracking Number:</strong>
                    ${order.tracking_number || "Not available"}
                </p>

                <button
                    onclick="viewOrder(${order.order_id})">
                    View Order
                </button>

                <button
                    onclick="trackOrder(${order.order_id})">
                    Track Order
                </button>

            `;

            ordersContainer.appendChild(orderCard);
        });

    } catch (error) {

        console.error(error);

        ordersContainer.innerHTML =
            `<p>Unable to load orders: ${error.message}</p>`;
    }
}


function viewOrder(orderId) {

    window.location.href =
        `order-confirmation.html?order_id=${orderId}`;
}

function trackOrder(orderId) {

    window.location.href =
        `tracking.html?order_id=${orderId}`;
}

loadOrders();