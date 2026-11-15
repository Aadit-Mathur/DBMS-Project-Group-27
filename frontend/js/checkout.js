let currentCustomer = null;


async function loadCustomer() {

    const email =
        document.getElementById("customerEmail").value.trim();

    if (!email) {
        alert("Please enter your email.");
        return;
    }

    try {

        const customer = await getCustomerByEmail(email);

        currentCustomer = customer;

        localStorage.setItem(
            "customer_id",
            currentCustomer.customer_id
        );

        document.getElementById("customerDetails").innerHTML = `
            <p><strong>Name:</strong> ${customer.name}</p>
            <p><strong>Email:</strong> ${customer.email}</p>
            <p><strong>Phone:</strong> ${customer.phone}</p>
        `;

        await loadAddresses(customer.customer_id);

    } catch (error) {

        console.error(error);

        currentCustomer = null;

        document.getElementById("customerDetails").innerHTML =
            "<p>Customer not found.</p>";

        document.getElementById("addressSelect").innerHTML =
            '<option value="">Select an address</option>';
    }
}

async function loadAddresses(customerId) {

    const response = await fetch(
        `${API_BASE_URL}/customers/${customerId}/addresses`
    );

    if (!response.ok) {
        throw new Error("Unable to load addresses");
    }

    const addresses = await response.json();

    const addressSelect =
        document.getElementById("addressSelect");

    addressSelect.innerHTML =
        '<option value="">Select an address</option>';

    addresses.forEach(address => {

        const option = document.createElement("option");

        option.value = address.address_id;

        option.textContent =
            `${address.address_type} - ` +
            `${address.house_no}, ${address.street}, ` +
            `${address.locality}, ${address.city}, ` +
            `${address.state} - ${address.pin_code}`;

        addressSelect.appendChild(option);
    });
}

async function loadOrderSummary() {

    const cart = JSON.parse(localStorage.getItem("cart")) || [];

    const summaryContainer =
        document.getElementById("orderSummary");

    if (cart.length === 0) {

        summaryContainer.innerHTML =
            "<p>Your cart is empty.</p>";

        return;
    }

    summaryContainer.innerHTML = "";

    let grandTotal = 0;

    for (const cartItem of cart) {

        try {

            const product =
                await getProduct(cartItem.product_id);

            const subtotal =
                Number(product.price) * cartItem.quantity;

            grandTotal += subtotal;

            const itemDiv =
                document.createElement("div");

            itemDiv.classList.add("product-card");

            itemDiv.innerHTML = `
                <h3>${product.product_name}</h3>

                <p>
                    Price: ₹${Number(product.price).toFixed(2)}
                </p>

                <p>
                    Quantity: ${cartItem.quantity}
                </p>

                <p>
                    Subtotal: ₹${subtotal.toFixed(2)}
                </p>
            `;

            summaryContainer.appendChild(itemDiv);

        } catch (error) {

            console.error(
                `Unable to load product ${cartItem.product_id}`,
                error
            );
        }
    }

    const totalDiv =
        document.createElement("div");

    totalDiv.innerHTML = `
        <h2>
            Grand Total: ₹${grandTotal.toFixed(2)}
        </h2>
    `;

    summaryContainer.appendChild(totalDiv);
}

loadOrderSummary();

async function placeOrder() {

    // Make sure a customer has been selected
    if (!currentCustomer) {
        alert("Please find your customer first.");
        return;
    }

    // Get selected address
    const addressId =
        document.getElementById("addressSelect").value;

    if (!addressId) {
        alert("Please select a delivery address.");
        return;
    }

    // Get payment method
    const paymentMethod =
        document.getElementById("paymentMethod").value;

    // Get cart
    const cart =
        JSON.parse(localStorage.getItem("cart")) || [];

    if (cart.length === 0) {
        alert("Your cart is empty.");
        return;
    }

    // Convert cart into the format expected by the backend
    const items = cart.map(item => ({
        product_id: item.product_id,
        quantity: item.quantity
    }));

    const orderData = {
        customer_id: currentCustomer.customer_id,
        address_id: Number(addressId),
        payment_method: paymentMethod,
        items: items
    };

    try {

        const response = await fetch(
            `${API_BASE_URL}/orders`,
            {
                method: "POST",

                headers: {
                    "Content-Type": "application/json"
                },

                body: JSON.stringify(orderData)
            }
        );

        const result = await response.json();

        if (!response.ok) {
            throw new Error(
                result.detail || result.error || "Failed to place order"
            );
        }

        console.log("Order created:", result);

        alert(
        `Order placed successfully! Order ID: ${result.order_id}`
        );

        localStorage.removeItem("cart");

        window.location.href =
            `order-confirmation.html?order_id=${result.order_id}`;

    } catch (error) {

        console.error(error);

        alert(
            `Unable to place order: ${error.message}`
        );
    }
}