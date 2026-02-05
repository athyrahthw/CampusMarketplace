<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Product Details - Campus Marketplace</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <jsp:include page="header.jsp" />
    
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
    
    <jsp:include page="footer.jsp" />
</body>
</html>