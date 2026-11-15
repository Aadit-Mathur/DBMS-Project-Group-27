async function loadTracking() {

    const trackingContainer =
        document.getElementById("tracking");

    const params =
        new URLSearchParams(window.location.search);

    const orderId =
        params.get("order_id");

    if (!orderId) {

        trackingContainer.innerHTML =
            "<p>Order ID not found.</p>";

        return;
    }

    try {

        const response = await fetch(
            `${API_BASE_URL}/orders/${orderId}/tracking`
        );

        const tracking = await response.json();

        if (!response.ok) {
            throw new Error(
                tracking.detail || "Unable to load tracking information"
            );
        }

        trackingContainer.innerHTML = `

            <div class="product-card">

                <h2>
                    Order #${tracking.order_id}
                </h2>

                <p>
                    <strong>Order Status:</strong>
                    ${tracking.status}
                </p>

                <p>
                    <strong>Payment Status:</strong>
                    ${tracking.payment_status}
                </p>

                <p>
                    <strong>Shipment Status:</strong>
                    ${tracking.shipment_status || "Not shipped"}
                </p>

                <p>
                    <strong>Carrier:</strong>
                    ${tracking.carrier || "Not assigned"}
                </p>

                <p>
                    <strong>Tracking Number:</strong>
                    ${tracking.tracking_number || "Not available"}
                </p>

                <h3>Delivery Timeline</h3>

                <div>
                    ${tracking.timeline.map(event => `
                        <div class="product-card">

                            <p>
                                <strong>
                                    ${event.event_type}
                                </strong>
                            </p>

                            <p>
                                ${event.detail || ""}
                            </p>

                            <p>
                                ${event.event_time}
                            </p>

                        </div>
                    `).join("")}
                </div>

            </div>
        `;

    } catch (error) {

        console.error(error);

        trackingContainer.innerHTML =
            `<p>Unable to load tracking: ${error.message}</p>`;
    }
}


loadTracking();