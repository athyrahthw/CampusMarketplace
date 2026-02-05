<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Sell Product - Campus Marketplace</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <jsp:include page="header.jsp" />
    
    <div class="sell-form-container">
        <h2>Enter your item information for sale</h2>
        
        <form action="ProductServlet" method="post" enctype="multipart/form-data">
            <div class="upload-section">
                <label for="productImage">Upload your item photo</label>
                <input type="file" id="productImage" name="productImage" accept="image/*" required>
            </div>
            
            <div class="form-group">
                <label for="productName">Product Name</label>
                <input type="text" id="productName" name="productName" required>
            </div>
            
            <div class="form-group">
                <label for="price">Price (RM)</label>
                <input type="number" id="price" name="price" step="0.01" required>
            </div>
            
            <div class="form-group">
                <label for="description">Product Description</label>
                <textarea id="description" name="description" rows="4" required></textarea>
            </div>
            
            <div class="form-group">
                <label for="category">Category</label>
                <select id="category" name="category" required>
                    <option value="">Select Category</option>
                    <option value="Rent">Rent</option>
                    <option value="Trade">Trade</option>
                    <option value="Sell">Sell</option>
                </select>
            </div>
            
            <div class="form-group">
                <label for="paymentOption">Payment Option</label>
                <select id="paymentOption" name="paymentOption" required>
                    <option value="">Select Payment</option>
                    <option value="Cash">Cash</option>
                    <option value="Online Banking">Online Banking</option>
                    <option value="Both">Both</option>
                </select>
            </div>
            
            <div class="form-group">
                <label for="location">Location</label>
                <input type="text" id="location" name="location" required>
            </div>
            
            <button type="submit" class="btn-sell">Start Sell</button>
        </form>
    </div>
    
    <jsp:include page="footer.jsp" />
</body>
</html>