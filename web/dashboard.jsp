<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.campusmarketplace.dao.ProductDAO" %>
<%@ page import="com.campusmarketplace.model.Product" %>
<%@ page import="com.campusmarketplace.model.User" %>
<%@ page import="java.util.List" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%
    // Check if user is logged in
    User user = (User) session.getAttribute("user");
    if (user == null) {
        // If no user in session, redirect to login
        response.sendRedirect("login.jsp");
        return;
    }
    
    String userInitial = "U";
    if (user.getUsername() != null && !user.getUsername().isEmpty()) {
        userInitial = user.getUsername().substring(0, 1).toUpperCase();
    }
    
    // Load products from database
    ProductDAO productDAO = new ProductDAO();
    List<Product> products = null;
    String error = null;
    
    try {
        products = productDAO.getAllProducts();
        
        // If no products, set empty list
        if (products == null) {
            products = new java.util.ArrayList<>();
        }
        
    } catch (Exception e) {
        error = "Unable to load products from database. Please try again later.";
        System.err.println("Error loading products: " + e.getMessage());
        e.printStackTrace();
        products = new java.util.ArrayList<>();
    }
    
    // Store in page context for JSTL
    pageContext.setAttribute("products", products);
    pageContext.setAttribute("error", error);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - Campus Marketplace</title>
    
    <!-- External CSS Links -->
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
                    <!-- Added Logout Button -->
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
                    <a href="dashboard.jsp" class="nav-button active">
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

    <!-- ===== MAIN CONTENT SECTION ===== -->
    <div class="main-container">
        <!-- Welcome Banner -->
        <div class="welcome-header">
            <h1>Welcome to Campus Marketplace, <%= user.getUsername() %>!</h1>
            <p>Buy, sell, and trade with fellow students. Find great deals on textbooks, electronics, furniture and more!</p>
        </div>

        <!-- Dashboard Content Area -->
        <div class="dashboard-layout">
            <!-- Main Content: Products -->
            <main class="dashboard-main">
                <!-- Products Header with Filter -->
                <header class="products-header">
                    <div class="header-left">
                        <h2><i class="fas fa-box"></i> All Products</h2>
                        <div class="product-count">
                            <span id="displayCount">${products.size()} products available</span>
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
                </header>

                <!-- Categories Filter (Moved to top) -->
                <section class="categories-section">
                    <h3><i class="fas fa-filter"></i> Browse Categories</h3>
                    <div class="category-grid">
                        <div class="category-chip active" data-category="all">All Items</div>
                        <div class="category-chip" data-category="Electronics">Electronics</div>
                        <div class="category-chip" data-category="Books">Books</div>
                        <div class="category-chip" data-category="Clothing">Clothing</div>
                        <div class="category-chip" data-category="Furniture">Furniture</div>
                        <div class="category-chip" data-category="Sports">Sports</div>
                        <div class="category-chip" data-category="Accessories">Accessories</div>
                        <div class="category-chip" data-category="Services">Services</div>
                    </div>
                </section>

                <!-- Products Display -->
                <section class="products-display">
                    <!-- Empty state for filtered categories -->
                    <div class="products-empty no-category-products" style="display: none;">
                        <i class="fas fa-search"></i>
                        <h3>No Products Found</h3>
                        <p id="category-empty-message">No products found in this category.</p>
                        <button class="browse-btn" onclick="resetCategoryFilter()">
                            <i class="fas fa-undo"></i> Show All Products
                        </button>
                    </div>
                    
                    <c:choose>
                        <c:when test="${not empty error}">
                            <div class="products-empty error-state">
                                <i class="fas fa-exclamation-triangle"></i>
                                <h3>Database Error</h3>
                                <p>${error}</p>
                                <button class="browse-btn" onclick="window.location.href='ProductListingServlet'">
                                    <i class="fas fa-search"></i> Browse Products
                                </button>
                            </div>
                        </c:when>
                        
                        <c:when test="${empty products}">
                            <div class="products-empty">
                                <i class="fas fa-box-open"></i>
                                <h3>No Products Available</h3>
                                <p>There are no products in the database yet. Be the first to list an item!</p>
                                <div class="empty-actions">
                                    <button class="browse-btn" onclick="window.location.href='sellProduct.jsp'">
                                        <i class="fas fa-plus-circle"></i> Sell Your First Item
                                    </button>
                                </div>
                            </div>
                        </c:when>
                        
                        <c:otherwise>
                            <div class="products-grid" id="productsGrid">
                                <c:forEach var="product" items="${products}" varStatus="status">
                                    <c:if test="${status.index < 12}"> <!-- Limit to 12 products for dashboard -->
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
                                                    <c:if test="${product.quantity <= 1}">
                                                        <span class="product-badge low-stock">
                                                            <i class="fas fa-bolt"></i> Low Stock
                                                        </span>
                                                    </c:if>
                                                    <c:if test="${product.quantity <= 0}">
                                                        <span class="product-badge sold-out">
                                                            <i class="fas fa-times"></i> Sold Out
                                                        </span>
                                                    </c:if>
                                                    <c:if test="${status.index < 3}">
                                                        <span class="product-badge trending">
                                                            <i class="fas fa-fire"></i> Trending
                                                        </span>
                                                    </c:if>
                                                </div>
                                                
                                                <!-- Quick Actions -->
                                                <div class="quick-actions">
                                                    <button class="quick-action-btn wishlist-btn" title="Add to Wishlist">
                                                        <i class="far fa-heart"></i>
                                                    </button>
                                                    <button class="quick-action-btn compare-btn" title="Compare">
                                                        <i class="fas fa-exchange-alt"></i>
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
                                                
                                                <!-- Product Rating (Placeholder) -->
                                                <div class="product-rating">
                                                    <div class="stars">
                                                        <i class="fas fa-star"></i>
                                                        <i class="fas fa-star"></i>
                                                        <i class="fas fa-star"></i>
                                                        <i class="fas fa-star"></i>
                                                        <i class="far fa-star"></i>
                                                    </div>
                                                    <span class="rating-count">(0)</span>
                                                </div>
                                                
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
                                    </c:if>
                                </c:forEach>
                            </div>
                            
                            <!-- View More Button -->
                            <c:if test="${products.size() > 12}">
                                <div class="view-more-section">
                                    <button class="view-more-btn" onclick="window.location.href='ProductListingServlet'">
                                        <i class="fas fa-arrow-right"></i>
                                        View All ${products.size()} Products
                                    </button>
                                </div>
                            </c:if>
                        </c:otherwise>
                    </c:choose>
                </section>
            </main>
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
            initializeDashboard();
        });

        // Dashboard initialization
        function initializeDashboard() {
            setupCategoryFilter();
            setupViewControls();
            setupSearchFunctionality();
            setupSorting();
            setupQuickActions();
            
            // Initialize counts
            updateCartCount(0);
            updateMessageCount(0);
        }

        // Category filtering functionality with empty state - FIXED
        function setupCategoryFilter() {
            const categoryChips = document.querySelectorAll('.category-chip');
            const noCategoryMessage = document.querySelector('.no-category-products');
            const productsGrid = document.getElementById('productsGrid');
            const viewMoreSection = document.querySelector('.view-more-section');
            const productsEmpty = document.querySelector('.products-empty:not(.no-category-products)');
            
            // Hide the empty category message initially
            if (noCategoryMessage) {
                noCategoryMessage.style.display = 'none';
            }
            
            categoryChips.forEach(chip => {
                chip.addEventListener('click', function() {
                    const category = this.dataset.category;
                    
                    // Update active chip
                    categoryChips.forEach(c => c.classList.remove('active'));
                    this.classList.add('active');
                    
                    // Filter products
                    const allProducts = document.querySelectorAll('.product-card');
                    let visibleCount = 0;
                    
                    allProducts.forEach(product => {
                        if (category === 'all' || product.dataset.category === category) {
                            product.style.display = 'flex';
                            visibleCount++;
                        } else {
                            product.style.display = 'none';
                        }
                    });
                    
                    // Update display count
                    document.getElementById('displayCount').textContent = visibleCount + ' products available';
                    
                    // Show/hide empty state message - FIXED LOGIC
                    if (visibleCount === 0 && category !== 'all') {
                        document.getElementById('category-empty-message').textContent = 
                            'No products found in ' + category + ' category.';
                        
                        // Hide all other content
                        if (productsGrid) productsGrid.style.display = 'none';
                        if (viewMoreSection) viewMoreSection.style.display = 'none';
                        if (productsEmpty) productsEmpty.style.display = 'none';
                        
                        // Show empty category message
                        if (noCategoryMessage) {
                            noCategoryMessage.style.display = 'flex';
                        }
                    } else {
                        // Show normal content
                        if (noCategoryMessage) noCategoryMessage.style.display = 'none';
                        if (productsGrid) productsGrid.style.display = 'grid';
                        if (viewMoreSection) viewMoreSection.style.display = 'block';
                        if (productsEmpty) productsEmpty.style.display = 'none';
                    }
                });
            });
        }

        // Reset category filter
        function resetCategoryFilter() {
            const allFilter = document.querySelector('.category-chip[data-category="all"]');
            if (allFilter) {
                allFilter.click();
            }
        }

        // View toggle functionality
        function setupViewControls() {
            const viewToggles = document.querySelectorAll('.view-toggle');
            const productsGrid = document.getElementById('productsGrid');
            
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

        // Sorting functionality - FIXED
        function setupSorting() {
            const sortSelect = document.getElementById('sortSelect');
            if (sortSelect) {
                sortSelect.addEventListener('change', function() {
                    const sortBy = this.value;
                    sortProducts(sortBy);
                });
            }
        }

        // Sort products - FIXED with better sorting
        function sortProducts(sortBy) {
            const productsGrid = document.getElementById('productsGrid');
            const products = Array.from(productsGrid.querySelectorAll('.product-card'));
            
            products.sort((a, b) => {
                const priceA = parseFloat(a.dataset.price) || 0;
                const priceB = parseFloat(b.dataset.price) || 0;
                const indexA = parseInt(a.dataset.index) || 0;
                const indexB = parseInt(b.dataset.index) || 0;
                
                switch(sortBy) {
                    case 'price-low':
                        return priceA - priceB;
                    case 'price-high':
                        return priceB - priceA;
                    case 'newest':
                        // Since we don't have dates, sort by reverse order (newest added at end)
                        return indexB - indexA; // Changed to make newest first
                    default:
                        return 0;
                }
            });
            
            // Re-append sorted products
            products.forEach(product => {
                productsGrid.appendChild(product);
            });
        }

        // Quick actions (wishlist, compare)
        function setupQuickActions() {
            // Wishlist buttons
            document.querySelectorAll('.wishlist-btn').forEach(btn => {
                btn.addEventListener('click', function(e) {
                    e.stopPropagation();
                    this.classList.toggle('active');
                    this.innerHTML = this.classList.contains('active') ? 
                        '<i class="fas fa-heart"></i>' : 
                        '<i class="far fa-heart"></i>';
                    
                    // Show notification
                    showNotification('Added to wishlist!', 'success');
                });
            });
            
            // Compare buttons
            document.querySelectorAll('.compare-btn').forEach(btn => {
                btn.addEventListener('click', function(e) {
                    e.stopPropagation();
                    showNotification('Added to compare list!', 'info');
                });
            });
        }

        // Search functionality
        function setupSearchFunctionality() {
            const searchInput = document.getElementById('searchInput');
            const searchBtn = document.getElementById('searchBtn');
            
            if (searchBtn) {
                searchBtn.addEventListener('click', performSearch);
            }
            
            if (searchInput) {
                searchInput.addEventListener('keypress', function(e) {
                    if (e.key === 'Enter') {
                        performSearch();
                    }
                });
                
                // Real-time search filter
                searchInput.addEventListener('input', function() {
                    const query = this.value.trim().toLowerCase();
                    filterProductsBySearch(query);
                });
            }
        }

        // Filter products by search query
        function filterProductsBySearch(query) {
            const products = document.querySelectorAll('.product-card');
            const noCategoryMessage = document.querySelector('.no-category-products');
            let visibleCount = 0;
            
            products.forEach(product => {
                const productName = product.querySelector('.product-title').textContent.toLowerCase();
                const productDesc = product.querySelector('.product-description').textContent.toLowerCase();
                const productCategory = product.querySelector('.product-category').textContent.toLowerCase();
                
                if (query === '' || 
                    productName.includes(query) || 
                    productDesc.includes(query) || 
                    productCategory.includes(query)) {
                    product.style.display = 'flex';
                    visibleCount++;
                } else {
                    product.style.display = 'none';
                }
            });
            
            // Update display count
            document.getElementById('displayCount').textContent = visibleCount + ' products available';
            
            // Show/hide empty search message
            if (visibleCount === 0 && query !== '') {
                if (noCategoryMessage) {
                    document.getElementById('category-empty-message').textContent = 
                        'No products found for "' + query + '".';
                    noCategoryMessage.style.display = 'flex';
                    document.querySelector('.products-grid').style.display = 'none';
                }
            } else if (query === '') {
                if (noCategoryMessage) {
                    noCategoryMessage.style.display = 'none';
                    document.querySelector('.products-grid').style.display = 'grid';
                }
            }
        }

        // Perform search
        function performSearch() {
            const searchInput = document.getElementById('searchInput');
            const query = searchInput.value.trim();
            
            if (query) {
                window.location.href = 'ProductListingServlet?search=' + encodeURIComponent(query);
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

        // Logout function - ADDED
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

        // Product card hover effects
        document.querySelectorAll('.product-card').forEach(function(card, index) {
            // Add index for sorting
            card.dataset.index = index;
            
            card.addEventListener('mouseenter', function() {
                this.style.transform = 'translateY(-5px)';
                this.style.boxShadow = '0 10px 20px rgba(138, 79, 255, 0.15)';
            });
            
            card.addEventListener('mouseleave', function() {
                this.style.transform = 'translateY(0)';
                this.style.boxShadow = 'var(--shadow-light)';
            });
        });
    </script>
</body>
</html>