<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Products - Campus Marketplace</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <jsp:include page="header.jsp" />
    
    <div class="categories">
        <h2>CATEGORIES</h2>
        <div class="category-list">
            <c:forEach var="category" items="${categories}">
                <a href="ProductServlet?category=${category}" class="category-item">${category}</a>
            </c:forEach>
        </div>
    </div>
    
    <div class="products-grid">
        <c:forEach var="product" items="${products}">
            <div class="product-card">
                <img src="${product.imageUrl}" alt="${product.name}">
                <h3>${product.name}</h3>
                <p class="price">RM ${product.price}</p>
                <a href="ProductServlet?action=view&id=${product.id}" class="view-btn">View Details</a>
            </div>
        </c:forEach>
    </div>
    
    <jsp:include page="footer.jsp" />
</body>
</html>