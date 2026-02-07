<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Browse Products - Campus Marketplace</title>
    
    <!-- Use the same CSS as dashboard -->
    <link rel="stylesheet" href="css/dashboard.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        /* Only add styles specific to product listing page */
        .main-container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 20px;
        }
        
        /* Page Header */
        .page-header {
            background: linear-gradient(135deg, var(--primary-purple), var(--light-purple));
            color: white;
            padding: 2.5rem;
            margin-bottom: 2rem;
            border-radius: 15px;
            box-shadow: var(--shadow-medium);
            text-align: center;
        }
        
        .page-header h1 {
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
        }
        
        .page-header p {
            font-size: 1.1rem;
            opacity: 0.9;
            max-width: 600px;
            margin: 0 auto;
        }
        
        /* Products Layout */
        .products-layout {
            display: grid;
            grid-template-columns: 250px 1fr;
            gap: 30px;
        }
        
        @media (max-width: 1200px) {
            .products-layout {
                grid-template-columns: 1fr;
            }
        }
        
        /* Categories Sidebar */
        .categories-sidebar {
            background: var(--card-bg);
            border-radius: 15px;
            padding: 20px;
            box-shadow: var(--shadow-light);
            border: 1px solid var(--border-color);
            height: fit-content;
        }
        
        .categories-sidebar h2 {
            color: var(--primary-purple);
            font-size: 1.2rem;
            margin-bottom: 15px;
            display: flex;
            align-items: center;
            gap: 8px;
            padding-bottom: 12px;
            border-bottom: 1px solid var(--border-color);
        }
        
        .category-list {
            display: flex;
            flex-direction: column;
            gap: 8px;
        }
        
        .category-item {
            padding: 10px 15px;
            background: var(--light-bg);
            border: 1px solid var(--border-color);
            border-radius: 10px;
            color: var(--text-dark);
            font-size: 0.9rem;
            font-weight: 500;
            cursor: pointer;
            text-decoration: none;
            transition: all 0.3s;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        
        .category-item:hover {
            background: var(--pale-purple);
            border-color: var(--primary-purple);
        }
        
        .category-item.active {
            background: var(--primary-purple);
            color: white;
            border-color: var(--primary-purple);
        }
        
        /* Products Header */
        .products-header {
            background: var(--card-bg);
            border-radius: 15px;
            padding: 20px;
            box-shadow: var(--shadow-light);
            border: 1px solid var(--border-color);
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }
        
        .products-header h2 {
            color: var(--text-dark);
            font-size: 1.4rem;
            margin: 0;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .sort-filter {
            display: flex;
            align-items: center;
            gap: 15px;
        }
        
        .sort-select {
            padding: 8px 12px;
            border: 1px solid var(--border-color);
            border-radius: 8px;
            background: var(--light-bg);
            color: var(--text-dark);
            font-size: 0.85rem;
            cursor: pointer;
            outline: none;
        }
        
        .sort-select:focus {
            border-color: var(--primary-purple);
        }
        
        .view-toggles {
            display: flex;
            gap: 8px;
            background: var(--light-bg);
            padding: 6px;
            border-radius: 10px;
            border: 1px solid var(--border-color);
        }
        
        .view-toggle {
            width: 36px;
            height: 36px;
            border: none;
            background: none;
            border-radius: 8px;
            cursor: pointer;
            color: var(--text-light);
            font-size: 1rem;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: all 0.3s;
        }
        
        .view-toggle:hover {
            background: var(--pale-purple);
            color: var(--primary-purple);
        }
        
        .view-toggle.active {
            background: var(--primary-purple);
            color: white;
            box-shadow: 0 2px 8px rgba(138, 79, 255, 0.3);
        }
        
        /* No Products Message */
        .no-products {
            grid-column: 1 / -1;
            text-align: center;
            padding: 60px 20px;
        }
        
        .no-products i {
            font-size: 48px;
            color: var(--light-purple);
            margin-bottom: 20px;
            opacity: 0.7;
        }
        
        .no-products h3 {
            color: var(--text-dark);
            font-size: 1.3rem;
            margin-bottom: 10px;
        }
        
        .no-products p {
            color: var(--text-light);
            font-size: 0.95rem;
            max-width: 400px;
            margin: 0 auto 25px;
        }
        
        /* Products Grid - Use same as dashboard */
        .products-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 25px;
        }
        
        /* List View */
        .products-grid.list-view {
            display: flex;
            flex-direction: column;
            gap: 15px;
        }
        
        /* Products Container */
        .products-container {
            background: var(--card-bg);
            border-radius: 15px;
            padding: 25px;
            box-shadow: var(--shadow-light);
            border: 1px solid var(--border-color);
        }
        
        /* Search Form */
        #searchForm {
            display: flex;
            width: 100%;
        }
        
        #searchForm input {
            flex: 1;
        }
    </style>
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
                        <form action="ProductListingServlet" method="get" id="searchForm">
                            <input type="text" name="search" placeholder="Search textbooks, electronics, clothes, furniture..." 
                                   id="searchInput" value="${param.search}">
                            <button type="submit" class="search-btn" id="searchBtn">
                                <i class="fas fa-search"></i>
                            </button>
                        </form>
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
                    <a href="ProductListingServlet" class="nav-button active">
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

    <!-- ===== MAIN CONTENT SECTION ===== -->
    <div class="main-container">
        <!-- Page Header -->
        <div class="page-header">
            <h1>Browse Products</h1>
            <p>Discover amazing deals from fellow students. Find textbooks, electronics, furniture and more!</p>
        </div>

        <!-- Products Layout -->
        <div class="products-layout">
            <!-- Categories Sidebar -->
            <div class="categories-sidebar">
                <h2><i class="fas fa-filter"></i> Categories</h2>
                <div class="category-list">
                    <a href="ProductListingServlet" class="category-item ${empty param.category or param.category == 'all' ? 'active' : ''}">
                        <i class="fas fa-th-large"></i> All Items
                    </a>
                    <a href="ProductListingServlet?category=Electronics" class="category-item ${param.category == 'Electronics' ? 'active' : ''}">
                        <i class="fas fa-laptop"></i> Electronics
                    </a>
                    <a href="ProductListingServlet?category=Books" class="category-item ${param.category == 'Books' ? 'active' : ''}">
                        <i class="fas fa-book"></i> Books
                    </a>
                    <a href="ProductListingServlet?category=Clothing" class="category-item ${param.category == 'Clothing' ? 'active' : ''}">
                        <i class="fas fa-tshirt"></i> Clothing
                    </a>
                    <a href="ProductListingServlet?category=Furniture" class="category-item ${param.category == 'Furniture' ? 'active' : ''}">
                        <i class="fas fa-couch"></i> Furniture
                    </a>
                    <a href="ProductListingServlet?category=Sports" class="category-item ${param.category == 'Sports' ? 'active' : ''}">
                        <i class="fas fa-basketball-ball"></i> Sports
                    </a>
                    <a href="ProductListingServlet?category=Accessories" class="category-item ${param.category == 'Accessories' ? 'active' : ''}">
                        <i class="fas fa-gem"></i> Accessories
                    </a>
                    <a href="ProductListingServlet?category=Services" class="category-item ${param.category == 'Services' ? 'active' : ''}">
                        <i class="fas fa-concierge-bell"></i> Services
                    </a>
                </div>
            </div>

            <!-- Products Main Content -->
            <div class="products-main">
                <!-- Products Header -->
                <div class="products-header">
                    <div class="header-left">
                        <h2><i class="fas fa-box"></i> 
                            <c:choose>
                                <c:when test="${not empty param.category and param.category != 'all'}">
                                    ${param.category}
                                </c:when>
                                <c:otherwise>
                                    All Products
                                </c:otherwise>
                            </c:choose>
                        </h2>
                        <div class="product-count">
                            <span id="displayCount">
                                <c:choose>
                                    <c:when test="${not empty products}">
                                        ${products.size()} products
                                    </c:when>
                                    <c:otherwise>
                                        0 products
                                    </c:otherwise>
                                </c:choose>
                            </span>
                        </div>
                    </div>
                    <div class="header-right">
                        <div class="filter-options">
                            <select class="filter-select" id="sortSelect">
                                <option value="newest">Newest First</option>
                                <option value="price-low">Price: Low to High</option>
                                <option value="price-high">Price: High to Low</option>
                            </select>
                            <div class="view-toggles">
                                <button class="view-toggle active" data-view="grid">
                                    <i class="fas fa-th-large"></i>
                                </button>
                                <button class="view-toggle" data-view="list">
                                    <i class="fas fa-list"></i>
                                </button>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Products Display -->
                <div class="products-container">
                    <c:choose>
                        <c:when test="${not empty products}">
                            <div class="products-grid" id="productsGrid">
                                <c:forEach var="product" items="${products}">
                                    <div class="product-card" data-category="${product.category}" data-price="${product.price}">
                                        <!-- Product Image -->
                                        <div class="product-image-container">
                                            <c:choose>
                                                <c:when test="${not empty product.imageUrl}">
                                                    <img src="images/${product.imageUrl}" alt="${product.name}" 
                                                         class="product-image" 
                                                         onerror="this.src='https://via.placeholder.com/300x200/f0e6ff/8a4fff?text=Product+Image'">
                                                </c:when>
                                                <c:otherwise>
                                                    <img src="https://via.placeholder.com/300x200/f0e6ff/8a4fff?text=Product+Image" 
                                                         alt="${product.name}" class="product-image">
                                                </c:otherwise>
                                            </c:choose>
                                            
                                            <!-- Product Badges -->
                                            <div class="product-badges">
                                                <c:if test="${product.quantity <= 1 && product.quantity > 0}">
                                                    <span class="product-badge low-stock">
                                                        <i class="fas fa-bolt"></i> Low Stock
                                                    </span>
                                                </c:if>
                                                <c:if test="${product.quantity <= 0}">
                                                    <span class="product-badge sold-out">
                                                        <i class="fas fa-times"></i> Sold Out
                                                    </span>
                                                </c:if>
                                            </div>
                                            
                                            <!-- Quick Actions -->
                                            <div class="quick-actions">
                                                <button class="quick-action-btn wishlist-btn" title="Add to Wishlist">
                                                    <i class="far fa-heart"></i>
                                                </button>
                                            </div>
                                        </div>
                                        
                                        <!-- Product Content -->
                                        <div class="product-content">
                                            <!-- Category & Seller -->
                                            <div class="product-meta-top">
                                                <span class="product-category">${product.category}</span>
                                                <span class="product-seller">
                                                    <i class="fas fa-user-graduate"></i> Student Seller
                                                </span>
                                            </div>
                                            
                                            <!-- Product Title -->
                                            <h3 class="product-title" title="${product.name}">
                                                ${product.name}
                                            </h3>
                                            
                                            <!-- Product Description -->
                                            <p class="product-description">
                                                <c:choose>
                                                    <c:when test="${not empty product.description and product.description.length() > 60}">
                                                        ${fn:escapeXml(product.description.substring(0, 60))}...
                                                    </c:when>
                                                    <c:when test="${not empty product.description}">
                                                        ${fn:escapeXml(product.description)}
                                                    </c:when>
                                                    <c:otherwise>
                                                        No description available
                                                    </c:otherwise>
                                                </c:choose>
                                            </p>
                                            
                                            <!-- Price & Stock -->
                                            <div class="product-price-section">
                                                <div class="price-container">
                                                    <span class="current-price">RM ${String.format("%.2f", product.price)}</span>
                                                    <c:if test="${product.quantity > 0}">
                                                        <span class="stock-info">
                                                            <i class="fas fa-check-circle"></i> 
                                                            ${product.quantity} available
                                                        </span>
                                                    </c:if>
                                                </div>
                                                <div class="location-info">
                                                    <i class="fas fa-map-marker-alt"></i>
                                                    <span>
                                                        <c:choose>
                                                            <c:when test="${not empty product.location}">
                                                                ${product.location}
                                                            </c:when>
                                                            <c:otherwise>
                                                                Campus Location
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </span>
                                                </div>
                                            </div>
                                            
                                            <!-- Action Buttons -->
                                            <div class="product-actions">
                                                <button class="btn-view-details" onclick="viewProduct(${product.id})">
                                                    <i class="fas fa-eye"></i> View Details
                                                </button>
                                                <button class="btn-add-cart" 
                                                        onclick="addToCart(${product.id}, '${fn:replace(product.name, "'", "\\'")}', ${product.price})"
                                                        <c:if test="${product.quantity <= 0}">disabled</c:if>>
                                                    <i class="fas fa-cart-plus"></i> 
                                                    <c:choose>
                                                        <c:when test="${product.quantity <= 0}">Sold Out</c:when>
                                                        <c:otherwise>Add to Cart</c:otherwise>
                                                    </c:choose>
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <!-- No Products Message -->
                            <div class="no-products">
                                <i class="fas fa-search"></i>
                                <h3>No Products Found</h3>
                                <p>
                                    <c:choose>
                                        <c:when test="${not empty param.search}">
                                            No products found for "${param.search}". Try a different search term.
                                        </c:when>
                                        <c:when test="${not empty param.category}">
                                            No products found in ${param.category} category.
                                        </c:when>
                                        <c:otherwise>
                                            No products available. Be the first to list an item!
                                        </c:otherwise>
                                    </c:choose>
                                </p>
                                <button class="browse-btn" onclick="window.location.href='sellProduct.jsp'">
                                    <i class="fas fa-plus-circle"></i> Sell Your First Item
                                </button>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>

    <!-- ===== FOOTER SECTION ===== -->
    <footer class="dashboard-footer">
        <div class="footer-content">
            <div class="footer-grid">
                <div class="footer-column">
                    <h3><i class="fas fa-store"></i> Campus Marketplace</h3>
                    <p>Your go-to platform for buying and selling campus essentials. Connect with students, save money, and make your campus life easier.</p>
                </div>
                <div class="footer-column">
                    <h4>Quick Links</h4>
                    <div class="footer-links">
                        <a href="dashboard.jsp"><i class="fas fa-home"></i> Home</a>
                        <a href="about.jsp"><i class="fas fa-info-circle"></i> About</a>
                        <a href="contact.jsp"><i class="fas fa-envelope"></i> Contact</a>
                        <a href="faq.jsp"><i class="fas fa-question-circle"></i> FAQ</a>
                    </div>
                </div>
                <div class="footer-column">
                    <h4>Contact Info</h4>
                    <div class="footer-links">
                        <a href="mailto:support@campusmarket.edu"><i class="fas fa-envelope"></i> support@campusmarket.edu</a>
                        <a href="tel:1234567890"><i class="fas fa-phone"></i> (123) 456-7890</a>
                        <a><i class="fas fa-map-marker-alt"></i> University Student Center</a>
                    </div>
                </div>
            </div>
            <div class="footer-bottom">
                <p>&copy; 2024 Campus Marketplace. All rights reserved. | Designed for Students, By Students</p>
            </div>
        </div>
    </footer>

    <!-- ===== JAVASCRIPT FUNCTIONS ===== -->
    <script>
        // Main initialization
        document.addEventListener('DOMContentLoaded', function() {
            initializeProductPage();
            updateCartCount(0);
            updateMessageCount(0);
        });

        // Initialize product page
        function initializeProductPage() {
            setupViewControls();
            setupSorting();
            setupSearchFunctionality();
        }

        // View toggle functionality
        function setupViewControls() {
            const viewToggles = document.querySelectorAll('.view-toggle');
            const productsGrid = document.getElementById('productsGrid');
            
            if (viewToggles.length > 0 && productsGrid) {
                viewToggles.forEach(toggle => {
                    toggle.addEventListener('click', function() {
                        viewToggles.forEach(t => t.classList.remove('active'));
                        this.classList.add('active');
                        
                        const view = this.dataset.view;
                        if (view === 'list') {
                            productsGrid.classList.add('list-view');
                        } else {
                            productsGrid.classList.remove('list-view');
                        }
                    });
                });
            }
        }

        // Sorting functionality
        function setupSorting() {
            const sortSelect = document.getElementById('sortSelect');
            if (sortSelect) {
                sortSelect.addEventListener('change', function() {
                    const sortBy = this.value;
                    sortProducts(sortBy);
                });
            }
        }

        // Sort products
        function sortProducts(sortBy) {
            const productsGrid = document.getElementById('productsGrid');
            if (!productsGrid) return;
            
            const products = Array.from(productsGrid.querySelectorAll('.product-card'));
            
            products.sort((a, b) => {
                const priceA = parseFloat(a.dataset.price) || 0;
                const priceB = parseFloat(b.dataset.price) || 0;
                
                switch(sortBy) {
                    case 'price-low':
                        return priceA - priceB;
                    case 'price-high':
                        return priceB - priceA;
                    case 'newest':
                    default:
                        return 0; // Maintain original order
                }
            });
            
            // Re-append sorted products
            products.forEach(product => {
                productsGrid.appendChild(product);
            });
        }

        // Search functionality
        function setupSearchFunctionality() {
            const searchBtn = document.getElementById('searchBtn');
            const searchInput = document.getElementById('searchInput');
            
            if (searchBtn) {
                searchBtn.addEventListener('click', function(e) {
                    e.preventDefault();
                    performSearch();
                });
            }
            
            if (searchInput) {
                searchInput.addEventListener('keypress', function(e) {
                    if (e.key === 'Enter') {
                        e.preventDefault();
                        performSearch();
                    }
                });
            }
        }

        // Perform search
        function performSearch() {
            const searchInput = document.getElementById('searchInput');
            const query = searchInput.value.trim();
            
            if (query) {
                window.location.href = 'ProductListingServlet?search=' + encodeURIComponent(query);
            } else {
                window.location.href = 'ProductListingServlet';
            }
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

        // Logout function
        function logout() {
            if (confirm('Are you sure you want to logout?')) {
                window.location.href = 'LogoutServlet';
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

        // Product functions
        function viewProduct(productId) {
            window.location.href = 'ProductDetailServlet?id=' + productId;
        }
        
        function addToCart(productId, productName, price) {
            fetch('AddToCartServlet', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: 'productId=' + productId + '&quantity=1'
            })
            .then(function(response) { return response.json(); })
            .then(function(data) {
                if (data.success) {
                    showNotification('Added "' + productName + '" to cart!', 'success');
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
    </script>
</body>
</html>