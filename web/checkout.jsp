<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Checkout - Campus Marketplace</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <jsp:include page="header.jsp" />
    
    <div class="checkout-container">
        <h2>Complete Your Purchase</h2>
        
        <form action="OrderServlet" method="post">
            <div class="delivery-section">
                <h3>Delivery Method</h3>
                <label>
                    <input type="radio" name="deliveryMethod" value="pickup" checked>
                    Pickup
                </label>
                <label>
                    <input type="radio" name="deliveryMethod" value="cod">
                    Cash On Delivery (COD)
                </label>
                <div id="addressSection" style="display:none;">
                    <label>Address</label>
                    <textarea name="address" rows="3"></textarea>
                </div>
            </div>
            
            <div class="payment-section">
                <h3>Payment Method</h3>
                <label>
                    <input type="radio" name="paymentMethod" value="cash" checked>
                    Cash
                </label>
                <label>
                    <input type="radio" name="paymentMethod" value="online">
                    Online Banking
                </label>
            </div>
            
            <div class="order-summary">
                <h3>Order Summary</h3>
                <c:forEach var="item" items="${cartItems}">
                    <div class="order-item">
                        <span>${item.product.name}</span>
                        <span>RM ${item.product.price}</span>
                    </div>
                </c:forEach>
                
                <div class="total">
                    <strong>Total: RM ${total}</strong>
                </div>
            </div>
            
            <button type="submit" class="btn-place-order">Place Order</button>
        </form>
    </div>
    
    <script>
        document.querySelector('input[name="deliveryMethod"][value="cod"]').addEventListener('change', function() {
            document.getElementById('addressSection').style.display = 'block';
        });
        document.querySelector('input[name="deliveryMethod"][value="pickup"]').addEventListener('change', function() {
            document.getElementById('addressSection').style.display = 'none';
        });
    </script>
    
    <jsp:include page="footer.jsp" />
</body>
</html>