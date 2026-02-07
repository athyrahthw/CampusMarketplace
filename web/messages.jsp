<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Message - Campus Marketplace</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
        .message-container {
            max-width: 600px;
            margin: 50px auto;
            padding: 2rem;
            text-align: center;
            background-color: #f9f9f9;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        
        .message-icon {
            font-size: 4rem;
            margin-bottom: 1rem;
        }
        
        .success { color: #2ecc71; }
        .error { color: #e74c3c; }
        .info { color: #3498db; }
        .warning { color: #f39c12; }
        
        .message-title {
            font-size: 1.8rem;
            margin-bottom: 1rem;
        }
        
        .message-content {
            font-size: 1.1rem;
            margin-bottom: 2rem;
            line-height: 1.6;
        }
        
        .action-buttons {
            display: flex;
            gap: 1rem;
            justify-content: center;
            flex-wrap: wrap;
        }
        
        .btn {
            padding: 0.8rem 1.5rem;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            font-size: 1rem;
            transition: background-color 0.3s;
        }
        
        .btn-primary {
            background-color: #3498db;
            color: white;
        }
        
        .btn-secondary {
            background-color: #95a5a6;
            color: white;
        }
        
        .btn:hover {
            opacity: 0.9;
        }
    </style>
</head>
<body>
    <jsp:include page="header.jsp" />
    
    <div class="message-container">
        <!-- Check for message type and display appropriate icon -->
        <c:choose>
            <c:when test="${not empty param.type && param.type == 'success'}">
                <div class="message-icon success">✓</div>
                <h2 class="message-title">Success!</h2>
            </c:when>
            <c:when test="${not empty param.type && param.type == 'error'}">
                <div class="message-icon error">✗</div>
                <h2 class="message-title">Error!</h2>
            </c:when>
            <c:when test="${not empty param.type && param.type == 'warning'}">
                <div class="message-icon warning">⚠</div>
                <h2 class="message-title">Warning!</h2>
            </c:when>
            <c:otherwise>
                <div class="message-icon info">ℹ</div>
                <h2 class="message-title">Message</h2>
            </c:otherwise>
        </c:choose>
        
        <!-- Display message from parameter -->
        <div class="message-content">
            <c:choose>
                <c:when test="${not empty param.message}">
                    ${param.message}
                </c:when>
                <c:otherwise>
                    <c:choose>
                        <c:when test="${not empty param.type && param.type == 'success'}">
                            Your action was completed successfully!
                        </c:when>
                        <c:when test="${not empty param.type && param.type == 'error'}">
                            An error occurred. Please try again.
                        </c:when>
                        <c:otherwise>
                            Here is your message.
                        </c:otherwise>
                    </c:choose>
                </c:otherwise>
            </c:choose>
        </div>
        
        <!-- Action buttons -->
        <div class="action-buttons">
            <c:choose>
                <c:when test="${not empty param.redirect && param.redirect == 'home'}">
                    <a href="index.jsp" class="btn btn-primary">Go to Home</a>
                </c:when>
                <c:when test="${not empty param.redirect && param.redirect == 'cart'}">
                    <a href="cart.jsp" class="btn btn-primary">Back to Cart</a>
                </c:when>
                <c:when test="${not empty param.redirect && param.redirect == 'products'}">
                    <a href="products.jsp" class="btn btn-primary">Continue Shopping</a>
                </c:when>
                <c:otherwise>
                    <a href="index.jsp" class="btn btn-primary">Go to Home</a>
                </c:otherwise>
            </c:choose>
            
            <c:if test="${not empty param.back && param.back == 'true'}">
                <button onclick="window.history.back()" class="btn btn-secondary">Go Back</button>
            </c:if>
        </div>
    </div>
    
    <jsp:include page="footer.jsp" />
    
    <!-- Auto-redirect after 5 seconds if redirect URL is provided -->
    <c:if test="${not empty param.redirectUrl}">
        <script>
            setTimeout(function() {
                window.location.href = "${param.redirectUrl}";
            }, 5000); // 5 seconds
        </script>
    </c:if>
</body>
</html>