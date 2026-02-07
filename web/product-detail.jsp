<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.campusmarketplace.model.Product" %>
<%@ page import="com.campusmarketplace.model.User" %>
<%
    // Check if user is logged in
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    String userInitial = "U";
    if (user.getUsername() != null && !user.getUsername().isEmpty()) {
        userInitial = user.getUsername().substring(0, 1).toUpperCase();
    }
    
    // Get product from request attribute
    Product product = (Product) request.getAttribute("product");
    if (product == null) {
        response.sendRedirect("dashboard.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= product.getName() %> - Campus Marketplace</title>
    
    <!-- Same CSS files as dashboard -->
    <link rel="stylesheet" href="css/dashboard.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <!-- ===== NAVIGATION SECTION ===== -->
    <nav class="top-navigation">
        <div class="nav-main">
            <!-- Top Row: Logo, Search, User Menu -->
            <div class="nav-top-row">
                <div class="logo-container">
                    <a href="dashboard.jsp" class="logo">
                        <i class="fas fa-store logo-icon"></i>
                        <span class="logo-text">Campus Marketplace</span>
                    </a>
                </div>

                <div class="search-container">
                    <div class="search-box">
                        <input type="text" placeholder="Search textbooks, electronics, clothes, furniture..." id="searchInput">
                        <button class="search-btn" id="searchBtn">
                            <i class="fas fa-search"></i>
                        </button>
                    </div>
                </div>

                <div class="user-menu-top">
                    <div class="logout-container">
                        <button class="logout-btn" onclick="logout()" title="Logout">
                            <i class="fas fa-sign-out-alt"></i>
                            <span>Logout</span>
                        </button>
                    </div>
                    <div class="user-avatar-top" title="Your Profile" onclick="window.location.href='profile.jsp'">
                        <%= userInitial %>
                    </div>
                </div>
            </div>

            <!-- Bottom Row: Main Navigation -->
            <div class="nav-bottom-row">
                <div class="nav-buttons">
                    <a href="dashboard.jsp" class="nav-button">
                        <i class="fas fa-home"></i>
                        <span>Home</span>
                    </a>
                    <a href="ProductListingServlet" class="nav-button">
                        <i class="fas fa-th-large"></i>
                        <span>Browse</span>
                    </a>
                    <a href="sellProduct.jsp" class="nav-button">
                        <i class="fas fa-plus-circle"></i>
                        <span>Sell</span>
                    </a>
                    <a href="cart.jsp" class="nav-button">
                        <i class="fas fa-shopping-cart"></i>
                        <span>Cart</span>
                        <span class="nav-badge cart-badge" id="cartBadge">0</span>
                    </a>
                    <a href="messages.jsp" class="nav-button">
                        <i class="fas fa-comments"></i>
                        <span>Messages</span>
                        <span class="nav-badge message-badge" id="messageBadge">0</span>
                    </a>
                    <a href="profile.jsp" class="nav-button">
                        <i class="fas fa-user"></i>
                        <span>Profile</span>
                    </a>
                </div>
            </div>
        </div>
    </nav>

    <!-- ===== PRODUCT DETAIL SECTION ===== -->
    <div class="product-detail-container">
        <div class="product-detail-content">
            <!-- Product Images -->
            <div class="product-image-section">
                <img src="<%= product.getImageUrl() != null ? "images/" + product.getImageUrl() : "https://via.placeholder.com/600x400/f0e6ff/8a4fff?text=Product+Image" %>" 
                     alt="<%= product.getName() %>" 
                     class="product-image-large"
                     onerror="this.src='https://via.placeholder.com/600x400/f0e6ff/8a4fff?text=Product+Image'">
            </div>
            
            <!-- Product Info -->
            <div class="product-info">
                <div class="product-category-badge">
                    <%= product.getCategory() %>
                </div>
                
                <div class="stock-status <%= product.getQuantity() > 5 ? "in-stock" : product.getQuantity() > 0 ? "low-stock" : "out-of-stock" %>">
                    <i class="fas fa-<%= product.getQuantity() > 5 ? "check-circle" : product.getQuantity() > 0 ? "exclamation-circle" : "times-circle" %>"></i>
                    <%= product.getQuantity() > 5 ? "In Stock" : product.getQuantity() > 0 ? "Low Stock - Only " + product.getQuantity() + " left" : "Out of Stock" %>
                </div>
                
                <h1 class="product-title-large"><%= product.getName() %></h1>
                
                <div class="product-price-large">RM <%= String.format("%.2f", product.getPrice()) %></div>
                
                <!-- Quantity Selector -->
                <% if (product.getQuantity() > 0) { %>
                <div class="quantity-selector">
                    <div class="quantity-label">Quantity:</div>
                    <div class="quantity-controls">
                        <button class="quantity-btn" onclick="decreaseQuantity()">-</button>
                        <input type="number" id="quantity" class="quantity-input" value="1" min="1" max="<%= product.getQuantity() %>">
                        <button class="quantity-btn" onclick="increaseQuantity()">+</button>
                    </div>
                </div>
                <% } %>
                
                <div class="product-description-full">
                    <%= product.getDescription() != null ? product.getDescription().replace("\n", "<br>") : "No description available." %>
                </div>
                
                <!-- Product Meta Information -->
                <div class="product-meta-grid">
                    <div class="meta-item">
                        <i class="fas fa-box"></i>
                        <div>
                            <div class="meta-label">Available Quantity</div>
                            <div class="meta-value"><%= product.getQuantity() %> units</div>
                        </div>
                    </div>
                    
                    <div class="meta-item">
                        <i class="fas fa-map-marker-alt"></i>
                        <div>
                            <div class="meta-label">Location</div>
                            <div class="meta-value"><%= product.getLocation() != null ? product.getLocation() : "Campus Area" %></div>
                        </div>
                    </div>
                    
                    <div class="meta-item">
                        <i class="fas fa-user-graduate"></i>
                        <div>
                            <div class="meta-label">Seller</div>
                            <div class="meta-value">Student Seller</div>
                        </div>
                    </div>
                    
                    <div class="meta-item">
                        <i class="fas fa-tag"></i>
                        <div>
                            <div class="meta-label">Category</div>
                            <div class="meta-value"><%= product.getCategory() %></div>
                        </div>
                    </div>
                </div>
                
                <!-- Action Buttons -->
                <div class="action-buttons">
                    <a href="dashboard.jsp" class="btn-back">
                        <i class="fas fa-arrow-left"></i> Back to Dashboard
                    </a>
                    
                    <button class="btn-add-cart-large" 
                            id="addToCartBtn"
                            onclick="addToCart(<%= product.getId() %>, '<%= product.getName().replace("'", "\\'") %>', <%= product.getPrice() %>)"
                            <%= product.getQuantity() <= 0 ? "disabled" : "" %>>
                        <i class="fas fa-cart-plus"></i>
                        <%= product.getQuantity() <= 0 ? "Out of Stock" : "Add to Cart" %>
                    </button>
                </div>
            </div>
        </div>
    </div>

    <!-- ===== JAVASCRIPT ===== -->
    <script>
        // Initialize cart count
        document.addEventListener('DOMContentLoaded', function() {
            updateCartCount(0);
            updateMessageCount(0);
        });
        
        // Quantity controls
        function increaseQuantity() {
            const input = document.getElementById('quantity');
            const max = parseInt(input.max);
            let value = parseInt(input.value) || 1;
            
            if (value < max) {
                input.value = value + 1;
            }
        }
        
        function decreaseQuantity() {
            const input = document.getElementById('quantity');
            let value = parseInt(input.value) || 1;
            
            if (value > 1) {
                input.value = value - 1;
            }
        }
        
        // Update quantity input when manually changed
        const quantityInput = document.getElementById('quantity');
        if (quantityInput) {
            quantityInput.addEventListener('change', function() {
                let value = parseInt(this.value) || 1;
                const max = parseInt(this.max);
                const min = parseInt(this.min);
                
                if (value < min) value = min;
                if (value > max) value = max;
                
                this.value = value;
            });
        }
        
        // Add to cart function with quantity
        function addToCart(productId, productName, price) {
            const quantityInput = document.getElementById('quantity');
            const quantity = quantityInput ? parseInt(quantityInput.value) || 1 : 1;
            
            fetch('AddToCartServlet', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: 'productId=' + productId + '&quantity=' + quantity
            })
            .then(function(response) { return response.json(); })
            .then(function(data) {
                if (data.success) {
                    showNotification('Added ' + quantity + ' x "' + productName + '" to cart!', 'success');
                    updateCartCount(data.cartCount || 0);
                } else {
                    showNotification('Error: ' + data.message, 'error');
                }
            })
            .catch(function(error) {
                console.error('Error:', error);
                showNotification('Error adding to cart. Please try again.', 'error');
            });
        }
        
        // Update badge counts
        function updateCartCount(count) {
            const cartBadge = document.getElementById('cartBadge');
            if (cartBadge) {
                cartBadge.textContent = count;
                cartBadge.style.display = count > 0 ? 'flex' : 'none';
            }
        }
        
        function updateMessageCount(count) {
            const messageBadge = document.getElementById('messageBadge');
            if (messageBadge) {
                messageBadge.textContent = count;
                messageBadge.style.display = count > 0 ? 'flex' : 'none';
            }
        }
        
        // Show notification
        function showNotification(message, type) {
            const notification = document.createElement('div');
            notification.className = 'notification ' + type;
            
            var iconClass = type === 'success' ? 'check-circle' : 'info-circle';
            notification.innerHTML = '<i class="fas fa-' + iconClass + '"></i><span>' + message + '</span>';
            
            document.body.appendChild(notification);
            
            setTimeout(function() { notification.classList.add('show'); }, 10);
            
            setTimeout(function() {
                notification.classList.remove('show');
                setTimeout(function() { notification.remove(); }, 300);
            }, 3000);
        }
        
        // Logout function
        function logout() {
            if (confirm('Are you sure you want to logout?')) {
                window.location.href = 'LogoutServlet';
            }
        }
        
        // Search functionality
        document.getElementById('searchBtn').addEventListener('click', performSearch);
        document.getElementById('searchInput').addEventListener('keypress', function(e) {
            if (e.key === 'Enter') {
                performSearch();
            }
        });
        
        function performSearch() {
            const searchInput = document.getElementById('searchInput');
            const query = searchInput.value.trim();
            
            if (query) {
                window.location.href = 'ProductListingServlet?search=' + encodeURIComponent(query);
            }
        }
        
        // Handle Enter key in quantity input
        if (quantityInput) {
            quantityInput.addEventListener('keypress', function(e) {
                if (e.key === 'Enter') {
                    const addToCartBtn = document.getElementById('addToCartBtn');
                    if (addToCartBtn && !addToCartBtn.disabled) {
                        addToCartBtn.click();
                    }
                }
            });
        }
    </script>
</body>
</html>