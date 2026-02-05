<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.campusmarketplace.model.User" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    // Check if user is logged in
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shopping Cart - Campus Marketplace</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/cart.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        /* Additional styles for cart.jsp */
        .main-header {
            background: white;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            position: sticky;
            top: 0;
            z-index: 1000;
        }
        
        .header-content {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 1rem 0;
        }
        
        .logo h1 {
            font-size: 1.5rem;
            color: #333;
            margin: 0;
        }
        
        .logo i {
            color: #667eea;
            margin-right: 10px;
        }
        
        .main-nav {
            display: flex;
            align-items: center;
            gap: 1.5rem;
        }
        
        .nav-link {
            display: flex;
            align-items: center;
            gap: 5px;
            text-decoration: none;
            color: #666;
            font-weight: 500;
            padding: 0.5rem 1rem;
            border-radius: 8px;
            transition: all 0.3s ease;
        }
        
        .nav-link:hover, .nav-link.active {
            background: #f0f2ff;
            color: #667eea;
        }
        
        .notification-badge {
            background: #ff4757;
            color: white;
            font-size: 0.7rem;
            padding: 2px 6px;
            border-radius: 10px;
            min-width: 18px;
            text-align: center;
            display: inline-flex;
            align-items: center;
            justify-content: center;
        }
        
        .user-dropdown {
            position: relative;
        }
        
        .user-btn {
            display: flex;
            align-items: center;
            gap: 8px;
            background: #f8f9fa;
            border: none;
            padding: 0.5rem 1rem;
            border-radius: 8px;
            cursor: pointer;
            color: #333;
            font-weight: 500;
        }
        
        .user-avatar {
            width: 30px;
            height: 30px;
            background: linear-gradient(135deg, #667eea, #764ba2);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
        }
        
        .dropdown-menu {
            position: absolute;
            top: 100%;
            right: 0;
            background: white;
            min-width: 200px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.15);
            border-radius: 8px;
            padding: 0.5rem 0;
            display: none;
            z-index: 1000;
        }
        
        .user-dropdown:hover .dropdown-menu {
            display: block;
        }
        
        .dropdown-menu a {
            display: block;
            padding: 0.75rem 1rem;
            text-decoration: none;
            color: #333;
            transition: background 0.3s ease;
        }
        
        .dropdown-menu a:hover {
            background: #f8f9fa;
        }
        
        .dropdown-menu a i {
            width: 20px;
            margin-right: 10px;
            color: #667eea;
        }
        
        .dropdown-divider {
            height: 1px;
            background: #eee;
            margin: 0.5rem 0;
        }
        
        .logout-link {
            color: #ff4757 !important;
        }
        
        .logout-link i {
            color: #ff4757 !important;
        }
        
        .btn {
            padding: 0.75rem 1.5rem;
            border: none;
            border-radius: 8px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }
        
        .btn-primary {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
        }
        
        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
        }
        
        .btn-outline {
            background: white;
            border: 2px solid #e0e0e0;
            color: #666;
        }
        
        .btn-outline:hover {
            border-color: #667eea;
            color: #667eea;
            background: #f0f2ff;
        }
        
        .btn-sm {
            padding: 0.5rem 1rem;
            font-size: 0.9rem;
        }
        
        .main-footer {
            background: #2d3748;
            color: white;
            padding: 3rem 0 1.5rem;
            margin-top: 3rem;
        }
        
        .footer-content {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 2rem;
            margin-bottom: 2rem;
        }
        
        .footer-section h3 {
            color: white;
            margin-bottom: 1rem;
            font-size: 1.2rem;
        }
        
        .footer-section a {
            display: block;
            color: #cbd5e0;
            text-decoration: none;
            margin-bottom: 0.5rem;
            transition: color 0.3s ease;
        }
        
        .footer-section a:hover {
            color: white;
        }
        
        .social-links {
            display: flex;
            gap: 1rem;
            margin-top: 1rem;
        }
        
        .social-links a {
            width: 40px;
            height: 40px;
            background: #4a5568;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 1.2rem;
        }
        
        .footer-bottom {
            text-align: center;
            padding-top: 1.5rem;
            border-top: 1px solid #4a5568;
            color: #cbd5e0;
            font-size: 0.9rem;
        }
        
        /* Cart specific additional styles */
        .summary-card {
            background: white;
            border-radius: 20px;
            padding: 1.5rem;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.08);
            margin-bottom: 1.5rem;
        }
        
        .summary-title {
            font-size: 1.5rem;
            color: #333;
            margin-bottom: 1.5rem;
            padding-bottom: 1rem;
            border-bottom: 1px solid #eee;
        }
        
        .summary-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 1rem;
            color: #666;
        }
        
        .summary-row .price {
            font-weight: 600;
            color: #333;
        }
        
        .summary-row .free {
            color: #4CAF50;
        }
        
        .summary-row.discount .price {
            color: #4CAF50;
        }
        
        .summary-total {
            margin-top: 1.5rem;
            padding-top: 1.5rem;
            border-top: 2px solid #eee;
        }
        
        .total-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-size: 1.3rem;
            font-weight: 600;
        }
        
        .total-price {
            color: #667eea;
            font-size: 1.5rem;
        }
        
        .total-savings {
            background: #f0f9ff;
            color: #0369a1;
            padding: 0.5rem 1rem;
            border-radius: 8px;
            margin-top: 0.5rem;
            font-size: 0.9rem;
            display: flex;
            align-items: center;
            gap: 5px;
        }
        
        .promo-section {
            margin: 1.5rem 0;
        }
        
        .promo-input {
            display: flex;
            gap: 10px;
            margin-bottom: 1rem;
        }
        
        .promo-input input {
            flex: 1;
            padding: 0.75rem;
            border: 1px solid #ddd;
            border-radius: 8px;
            font-size: 1rem;
        }
        
        .promo-suggestions {
            display: flex;
            gap: 0.5rem;
            flex-wrap: wrap;
        }
        
        .promo-tag {
            background: #f0f2ff;
            color: #667eea;
            padding: 0.25rem 0.75rem;
            border-radius: 15px;
            font-size: 0.85rem;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        
        .promo-tag:hover {
            background: #667eea;
            color: white;
        }
        
        .btn-checkout {
            width: 100%;
            justify-content: center;
            padding: 1rem;
            font-size: 1.1rem;
            margin: 1.5rem 0;
        }
        
        .checkout-total {
            margin-left: auto;
            font-weight: 400;
            font-size: 0.9em;
            opacity: 0.9;
        }
        
        .payment-methods {
            text-align: center;
            margin: 1.5rem 0;
            padding-top: 1.5rem;
            border-top: 1px solid #eee;
        }
        
        .payment-icons {
            display: flex;
            justify-content: center;
            gap: 1rem;
            font-size: 1.5rem;
            color: #666;
            margin-top: 0.5rem;
        }
        
        .security-notice {
            background: #f0f9ff;
            padding: 0.75rem;
            border-radius: 8px;
            text-align: center;
            color: #0369a1;
            font-size: 0.9rem;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 5px;
        }
        
        .recently-viewed {
            background: white;
            border-radius: 20px;
            padding: 1.5rem;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.08);
        }
        
        .recently-viewed h4 {
            font-size: 1.2rem;
            color: #333;
            margin-bottom: 1rem;
        }
        
        .recent-items {
            display: grid;
            gap: 1rem;
        }
        
        .recent-item {
            display: flex;
            gap: 1rem;
            align-items: center;
            padding: 0.75rem;
            border-radius: 10px;
            background: #f8f9fa;
        }
        
        .recent-item img {
            width: 60px;
            height: 60px;
            border-radius: 8px;
            object-fit: cover;
        }
        
        .recent-info {
            flex: 1;
        }
        
        .recent-title {
            font-weight: 500;
            color: #333;
            margin-bottom: 0.25rem;
        }
        
        .recent-price {
            font-weight: 600;
            color: #667eea;
        }
        
        .recommended-section {
            margin-top: 3rem;
            padding-top: 2rem;
            border-top: 1px solid #eee;
        }
        
        .recommended-section h3 {
            font-size: 1.5rem;
            color: #333;
            margin-bottom: 1.5rem;
        }
        
        .recommended-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            gap: 1.5rem;
        }
        
        .recommended-item {
            background: white;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 5px 15px rgba(0,0,0,0.08);
            transition: transform 0.3s ease;
        }
        
        .recommended-item:hover {
            transform: translateY(-5px);
        }
        
        .recommended-item img {
            width: 100%;
            height: 150px;
            object-fit: cover;
        }
        
        .recommended-info {
            padding: 1rem;
        }
        
        .recommended-info h4 {
            font-size: 1.1rem;
            color: #333;
            margin-bottom: 0.5rem;
        }
        
        .recommended-price {
            font-weight: 600;
            color: #667eea;
            margin-bottom: 1rem;
        }
        
        .continue-shopping {
            margin-top: 1.5rem;
        }
        
        /* Responsive Design */
        @media (max-width: 768px) {
            .header-content {
                flex-direction: column;
                gap: 1rem;
            }
            
            .main-nav {
                width: 100%;
                justify-content: center;
                flex-wrap: wrap;
            }
            
            .cart-content {
                grid-template-columns: 1fr;
            }
            
            .recommended-grid {
                grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
            }
        }
    </style>
</head>
<body>
    <!-- Navigation Header -->
    <header class="main-header">
        <div class="container">
            <div class="header-content">
                <div class="logo">
                    <h1><i class="fas fa-store"></i> Campus Marketplace</h1>
                </div>
                
                <nav class="main-nav">
                    <a href="dashboard.jsp" class="nav-link">
                        <i class="fas fa-home"></i> Home
                    </a>
                    <a href="browse.jsp" class="nav-link">
                        <i class="fas fa-compass"></i> Browse
                    </a>
                    <a href="cart.jsp" class="nav-link active">
                        <i class="fas fa-shopping-cart"></i> Cart
                        <span class="notification-badge" id="cart-count">2</span>
                    </a>
                    <a href="messages.jsp" class="nav-link">
                        <i class="fas fa-envelope"></i> Messages
                        <span class="notification-badge">3</span>
                    </a>
                    
                    <div class="user-dropdown">
                        <button class="user-btn">
                            <div class="user-avatar">
                                <i class="fas fa-user"></i>
                            </div>
                            <span><%= user.getUsername() %></span>
                            <i class="fas fa-chevron-down"></i>
                        </button>
                        <div class="dropdown-menu">
                            <a href="profile.jsp"><i class="fas fa-user-circle"></i> My Profile</a>
                            <a href="my-items.jsp"><i class="fas fa-box"></i> My Items</a>
                            <a href="orders.jsp"><i class="fas fa-shopping-bag"></i> My Orders</a>
                            <a href="settings.jsp"><i class="fas fa-cog"></i> Settings</a>
                            <div class="dropdown-divider"></div>
                            <a href="LogoutServlet" class="logout-link"><i class="fas fa-sign-out-alt"></i> Logout</a>
                        </div>
                    </div>
                </nav>
            </div>
        </div>
    </header>

    <!-- Main Cart Content -->
    <main class="cart-main">
        <div class="container">
            <!-- Page Header -->
            <div class="page-header">
                <h1><i class="fas fa-shopping-cart"></i> Shopping Cart (<span id="item-count">2</span>)</h1>
                <div class="cart-steps">
                    <div class="step active">
                        <span class="step-number">1</span>
                        <span class="step-text">Cart</span>
                    </div>
                    <div class="step">
                        <span class="step-number">2</span>
                        <span class="step-text">Shipping</span>
                    </div>
                    <div class="step">
                        <span class="step-number">3</span>
                        <span class="step-text">Payment</span>
                    </div>
                    <div class="step">
                        <span class="step-number">4</span>
                        <span class="step-text">Confirmation</span>
                    </div>
                </div>
            </div>

            <!-- Cart Content -->
            <div class="cart-content">
                <!-- Cart Items -->
                <div class="cart-items-section">
                    <!-- Cart Header -->
                    <div class="cart-header">
                        <div class="select-all">
                            <input type="checkbox" id="select-all" checked>
                            <label for="select-all">Select All</label>
                        </div>
                        <div class="cart-actions">
                            <button class="btn btn-outline delete-selected">
                                <i class="fas fa-trash"></i> Delete Selected
                            </button>
                            <button class="btn btn-outline move-to-wishlist">
                                <i class="fas fa-heart"></i> Move to Wishlist
                            </button>
                        </div>
                    </div>

                    <!-- Cart Items List -->
                    <div class="cart-items-list">
                        <!-- Item 1: Baju -->
                        <div class="cart-item selected">
                            <div class="item-select">
                                <input type="checkbox" class="item-checkbox" id="item1" checked>
                                <label for="item1"></label>
                            </div>
                            
                            <div class="item-image">
                                <img src="https://images.unsplash.com/photo-1523381210434-271e8be1f52b?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80" alt="Jaherbayu">
                            </div>
                            
                            <div class="item-details">
                                <h3 class="item-title">Jaherbayu</h3>
                                <p class="item-variant">Blouse • Size S</p>
                                <div class="item-seller">
                                    <i class="fas fa-user"></i>
                                    <span>Seller: john_doe</span>
                                </div>
                                <div class="item-condition">
                                    <i class="fas fa-certificate"></i>
                                    <span>Condition: Like New</span>
                                </div>
                            </div>
                            
                            <div class="item-price">
                                <div class="price-amount">RM20.00</div>
                                <div class="price-original">RM25.00</div>
                                <span class="price-discount">-20%</span>
                            </div>
                            
                            <div class="item-quantity">
                                <div class="quantity-control">
                                    <button class="quantity-btn minus"><i class="fas fa-minus"></i></button>
                                    <input type="number" class="quantity-input" value="1" min="1" max="10">
                                    <button class="quantity-btn plus"><i class="fas fa-plus"></i></button>
                                </div>
                                <span class="stock-info">5 left in stock</span>
                            </div>
                            
                            <div class="item-total">RM20.00</div>
                            
                            <div class="item-actions">
                                <button class="action-btn save">
                                    <i class="far fa-heart"></i> Save
                                </button>
                                <button class="action-btn delete">
                                    <i class="fas fa-trash"></i> Remove
                                </button>
                            </div>
                        </div>

                        <!-- Item 2: Stokin Murah -->
                        <div class="cart-item selected">
                            <div class="item-select">
                                <input type="checkbox" class="item-checkbox" id="item2" checked>
                                <label for="item2"></label>
                            </div>
                            
                            <div class="item-image">
                                <img src="https://images.unsplash.com/photo-1586350977771-b3b0abd50c82?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80" alt="Stokin Murah">
                            </div>
                            
                            <div class="item-details">
                                <h3 class="item-title">Stokin Murah</h3>
                                <p class="item-variant">White Socks • 5 Pairs</p>
                                <div class="item-seller">
                                    <i class="fas fa-user"></i>
                                    <span>Seller: fashion_guru</span>
                                </div>
                                <div class="item-condition">
                                    <i class="fas fa-certificate"></i>
                                    <span>Condition: Brand New</span>
                                </div>
                            </div>
                            
                            <div class="item-price">
                                <div class="price-amount">RM10.00</div>
                                <div class="price-original">RM12.00</div>
                                <span class="price-discount">-17%</span>
                            </div>
                            
                            <div class="item-quantity">
                                <div class="quantity-control">
                                    <button class="quantity-btn minus"><i class="fas fa-minus"></i></button>
                                    <input type="number" class="quantity-input" value="2" min="1" max="5">
                                    <button class="quantity-btn plus"><i class="fas fa-plus"></i></button>
                                </div>
                                <span class="stock-info">3 left in stock</span>
                            </div>
                            
                            <div class="item-total">RM20.00</div>
                            
                            <div class="item-actions">
                                <button class="action-btn save">
                                    <i class="far fa-heart"></i> Save
                                </button>
                                <button class="action-btn delete">
                                    <i class="fas fa-trash"></i> Remove
                                </button>
                            </div>
                        </div>
                    </div>

                    <!-- Continue Shopping -->
                    <div class="continue-shopping">
                        <a href="productListing.jsp" class="btn btn-outline">
                            <i class="fas fa-arrow-left"></i> Continue Shopping
                        </a>
                    </div>
                </div>

                <!-- Order Summary -->
                <div class="order-summary-section">
                    <div class="summary-card">
                        <h3 class="summary-title">Order Summary</h3>
                        
                        <div class="summary-items">
                            <div class="summary-row">
                                <span>Subtotal (2 items)</span>
                                <span class="price">RM30.00</span>
                            </div>
                            <div class="summary-row">
                                <span>Shipping Fee</span>
                                <span class="price free">Free</span>
                            </div>
                            <div class="summary-row">
                                <span>Service Fee</span>
                                <span class="price">RM1.50</span>
                            </div>
                            <div class="summary-row discount">
                                <span>Discount</span>
                                <span class="price">-RM7.00</span>
                            </div>
                        </div>
                        
                        <div class="summary-total">
                            <div class="total-row">
                                <span>Total</span>
                                <span class="total-price">RM24.50</span>
                            </div>
                            <div class="total-savings">
                                <i class="fas fa-tag"></i> You save RM7.00
                            </div>
                        </div>
                        
                        <!-- Promo Code -->
                        <div class="promo-section">
                            <div class="promo-input">
                                <input type="text" placeholder="Enter promo code" id="promo-code">
                                <button class="btn btn-outline" id="apply-promo">Apply</button>
                            </div>
                            <div class="promo-suggestions">
                                <span class="promo-tag" data-code="STUDENT10">STUDENT10</span>
                                <span class="promo-tag" data-code="CAMPUS20">CAMPUS20</span>
                                <span class="promo-tag" data-code="SPRING25">SPRING25</span>
                            </div>
                        </div>
                        
                        <!-- Checkout Button -->
                        <button class="btn btn-primary btn-checkout" id="checkout-btn">
                            <i class="fas fa-lock"></i> Proceed to Checkout
                            <span class="checkout-total">(RM24.50)</span>
                        </button>
                        
                        <!-- Payment Methods -->
                        <div class="payment-methods">
                            <p>We accept:</p>
                            <div class="payment-icons">
                                <i class="fab fa-cc-visa" title="Visa"></i>
                                <i class="fab fa-cc-mastercard" title="Mastercard"></i>
                                <i class="fab fa-cc-amex" title="American Express"></i>
                                <i class="fab fa-paypal" title="PayPal"></i>
                                <i class="fas fa-university" title="Bank Transfer"></i>
                            </div>
                        </div>
                        
                        <!-- Security Notice -->
                        <div class="security-notice">
                            <i class="fas fa-shield-alt"></i>
                            <span>Secure checkout · SSL encrypted</span>
                        </div>
                    </div>
                    
                    <!-- Recently Viewed -->
                    <div class="recently-viewed">
                        <h4>Recently Viewed</h4>
                        <div class="recent-items">
                            <div class="recent-item">
                                <img src="https://images.unsplash.com/photo-1549298916-b41d501d3772?ixlib=rb-4.0.3&auto=format&fit=crop&w=150&q=80" alt="Sneakers">
                                <div class="recent-info">
                                    <p class="recent-title">Running Shoes</p>
                                    <p class="recent-price">RM85.00</p>
                                </div>
                            </div>
                            <div class="recent-item">
                                <img src="https://images.unsplash.com/photo-1526170375885-4d8ecf77b99f?ixlib=rb-4.0.3&auto=format&fit=crop&w=150&q=80" alt="Camera">
                                <div class="recent-info">
                                    <p class="recent-title">DSLR Camera</p>
                                    <p class="recent-price">RM300.00</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Recommended Items -->
            <div class="recommended-section">
                <h3>You might also like</h3>
                <div class="recommended-grid">
                    <div class="recommended-item">
                        <img src="https://images.unsplash.com/photo-1520006403909-838d6b92c22e?ixlib=rb-4.0.3&auto=format&fit=crop&w=300&q=80" alt="Backpack">
                        <div class="recommended-info">
                            <h4>Campus Backpack</h4>
                            <p class="recommended-price">RM45.00</p>
                            <button class="btn btn-outline btn-sm">Add to Cart</button>
                        </div>
                    </div>
                    
                    <div class="recommended-item">
                        <img src="https://images.unsplash.com/photo-1545235617-9465d2a55698?ixlib=rb-4.0.3&auto=format&fit=crop&w=300&q=80" alt="Water Bottle">
                        <div class="recommended-info">
                            <h4>Sports Water Bottle</h4>
                            <p class="recommended-price">RM15.00</p>
                            <button class="btn btn-outline btn-sm">Add to Cart</button>
                        </div>
                    </div>
                    
                    <div class="recommended-item">
                        <img src="https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?ixlib=rb-4.0.3&auto=format&fit=crop&w=300&q=80" alt="Smartphone">
                        <div class="recommended-info">
                            <h4>Used Smartphone</h4>
                            <p class="recommended-price">RM250.00</p>
                            <button class="btn btn-outline btn-sm">Add to Cart</button>
                        </div>
                    </div>
                    
                    <div class="recommended-item">
                        <img src="https://images.unsplash.com/photo-1560769629-975ec94e6a86?ixlib=rb-4.0.3&auto=format&fit=crop&w=300&q=80" alt="Headphones">
                        <div class="recommended-info">
                            <h4>Wireless Headphones</h4>
                            <p class="recommended-price">RM65.00</p>
                            <button class="btn btn-outline btn-sm">Add to Cart</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <!-- Footer -->
    <footer class="main-footer">
        <div class="container">
            <div class="footer-content">
                <div class="footer-section">
                    <h3><i class="fas fa-store"></i> Campus Marketplace</h3>
                    <p>Your campus shopping destination for great deals.</p>
                    <div class="social-links">
                        <a href="#"><i class="fab fa-facebook"></i></a>
                        <a href="#"><i class="fab fa-twitter"></i></a>
                        <a href="#"><i class="fab fa-instagram"></i></a>
                        <a href="#"><i class="fab fa-discord"></i></a>
                    </div>
                </div>
                
                <div class="footer-section">
                    <h3>Help & Support</h3>
                    <a href="faq.jsp">FAQ</a>
                    <a href="shipping.jsp">Shipping Info</a>
                    <a href="returns.jsp">Returns & Refunds</a>
                    <a href="contact.jsp">Contact Support</a>
                </div>
                
                <div class="footer-section">
                    <h3>Student Services</h3>
                    <a href="student-discounts.jsp">Student Discounts</a>
                    <a href="campus-pickup.jsp">Campus Pickup</a>
                    <a href="textbook-exchange.jsp">Textbook Exchange</a>
                    <a href="campus-events.jsp">Campus Events</a>
                </div>
                
                <div class="footer-section">
                    <h3>Contact Info</h3>
                    <p><i class="fas fa-map-marker-alt"></i> Campus Mall, University City</p>
                    <p><i class="fas fa-phone"></i> (123) 456-7890</p>
                    <p><i class="fas fa-envelope"></i> support@campusmarket.edu</p>
                </div>
            </div>
            
            <div class="footer-bottom">
                <p>&copy; 2024 Campus Marketplace. All rights reserved.</p>
                <p>Secure shopping · Student verified · Campus trusted</p>
            </div>
        </div>
    </footer>

    <!-- JavaScript -->
    <script>
        // Select All functionality
        const selectAll = document.getElementById('select-all');
        const itemCheckboxes = document.querySelectorAll('.item-checkbox');
        const cartCount = document.getElementById('cart-count');
        const itemCount = document.getElementById('item-count');
        
        selectAll.addEventListener('change', function() {
            itemCheckboxes.forEach(checkbox => {
                checkbox.checked = this.checked;
                checkbox.closest('.cart-item').classList.toggle('selected', this.checked);
            });
            updateCartSummary();
        });
        
        // Individual item selection
        itemCheckboxes.forEach(checkbox => {
            checkbox.addEventListener('change', function() {
                this.closest('.cart-item').classList.toggle('selected', this.checked);
                updateSelectAll();
                updateCartSummary();
            });
        });
        
        function updateSelectAll() {
            const allChecked = Array.from(itemCheckboxes).every(cb => cb.checked);
            const anyChecked = Array.from(itemCheckboxes).some(cb => cb.checked);
            
            selectAll.checked = allChecked;
            selectAll.indeterminate = !allChecked && anyChecked;
        }
        
        // Quantity controls
        document.querySelectorAll('.quantity-btn').forEach(btn => {
            btn.addEventListener('click', function() {
                const input = this.parentElement.querySelector('.quantity-input');
                let value = parseInt(input.value);
                
                if (this.classList.contains('minus')) {
                    if (value > 1) {
                        input.value = value - 1;
                        updateItemTotal(this.closest('.cart-item'));
                    }
                } else {
                    if (value < parseInt(input.max)) {
                        input.value = value + 1;
                        updateItemTotal(this.closest('.cart-item'));
                    }
                }
                
                updateCartSummary();
            });
        });
        
        // Quantity input change
        document.querySelectorAll('.quantity-input').forEach(input => {
            input.addEventListener('change', function() {
                let value = parseInt(this.value);
                const max = parseInt(this.max);
                const min = parseInt(this.min);
                
                if (value > max) this.value = max;
                if (value < min) this.value = min;
                
                updateItemTotal(this.closest('.cart-item'));
                updateCartSummary();
            });
        });
        
        // Update individual item total
        function updateItemTotal(item) {
            const priceText = item.querySelector('.price-amount').textContent;
            const price = parseFloat(priceText.replace('RM', '').replace(',', ''));
            const quantity = parseInt(item.querySelector('.quantity-input').value);
            const total = price * quantity;
            
            item.querySelector('.item-total').textContent = 'RM' + total.toFixed(2);
        }
        
        // Remove item
        document.querySelectorAll('.action-btn.delete').forEach(btn => {
            btn.addEventListener('click', function() {
                const item = this.closest('.cart-item');
                item.style.animation = 'slideOut 0.3s ease';
                
                setTimeout(() => {
                    item.remove();
                    updateCartCount();
                    updateCartSummary();
                }, 300);
            });
        });
        
        // Save for later
        document.querySelectorAll('.action-btn.save').forEach(btn => {
            btn.addEventListener('click', function() {
                const icon = this.querySelector('i');
                if (icon.classList.contains('far')) {
                    icon.classList.remove('far');
                    icon.classList.add('fas');
                    this.innerHTML = '<i class="fas fa-heart"></i> Saved';
                    this.style.color = '#ff4757';
                    
                    // Show notification
                    showNotification('Item saved to wishlist');
                } else {
                    icon.classList.remove('fas');
                    icon.classList.add('far');
                    this.innerHTML = '<i class="far fa-heart"></i> Save';
                    this.style.color = '';
                }
            });
        });
        
        // Delete selected
        document.querySelector('.delete-selected').addEventListener('click', function() {
            const selectedItems = document.querySelectorAll('.cart-item.selected');
            
            if (selectedItems.length === 0) {
                showNotification('Please select items to delete', 'warning');
                return;
            }
            
            if (confirm(`Delete ${selectedItems.length} selected item(s)?`)) {
                selectedItems.forEach(item => {
                    item.style.animation = 'slideOut 0.3s ease';
                    setTimeout(() => item.remove(), 300);
                });
                
                setTimeout(() => {
                    updateCartCount();
                    updateCartSummary();
                }, 300 + selectedItems.length * 50);
            }
        });
        
        // Move to wishlist
        document.querySelector('.move-to-wishlist').addEventListener('click', function() {
            const selectedItems = document.querySelectorAll('.cart-item.selected');
            
            if (selectedItems.length === 0) {
                showNotification('Please select items to move', 'warning');
                return;
            }
            
            showNotification(`${selectedItems.length} item(s) moved to wishlist`);
            
            selectedItems.forEach(item => {
                item.style.animation = 'slideOut 0.3s ease';
                setTimeout(() => item.remove(), 300);
            });
            
            setTimeout(() => {
                updateCartCount();
                updateCartSummary();
            }, 300 + selectedItems.length * 50);
        });
        
        // Promo code suggestions
        document.querySelectorAll('.promo-tag').forEach(tag => {
            tag.addEventListener('click', function() {
                const code = this.dataset.code;
                document.getElementById('promo-code').value = code;
                showNotification(`Promo code "${code}" applied!`);
                updateCartSummary();
            });
        });
        
        // Apply promo code
        document.getElementById('apply-promo').addEventListener('click', function() {
            const promoCode = document.getElementById('promo-code').value.trim();
            
            if (promoCode) {
                showNotification(`Promo code "${promoCode}" applied successfully!`);
                updateCartSummary();
            } else {
                showNotification('Please enter a promo code', 'warning');
            }
        });
        
        // Checkout button
        document.getElementById('checkout-btn').addEventListener('click', function() {
            const selectedItems = document.querySelectorAll('.cart-item.selected');
            
            if (selectedItems.length === 0) {
                showNotification('Please select items to checkout', 'warning');
                return;
            }
            
            // Redirect to checkout page
            showNotification('Redirecting to checkout...', 'info');
            setTimeout(() => {
                window.location.href = 'checkout.jsp';
            }, 1000);
        });
        
        // Add to cart from recommended items
        document.querySelectorAll('.recommended-item .btn').forEach(btn => {
            btn.addEventListener('click', function() {
                const item = this.closest('.recommended-item');
                const title = item.querySelector('h4').textContent;
                const price = item.querySelector('.recommended-price').textContent;
                
                showNotification(`${title} added to cart!`);
                
                // Update cart count
                let count = parseInt(cartCount.textContent);
                cartCount.textContent = count + 1;
                itemCount.textContent = count + 1;
            });
        });
        
        // Update cart count
        function updateCartCount() {
            const count = document.querySelectorAll('.cart-item').length;
            cartCount.textContent = count;
            itemCount.textContent = count;
            
            if (count === 0) {
                cartCount.style.display = 'none';
            } else {
                cartCount.style.display = 'flex';
            }
        }
        
        // Update cart summary
        function updateCartSummary() {
            let subtotal = 0;
            let selectedCount = 0;
            
            document.querySelectorAll('.cart-item.selected').forEach(item => {
                const priceText = item.querySelector('.price-amount').textContent;
                const price = parseFloat(priceText.replace('RM', '').replace(',', ''));
                const quantity = parseInt(item.querySelector('.quantity-input').value);
                
                subtotal += price * quantity;
                selectedCount++;
            });
            
            const shipping = 0; // Free shipping
            const serviceFee = 1.50;
            const discount = 7.00;
            const total = subtotal + shipping + serviceFee - discount;
            
                    // Update cart summary
        function updateCartSummary() {
            let subtotal = 0;
            let selectedCount = 0;
            
            document.querySelectorAll('.cart-item.selected').forEach(item => {
                const priceText = item.querySelector('.price-amount').textContent;
                const price = parseFloat(priceText.replace('RM', '').replace(',', ''));
                const quantity = parseInt(item.querySelector('.quantity-input').value);
                
                subtotal += price * quantity;
                selectedCount++;
            });
            
            const shipping = 0; // Free shipping
            const serviceFee = 1.50;
            const discount = 7.00;
            const total = subtotal + shipping + serviceFee - discount;
            
            // Update summary display
            const subtotalElement = document.querySelector('.summary-row:nth-child(1) .price');
            const subtotalLabel = document.querySelector('.summary-row:nth-child(1) span:first-child');
            
            if (subtotalElement) {
                subtotalElement.textContent = 'RM' + subtotal.toFixed(2);
            }
            
            if (subtotalLabel) {
                subtotalLabel.textContent = 'Subtotal (' + selectedCount + ' item' + (selectedCount !== 1 ? 's' : '') + ')';
            }
            
            const totalPriceElement = document.querySelector('.total-price');
            const checkoutTotalElement = document.querySelector('.checkout-total');
            
            if (totalPriceElement) {
                totalPriceElement.textContent = 'RM' + total.toFixed(2);
            }
            
            if (checkoutTotalElement) {
                checkoutTotalElement.textContent = '(RM' + total.toFixed(2) + ')';
            }
        }
        
        // Show notification
        function showNotification(message, type = 'success') {
            // Remove existing notifications
            document.querySelectorAll('.notification').forEach(n => n.remove());
            
            const notification = document.createElement('div');
            notification.className = 'notification ' + type;
            
            let iconClass = 'info-circle';
            if (type === 'success') {
                iconClass = 'check-circle';
            } else if (type === 'warning') {
                iconClass = 'exclamation-triangle';
            }
            
            notification.innerHTML = '<i class="fas fa-' + iconClass + '"></i>' +
                                    '<span>' + message + '</span>' +
                                    '<button class="close-notification"><i class="fas fa-times"></i></button>';
            
            document.body.appendChild(notification);
            
            // Auto remove after 3 seconds
            setTimeout(() => {
                if (notification.parentNode) {
                    notification.style.animation = 'slideOut 0.3s ease';
                    setTimeout(() => notification.remove(), 300);
                }
            }, 3000);
            
            // Close button
            notification.querySelector('.close-notification').addEventListener('click', () => {
                notification.style.animation = 'slideOut 0.3s ease';
                setTimeout(() => notification.remove(), 300);
            });
        }
            
            document.body.appendChild(notification);
            
            // Auto remove after 3 seconds
            setTimeout(() => {
                if (notification.parentNode) {
                    notification.style.animation = 'slideOut 0.3s ease';
                    setTimeout(() => notification.remove(), 300);
                }
            }, 3000);
            
            // Close button
            notification.querySelector('.close-notification').addEventListener('click', () => {
                notification.style.animation = 'slideOut 0.3s ease';
                setTimeout(() => notification.remove(), 300);
            });
        }
        
        // Initialize cart summary
        updateCartCount();
        updateCartSummary();
    </script>
</body>
</html>