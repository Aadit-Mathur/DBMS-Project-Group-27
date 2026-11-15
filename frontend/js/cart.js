async function loadCart() {

    const cartContainer = document.getElementById("cart");

    let cart = JSON.parse(localStorage.getItem("cart")) || [];

    if (cart.length === 0) {
        cartContainer.innerHTML = "<p>Your cart is empty.</p>";
        return;
    }

    try {

        // getProducts() only returns the first 20 products, so look up each
        // cart item by its own id instead.
        const results = await Promise.allSettled(
            cart.map(cartItem => getProduct(cartItem.product_id))
        );

        cartContainer.innerHTML = "";

        cart.forEach((cartItem, i) => {

            const cartItemDiv = document.createElement("div");
            cartItemDiv.classList.add("product-card");

            if (results[i].status !== "fulfilled") {
                const note = document.createElement("p");
                note.textContent =
                    `Product #${cartItem.product_id} is no longer available.`;
                cartItemDiv.appendChild(note);
                cartContainer.appendChild(cartItemDiv);
                return;
            }

            const product = results[i].value;

            // textContent (not innerHTML) so product text is never treated as HTML
            const title = document.createElement("h2");
            title.textContent = product.product_name;
            cartItemDiv.appendChild(title);

            [
                `Brand: ${product.brand ?? "-"}`,
                `Price: ₹${product.price}`,
                `Quantity: ${cartItem.quantity}`,
                `Total: ₹${Number(product.price) * cartItem.quantity}`
            ].forEach(text => {
                const p = document.createElement("p");
                p.textContent = text;
                cartItemDiv.appendChild(p);
            });

            cartContainer.appendChild(cartItemDiv);
        });

    } catch (error) {

        console.error(error);

        cartContainer.innerHTML =
            "<p>Unable to load cart.</p>";
    }
}

loadCart();