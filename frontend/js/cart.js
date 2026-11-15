async function loadCart() {

    const cartContainer = document.getElementById("cart");

    let cart = JSON.parse(localStorage.getItem("cart")) || [];

    if (cart.length === 0) {
        cartContainer.innerHTML = "<p>Your cart is empty.</p>";
        return;
    }

    try {

        const products = await getProducts();

        cartContainer.innerHTML = "";

        cart.forEach(cartItem => {

            const product = products.find(
                p => p.product_id === cartItem.product_id
            );

            if (!product) {
                return;
            }

            const cartItemDiv = document.createElement("div");

            cartItemDiv.classList.add("product-card");

            cartItemDiv.innerHTML = `
                <h2>${product.product_name}</h2>

                <p>Brand: ${product.brand}</p>

                <p>Price: ₹${product.price}</p>

                <p>Quantity: ${cartItem.quantity}</p>

                <p>
                    Total:
                    ₹${Number(product.price) * cartItem.quantity}
                </p>
            `;

            cartContainer.appendChild(cartItemDiv);
        });

    } catch (error) {

        console.error(error);

        cartContainer.innerHTML =
            "<p>Unable to load cart.</p>";
    }
}

loadCart();