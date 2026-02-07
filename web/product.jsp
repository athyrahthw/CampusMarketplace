<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Product Details - Campus Marketplace</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
        /* Add some basic header/footer styles */
        header {
            background-color: #f8f9fa;
            padding: 1rem;
            border-bottom: 1px solid #dee2e6;
        }
        .header-container {
            display: flex;
            justify-content: space-between;
            align-items: center;
            max-width: 1200px;
            margin: 0 auto;
        }
        .logo {
            font-size: 1.5rem;
            font-weight: bold;
            color: #007bff;
            text-decoration: none;
        }
        nav a {
            margin-left: 1rem;
            text-decoration: none;
            color: #495057;
        }
        nav a:hover {
            color: #007bff;
        }
        footer {
            background-color: #f8f9fa;
            padding: 2rem 1rem;
            border-top: 1px solid #dee2e6;
            margin-top: 2rem;
        }
        .footer-container {
            max-width: 1200px;
            margin: 0 auto;
            text-align: center;
        }
        .footer-links a {
            margin: 0 0.5rem;
            text-decoration: none;
            color: #6c757d;
        }
        .footer-links a:hover {
            color: #007bff;
        }
        /* Product page styles */
        .product-container {
            display: flex;
            max-width: 1200px;
            margin: 2rem auto;
            gap: 2rem;
        }
        .product-images {
            flex: 1;
        }
        .product-details {
            flex: 1;
        }
        .main-image {
            width: 100%;
            max-width: 500px;
            border-radius: 8px;
        }
        .price {
            font-size: 1.5rem;
            font-weight: bold;
            color: #28a745;
            margin: 1rem 0;
        }
        .product-actions {
            margin-top: 2rem;
            display: flex;
            gap: 1rem;
        }
        .btn-cart, .btn-chat, .btn-buy {
            padding: 0.75rem 1.5rem;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-weight: bold;
        }
        .btn-cart {
            background-color: #007bff;
            color: white;
        }
        .btn-chat {
            background-color: #6c757d;
            color: white;
        }
        .btn-buy {
            background-color: #28a745;
            color: white;
        }
    </style>
</head>
<body>
    <!-- Header content directly in the file -->
    <header>
        <div class="header-container">
            <a href="index.jsp" class="logo">Campus Marketplace</a>
            <nav>
                <a href="products.jsp">Browse</a>
                <a href="cart.jsp">Cart</a>
                <a href="profile.jsp">Profile</a>
                <a href="login.jsp">Login</a>
            </nav>
        </div>
    </header>
    
    <div class="product-container">
        <div class="product-images">
            <img src="${product.imageUrl}" alt="${product.name}" class="main-image">
        </div>
        
        <div class="product-details">
            <h1>${product.name}</h1>
            <div class="price">RM ${product.price}</div>
            <div class="category">${product.category}</div>
            <div class="description">${product.description}</div>
            <div class="seller-info">
                <span>Sold by: ${product.seller.username}</span>
            </div>
            
            <div class="product-actions">
                <form action="AddToCartServlet" method="post">
                    <input type="hidden" name="productId" value="${product.id}">
                    <button type="submit" class="btn-cart">Add to Cart</button>
                </form>
                <button class="btn-chat" onclick="openChat(${product.seller.id})">Chat Now</button>
                <form action="CheckoutServlet" method="post">
                    <input type="hidden" name="productId" value="${product.id}">
                    <button type="submit" class="btn-buy">Buy Now</button>
                </form>
            </div>
        </div>
    </div>
    
    <!-- Footer content directly in the file -->
    <footer>
        <div class="footer-container">
            <p>&copy; 2024 Campus Marketplace. All rights reserved.</p>
            <div class="footer-links">
                <a href="about.jsp">About</a>
                <a href="contact.jsp">Contact</a>
                <a href="terms.jsp">Terms</a>
                <a href="privacy.jsp">Privacy</a>
            </div>
        </div>
    </footer>
    
    <script>
        function openChat(sellerId) {
            // Implement chat functionality here
            alert('Opening chat with seller ID: ' + sellerId);
            // Example: window.location.href = 'chat.jsp?sellerId=' + sellerId;
        }
    </script>
</body>
</html>