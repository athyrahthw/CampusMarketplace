<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
    
    <!-- Page Styles -->
    <style>
        :root {
            --primary-purple: #8a4fff;
            --light-purple: #a982ff;
            --pale-purple: #f0e6ff;
            --dark-purple: #6b3fc1;
            --accent-green: #4CAF50;
            --light-bg: #f8f5ff;
            --card-bg: #ffffff;
            --text-dark: #2c3e50;
            --text-light: #666;
            --shadow-light: 0 4px 15px rgba(138, 79, 255, 0.1);
            --shadow-medium: 0 8px 25px rgba(138, 79, 255, 0.15);
        }

        /* ===== BASE STYLES ===== */
        body {
            background-color: var(--light-bg);
            font-family: 'Poppins', sans-serif;
            margin: 0;
            padding: 0;
        }

        /* ===== NAVIGATION COMPONENTS ===== */
        /* Top Navigation Bar */
        .top-navigation {
            background: white;
            padding: 0;
            box-shadow: 0 2px 15px rgba(0,0,0,0.1);
            position: sticky;
            top: 0;
            z-index: 1000;
        }

        .nav-main {
            max-width: 1400px;
            margin: 0 auto;
            padding: 0 30px;
        }

        /* Navigation Rows */
        .nav-top-row {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 15px 0;
            border-bottom: 2px solid var(--pale-purple);
        }

        .nav-bottom-row {
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 12px 0;
            background: var(--light-bg);
        }

        /* Logo Section */
        .logo-container {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .logo {
            display: flex;
            align-items: center;
            gap: 12px;
            text-decoration: none;
        }

        .logo-icon {
            font-size: 32px;
            color: var(--primary-purple);
        }

        .logo-text {
            font-size: 24px;
            font-weight: 700;
            color: var(--primary-purple);
            background: linear-gradient(135deg, var(--primary-purple), var(--light-purple));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        /* Search Section */
        .search-container {
            flex: 1;
            max-width: 600px;
            margin: 0 40px;
        }

        .search-box {
            position: relative;
            width: 100%;
        }

        .search-box input {
            width: 100%;
            padding: 14px 60px 14px 25px;
            border: 2px solid var(--pale-purple);
            border-radius: 30px;
            font-size: 16px;
            transition: all 0.3s;
            background: var(--light-bg);
            color: var(--text-dark);
        }

        .search-box input:focus {
            outline: none;
            border-color: var(--primary-purple);
            box-shadow: 0 0 0 3px rgba(138, 79, 255, 0.1);
        }

        .search-btn {
            position: absolute;
            right: 0;
            top: 0;
            height: 100%;
            width: 60px;
            background: var(--primary-purple);
            border: none;
            border-radius: 0 30px 30px 0;
            color: white;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 18px;
            transition: all 0.3s;
        }

        .search-btn:hover {
            background: var(--dark-purple);
        }

        /* User Menu */
        .user-menu-top {
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .user-avatar-top {
            width: 45px;
            height: 45px;
            border-radius: 50%;
            background: linear-gradient(135deg, var(--primary-purple), var(--light-purple));
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: 700;
            font-size: 18px;
            cursor: pointer;
            border: 3px solid var(--pale-purple);
            transition: all 0.3s;
        }

        .user-avatar-top:hover {
            transform: scale(1.05);
            border-color: var(--primary-purple);
        }

        /* Navigation Buttons */
        .nav-buttons {
            display: flex;
            gap: 10px;
        }

        .nav-button {
            background: white;
            border: 2px solid var(--pale-purple);
            color: var(--text-dark);
            padding: 12px 24px;
            border-radius: 25px;
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 10px;
            transition: all 0.3s;
            font-weight: 600;
            font-size: 15px;
            text-decoration: none;
            position: relative;
        }

        .nav-button:hover {
            background: var(--primary-purple);
            color: white;
            border-color: var(--primary-purple);
            transform: translateY(-2px);
            box-shadow: var(--shadow-medium);
        }

        .nav-button.active {
            background: var(--primary-purple);
            color: white;
            border-color: var(--primary-purple);
        }

        .nav-button i {
            font-size: 18px;
        }

        /* Navigation Badges */
        .nav-badge {
            position: absolute;
            top: -8px;
            right: -8px;
            font-size: 11px;
            font-weight: 700;
            min-width: 18px;
            height: 18px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 0 4px;
        }

        .cart-badge {
            background: #FF6B6B;
            color: white;
        }

        .message-badge {
            background: var(--primary-purple);
            color: white;
        }

        /* ===== MAIN LAYOUT ===== */
        .main-container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 30px;
        }

        /* Welcome Header */
        .welcome-header {
            background: linear-gradient(135deg, var(--primary-purple), var(--light-purple));
            color: white;
            padding: 2.5rem;
            margin-bottom: 2.5rem;
            border-radius: 20px;
            box-shadow: var(--shadow-medium);
            text-align: center;
        }

        .welcome-header h1 {
            font-size: 2.8rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
        }

        .welcome-header p {
            font-size: 1.2rem;
            opacity: 0.9;
            max-width: 600px;
            margin: 0 auto;
        }

        /* Dashboard Grid Layout */
        .dashboard-layout {
            display: grid;
            grid-template-columns: 300px 1fr;
            gap: 30px;
        }

        /* ===== SIDEBAR COMPONENTS ===== */
        .dashboard-sidebar {
            display: flex;
            flex-direction: column;
            gap: 25px;
        }

        /* Stats Section */
        .stats-section {
            background: var(--card-bg);
            border-radius: 20px;
            padding: 25px;
            box-shadow: var(--shadow-light);
            border: 2px solid var(--pale-purple);
        }

        .stats-section h3 {
            color: var(--primary-purple);
            font-size: 1.3rem;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
            padding-bottom: 15px;
            border-bottom: 2px solid var(--pale-purple);
        }

        .stats-grid {
            display: grid;
            grid-template-columns: 1fr;
            gap: 15px;
        }

        .stat-item {
            display: flex;
            align-items: center;
            padding: 15px;
            background: var(--light-bg);
            border-radius: 15px;
            border: 2px solid transparent;
            transition: all 0.3s;
        }

        .stat-item:hover {
            border-color: var(--primary-purple);
            transform: translateX(5px);
        }

        .stat-icon {
            width: 50px;
            height: 50px;
            border-radius: 12px;
            background: linear-gradient(135deg, var(--primary-purple), var(--light-purple));
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 15px;
            color: white;
            font-size: 22px;
        }

        .stat-content h4 {
            font-size: 1.8rem;
            color: var(--primary-purple);
            margin: 0;
            font-weight: 700;
        }

        .stat-content p {
            color: var(--text-light);
            margin: 5px 0 0;
            font-size: 0.9rem;
        }

        /* Categories Section */
        .categories-section {
            background: var(--card-bg);
            border-radius: 20px;
            padding: 25px;
            box-shadow: var(--shadow-light);
            border: 2px solid var(--pale-purple);
        }

        .categories-section h3 {
            color: var(--primary-purple);
            font-size: 1.3rem;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
            padding-bottom: 15px;
            border-bottom: 2px solid var(--pale-purple);
        }

        .category-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 12px;
        }

        .category-chip {
            padding: 12px 15px;
            background: var(--light-bg);
            border: 2px solid var(--pale-purple);
            border-radius: 12px;
            color: var(--text-dark);
            font-size: 0.9rem;
            font-weight: 500;
            cursor: pointer;
            text-align: center;
            transition: all 0.3s;
        }

        .category-chip:hover {
            background: var(--pale-purple);
            border-color: var(--light-purple);
            transform: translateY(-2px);
        }

        .category-chip.active {
            background: var(--primary-purple);
            color: white;
            border-color: var(--primary-purple);
        }

        /* ===== MAIN CONTENT AREA ===== */
        .dashboard-main {
            display: flex;
            flex-direction: column;
            gap: 25px;
        }

        /* Products Header */
        .products-header {
            background: var(--card-bg);
            border-radius: 20px;
            padding: 25px 30px;
            box-shadow: var(--shadow-light);
            border: 2px solid var(--pale-purple);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .products-header h2 {
            color: var(--primary-purple);
            font-size: 1.8rem;
            margin: 0;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .products-header h2 i {
            color: #FF6B6B;
        }

        /* View Toggles */
        .view-toggles {
            display: flex;
            gap: 10px;
            background: var(--light-bg);
            padding: 8px;
            border-radius: 12px;
            border: 2px solid var(--pale-purple);
        }

        .view-toggle {
            width: 42px;
            height: 42px;
            border: none;
            background: none;
            border-radius: 8px;
            cursor: pointer;
            color: var(--text-light);
            font-size: 1.2rem;
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
            box-shadow: 0 4px 10px rgba(138, 79, 255, 0.3);
        }

        /* Products Display */
        .products-display {
            background: var(--card-bg);
            border-radius: 20px;
            padding: 30px;
            box-shadow: var(--shadow-light);
            border: 2px solid var(--pale-purple);
            min-height: 400px;
        }

        .products-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 25px;
        }

        /* Empty/Loading States */
        .products-empty {
            grid-column: 1 / -1;
            text-align: center;
            padding: 60px 20px;
        }

        .products-empty i {
            font-size: 70px;
            color: var(--light-purple);
            margin-bottom: 20px;
            opacity: 0.7;
        }

        .products-empty h3 {
            color: var(--text-dark);
            font-size: 1.5rem;
            margin-bottom: 10px;
        }

        .products-empty p {
            color: var(--text-light);
            font-size: 1rem;
            max-width: 400px;
            margin: 0 auto 25px;
        }

        .browse-btn {
            background: linear-gradient(135deg, var(--primary-purple), var(--light-purple));
            color: white;
            border: none;
            padding: 12px 30px;
            border-radius: 25px;
            font-weight: 600;
            font-size: 1rem;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            gap: 10px;
            transition: all 0.3s;
        }

        .browse-btn:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-medium);
        }

        /* ===== FOOTER COMPONENTS ===== */
        .dashboard-footer {
            background: var(--primary-purple);
            margin-top: 50px;
            border-radius: 20px 20px 0 0;
            color: white;
        }

        .footer-content {
            max-width: 1400px;
            margin: 0 auto;
            padding: 40px 30px 30px;
        }

        .footer-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 40px;
            margin-bottom: 30px;
        }

        .footer-column h3, .footer-column h4 {
            font-size: 1.4rem;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .footer-column p {
            opacity: 0.9;
            line-height: 1.6;
            margin-bottom: 15px;
        }

        .footer-links {
            display: flex;
            flex-direction: column;
            gap: 12px;
        }

        .footer-links a {
            color: white;
            text-decoration: none;
            opacity: 0.9;
            transition: opacity 0.3s;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .footer-links a:hover {
            opacity: 1;
            text-decoration: underline;
        }

        .footer-bottom {
            text-align: center;
            padding-top: 25px;
            border-top: 1px solid rgba(255, 255, 255, 0.1);
            opacity: 0.8;
            font-size: 0.9rem;
        }

        /* ===== RESPONSIVE DESIGN ===== */
        /* Large screens (1200px and below) */
        @media (max-width: 1200px) {
            .dashboard-layout {
                grid-template-columns: 1fr;
            }
            
            .dashboard-sidebar {
                display: grid;
                grid-template-columns: repeat(2, 1fr);
                gap: 25px;
            }
            
            .category-grid {
                grid-template-columns: repeat(3, 1fr);
            }
            
            .nav-top-row {
                flex-wrap: wrap;
            }
            
            .search-container {
                order: 3;
                margin: 15px 0 0;
                max-width: 100%;
            }
        }

        /* Medium screens (992px and below) */
        @media (max-width: 992px) {
            .nav-main {
                padding: 0 20px;
            }
            
            .nav-bottom-row {
                overflow-x: auto;
                padding: 10px 0;
                justify-content: flex-start;
            }
            
            .nav-buttons {
                padding: 0 10px;
            }
            
            .nav-button {
                white-space: nowrap;
                flex-shrink: 0;
            }
            
            .welcome-header h1 {
                font-size: 2.2rem;
            }
        }

        /* Small screens (768px and below) */
        @media (max-width: 768px) {
            .main-container {
                padding: 20px;
            }
            
            .dashboard-sidebar {
                grid-template-columns: 1fr;
            }
            
            .category-grid {
                grid-template-columns: repeat(2, 1fr);
            }
            
            .products-grid {
                grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            }
            
            .logo-text {
                font-size: 20px;
            }
            
            .logo-icon {
                font-size: 28px;
            }
            
            .nav-button {
                padding: 10px 15px;
                font-size: 14px;
            }
        }

        /* Extra small screens (480px and below) */
        @media (max-width: 480px) {
            .nav-main {
                padding: 0 15px;
            }
            
            .logo-text {
                font-size: 18px;
            }
            
            .nav-button span {
                display: none;
            }
            
            .nav-button i {
                font-size: 20px;
            }
            
            .nav-button {
                padding: 12px;
                width: 45px;
                height: 45px;
                justify-content: center;
            }
            
            .user-avatar-top {
                width: 40px;
                height: 40px;
                font-size: 16px;
            }
            
            .welcome-header {
                padding: 2rem 1.5rem;
            }
            
            .welcome-header h1 {
                font-size: 1.8rem;
            }
            
            .products-header {
                flex-direction: column;
                gap: 15px;
                text-align: center;
            }
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
                    <a href="index.jsp" class="logo">
                        <i class="fas fa-store logo-icon"></i>
                        <span class="logo-text">Campus Marketplace</span>
                    </a>
                </div>

                <div class="search-container">
                    <div class="search-box">
                        <input type="text" placeholder="Search textbooks, electronics, clothes, furniture...">
                        <button class="search-btn">
                            <i class="fas fa-search"></i>
                        </button>
                    </div>
                </div>

                <div class="user-menu-top">
                    <div class="user-avatar-top" title="Your Profile">
                        S
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
                    <a href="productListing.jsp" class="nav-button">
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
                        <span class="nav-badge cart-badge">3</span>
                    </a>
                    <a href="messages.jsp" class="nav-button">
                        <i class="fas fa-comments"></i>
                        <span>Messages</span>
                        <span class="nav-badge message-badge">5</span>
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
            <h1>Welcome to Campus Marketplace!</h1>
            <p>Buy, sell, and trade with fellow students. Find great deals on textbooks, electronics, furniture and more!</p>
        </div>

        <!-- Dashboard Content Area -->
        <div class="dashboard-layout">
            <!-- Sidebar: Stats & Categories -->
            <aside class="dashboard-sidebar">
                <section class="stats-section">
                    <h3><i class="fas fa-chart-bar"></i> Your Dashboard Stats</h3>
                    <div class="stats-grid">
                        <div class="stat-item">
                            <div class="stat-icon">
                                <i class="fas fa-shopping-bag"></i>
                            </div>
                            <div class="stat-content">
                                <h4>8</h4>
                                <p>Active Listings</p>
                            </div>
                        </div>
                        <div class="stat-item">
                            <div class="stat-icon">
                                <i class="fas fa-heart"></i>
                            </div>
                            <div class="stat-content">
                                <h4>24</h4>
                                <p>Saved Items</p>
                            </div>
                        </div>
                        <div class="stat-item">
                            <div class="stat-icon">
                                <i class="fas fa-comments"></i>
                            </div>
                            <div class="stat-content">
                                <h4>5</h4>
                                <p>New Messages</p>
                            </div>
                        </div>
                        <div class="stat-item">
                            <div class="stat-icon">
                                <i class="fas fa-dollar-sign"></i>
                            </div>
                            <div class="stat-content">
                                <h4>$680</h4>
                                <p>Total Sales</p>
                            </div>
                        </div>
                    </div>
                </section>

                <section class="categories-section">
                    <h3><i class="fas fa-filter"></i> Browse Categories</h3>
                    <div class="category-grid">
                        <div class="category-chip active" data-category="all">All Items</div>
                        <div class="category-chip" data-category="electronics">Electronics</div>
                        <div class="category-chip" data-category="clothing">Clothing</div>
                        <div class="category-chip" data-category="books">Books</div>
                        <div class="category-chip" data-category="sports">Sports</div>
                        <div class="category-chip" data-category="furniture">Furniture</div>
                        <div class="category-chip" data-category="accessories">Accessories</div>
                        <div class="category-chip" data-category="services">Services</div>
                    </div>
                </section>
            </aside>

            <!-- Main Content: Products -->
            <main class="dashboard-main">
                <header class="products-header">
                    <h2><i class="fas fa-fire"></i> Trending Products</h2>
                    <div class="view-toggles">
                        <button class="view-toggle active" data-view="grid">
                            <i class="fas fa-th-large"></i>
                        </button>
                        <button class="view-toggle" data-view="list">
                            <i class="fas fa-list"></i>
                        </button>
                    </div>
                </header>

                <section class="products-display">
                    <div class="products-grid" id="productsGrid">
                        <div class="products-empty">
                            <i class="fas fa-box-open"></i>
                            <h3>Featured Products Loading</h3>
                            <p>Your trending campus products will appear here soon. Browse our marketplace for great deals!</p>
                            <button class="browse-btn" onclick="window.location.href='productListing.jsp'">
                                <i class="fas fa-search"></i>
                                Browse Marketplace
                            </button>
                        </div>
                    </div>
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
                        <a href="index.jsp"><i class="fas fa-home"></i> Home</a>
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
            setupNavigation();
            
            // Initialize counts
            updateCartCount(3);
            updateMessageCount(5);
            
            // Load initial products
            loadProductsByCategory('all');
        }

        // Category filtering functionality
        function setupCategoryFilter() {
            const categoryChips = document.querySelectorAll('.category-chip');
            categoryChips.forEach(chip => {
                chip.addEventListener('click', function() {
                    categoryChips.forEach(c => c.classList.remove('active'));
                    this.classList.add('active');
                    
                    const category = this.dataset.category;
                    loadProductsByCategory(category);
                });
            });
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

        // Search functionality
        function setupSearchFunctionality() {
            const searchInput = document.querySelector('.search-box input');
            const searchBtn = document.querySelector('.search-btn');
            
            if (searchBtn) {
                searchBtn.addEventListener('click', performSearch);
            }
            
            if (searchInput) {
                searchInput.addEventListener('keypress', function(e) {
                    if (e.key === 'Enter') {
                        performSearch();
                    }
                });
            }
        }

        // Navigation setup
        function setupNavigation() {
            const navButtons = document.querySelectorAll('.nav-button');
            navButtons.forEach(button => {
                button.addEventListener('click', function(e) {
                    if (this.href.includes('dashboard.jsp')) {
                        e.preventDefault();
                        navButtons.forEach(b => b.classList.remove('active'));
                        this.classList.add('active');
                    }
                });
            });
        }

        // Product loading function
        function loadProductsByCategory(category) {
            console.log('Loading products for category:', category);
            
            const productsGrid = document.getElementById('productsGrid');
            const categoryDisplay = category === 'all' ? 'All' : 
                category.charAt(0).toUpperCase() + category.slice(1);
            
            // Show loading state
            productsGrid.innerHTML = '<div class="products-empty">' +
                '<i class="fas fa-spinner fa-spin"></i>' +
                '<h3>Loading ' + categoryDisplay + ' Products</h3>' +
                '<p>Fetching the latest campus deals for you...</p>' +
            '</div>';
            
            // Simulate API call
            setTimeout(function() {
                productsGrid.innerHTML = '<div class="products-empty">' +
                    '<i class="fas fa-box-open"></i>' +
                    '<h3>Connect to Database</h3>' +
                    '<p>Products will load here when connected to your database backend.</p>' +
                    '<button class="browse-btn" onclick="window.location.href=\'productListing.jsp\'">' +
                        '<i class="fas fa-database"></i>' +
                        'View Sample Products' +
                    '</button>' +
                '</div>';
            }, 1000);
        }

        // Update badge counts
        function updateCartCount(count) {
            const cartBadge = document.querySelector('.cart-badge');
            if (cartBadge) {
                cartBadge.textContent = count;
                cartBadge.style.display = count > 0 ? 'flex' : 'none';
            }
        }

        function updateMessageCount(count) {
            const messageBadge = document.querySelector('.message-badge');
            if (messageBadge) {
                messageBadge.textContent = count;
                messageBadge.style.display = count > 0 ? 'flex' : 'none';
            }
        }

        // Search function
        function performSearch() {
            const searchInput = document.querySelector('.search-box input');
            const query = searchInput.value.trim();
            
            if (query) {
                alert('Searching for: "' + query + '"\n\nRedirecting to search results...');
                // In production: window.location.href = 'search.jsp?q=' + encodeURIComponent(query);
            } else {
                searchInput.focus();
            }
        }
    </script>
</body>
</html>