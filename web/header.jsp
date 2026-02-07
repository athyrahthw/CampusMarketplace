<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<header>
    <nav class="navbar">
        <div class="nav-brand">
            <a href="${pageContext.request.contextPath}/">Campus Marketplace</a>
        </div>
        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/">Home</a>
            <a href="${pageContext.request.contextPath}/products">Products</a>
            <a href="${pageContext.request.contextPath}/cart.jsp">Cart</a>
            <a href="${pageContext.request.contextPath}/checkout.jsp">Checkout</a>
            
            <!-- User session check -->
            <c:choose>
                <c:when test="${not empty sessionScope.user}">
                    <span class="user-welcome">Welcome, ${sessionScope.user.name}</span>
                    <a href="${pageContext.request.contextPath}/logout">Logout</a>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/login.jsp">Login</a>
                    <a href="${pageContext.request.contextPath}/register.jsp">Register</a>
                </c:otherwise>
            </c:choose>
        </div>
    </nav>
</header>