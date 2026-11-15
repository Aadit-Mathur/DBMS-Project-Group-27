async function loadOrderConfirmation() {

    const container =
        document.getElementById("orderConfirmation");

    const params =
        new URLSearchParams(window.location.search);

    const orderId =
        params.get("order_id");

    if (!orderId) {
        container.innerHTML =
            "<p>Order ID not found.</p>";
        return;
    }

    try {

        const response = await fetch(
            `${API_BASE_URL}/orders/${orderId}`
        );

        const order = await response.json();

        if (!response.ok) {
            throw new Error(
                order.detail || "Unable to load order"
            );
        }

        let itemsHTML = "";

        order.items.forEach(item => {

            itemsHTML += `
                <div class="product-card">

                    <h2>${item.product_name}</h2>

                    <p>
                        Quantity: ${item.quantity}
                    </p>

                    <p>
                        Unit Price: ₹${item.unit_price}
                    </p>

                    <p>
                        Subtotal: ₹${item.subtotal}
                    </p>

                </div>
            `;
        });

        container.innerHTML = `

            <h2>Order #${order.order_id}</h2>

            <p>
                <strong>Status:</strong>
                ${order.status}
            </p>

            <h2>Items</h2>

            ${itemsHTML}

            <h2>
                Grand Total: ₹${order.total_amount}
            </h2>

            <h2>Delivery Address</h2>

            <p>
                ${order.address.house_no},
                ${order.address.street},
                ${order.address.locality},
                ${order.address.city},
                ${order.address.state}
                - ${order.address.pin_code}
            </p>

            <h2>Payment</h2>

            <p>
                Method:
                ${order.payment.payment_method}
            </p>

            <p>
                Status:
                ${order.payment.status}
            </p>
        `;
        const payButton =
            document.getElementById("payButton");

        if (
            order.payment &&
            order.payment.status === "Pending"
        ) {
            payButton.style.display = "block";

            payButton.onclick = function () {
                payOrder(order.order_id);
            };
        }

    } catch (error) {

        console.error(error);

        container.innerHTML =
            `<p>Unable to load order: ${error.message}</p>`;
    }
}

loadOrderConfirmation();

async function payOrder(orderId) {

    const customerId =
        localStorage.getItem("customer_id");

    if (!customerId) {
        alert("Customer information not found.");
        return;
    }

    try {

        const response = await fetch(
            `${API_BASE_URL}/orders/${orderId}/payment`,
            {
                method: "POST",

                headers: {
                    "Content-Type": "application/json"
                },

                body: JSON.stringify({
                    customer_id: Number(customerId),
                    simulate: "success"
                })
            }
        );

        const result = await response.json();

        if (!response.ok) {
            throw new Error(
                result.detail || "Payment failed"
            );
        }

        alert("Payment successful!");

        window.location.reload();

    } catch (error) {

        console.error(error);

        alert(
            `Payment failed: ${error.message}`
        );
    }
}