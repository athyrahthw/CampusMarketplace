<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Products - Admin Dashboard</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Poppins', sans-serif;
        }
        
        body {
            background-color: #f5f7fb;
            color: #333;
        }
        
        /* Navigation - Same as adminDashboard */
        .top-navigation {
            background: white;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            position: sticky;
            top: 0;
            z-index: 1000;
        }
        
        .nav-main {
            max-width: 1400px;
            margin: 0 auto;
            padding: 0 20px;
        }
        
        .nav-top-row {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 15px 0;
            border-bottom: 1px solid #eee;
        }
        
        .logo-container {
            display: flex;
            align-items: center;
        }
        
        .logo {
            display: flex;
            align-items: center;
            text-decoration: none;
            color: #333;
            font-weight: 600;
            font-size: 1.2rem;
        }
        
        .logo-icon {
            color: #8a4fff;
            font-size: 1.5rem;
            margin-right: 10px;
        }
        
        .nav-bottom-row {
            padding: 10px 0;
        }
        
        .nav-buttons {
            display: flex;
            gap: 5px;
        }
        
        .nav-button {
            display: flex;
            align-items: center;
            gap: 8px;
            padding: 10px 20px;
            text-decoration: none;
            color: #666;
            border-radius: 8px;
            transition: all 0.3s;
            font-weight: 500;
        }
        
        .nav-button:hover {
            background-color: #f0f0f0;
            color: #333;
        }
        
        .nav-button.active {
            background: linear-gradient(135deg, #8a4fff, #6c63ff);
            color: white;
            box-shadow: 0 4px 12px rgba(138, 79, 255, 0.2);
        }
        
        .nav-badge {
            background: #ff4757;
            color: white;
            font-size: 0.75rem;
            padding: 2px 8px;
            border-radius: 10px;
            min-width: 20px;
            height: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        .user-menu-top {
            display: flex;
            align-items: center;
            gap: 15px;
        }
        
        .admin-badge {
            background: linear-gradient(135deg, #8a4fff, #6c63ff);
            color: white;
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 6px;
        }
        
        .logout-btn {
            background: transparent;
            border: 1px solid #ddd;
            padding: 8px 15px;
            border-radius: 6px;
            color: #666;
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 6px;
            transition: all 0.3s;
        }
        
        .logout-btn:hover {
            background: #ff4757;
            color: white;
            border-color: #ff4757;
        }
        
        .user-avatar-top {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: linear-gradient(135deg, #8a4fff, #6c63ff);
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 600;
            cursor: pointer;
        }
        
        /* Main Content */
        .main-container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 20px;
        }
        
        .welcome-header {
            background: linear-gradient(135deg, #8a4fff, #6c63ff);
            color: white;
            padding: 30px;
            border-radius: 15px;
            margin-bottom: 30px;
            box-shadow: 0 4px 20px rgba(138, 79, 255, 0.2);
        }
        
        .welcome-header h1 {
            font-size: 2rem;
            margin-bottom: 10px;
        }
        
        /* Stats Summary */
        .stats-summary {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }
        
        .stat-box {
            background: white;
            border-radius: 15px;
            padding: 25px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
            border-left: 5px solid #8a4fff;
            transition: transform 0.3s ease;
        }
        
        .stat-box:hover {
            transform: translateY(-5px);
        }
        
        .stat-box h4 {
            font-size: 0.9rem;
            color: #666;
            margin-bottom: 10px;
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        
        .stat-box .value {
            font-size: 2.2rem;
            font-weight: 700;
            color: #333;
        }
        
        /* Controls */
        .admin-controls {
            display: flex;
            gap: 15px;
            margin-bottom: 30px;
            flex-wrap: wrap;
        }
        
        .search-bar {
            flex: 1;
            min-width: 300px;
            position: relative;
        }
        
        .search-bar i {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #666;
        }
        
        .search-bar input {
            width: 100%;
            padding: 12px 15px 12px 45px;
            border: 2px solid #e0e0e0;
            border-radius: 10px;
            font-size: 1rem;
            transition: border-color 0.3s;
        }
        
        .search-bar input:focus {
            outline: none;
            border-color: #8a4fff;
        }
        
        .btn {
            padding: 12px 25px;
            border-radius: 10px;
            border: none;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        
        .btn-primary {
            background: linear-gradient(135deg, #8a4fff, #6c63ff);
            color: white;
        }
        
        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(138, 79, 255, 0.3);
        }
        
        .btn-secondary {
            background: #f0f0f0;
            color: #333;
        }
        
        .btn-secondary:hover {
            background: #e0e0e0;
        }
        
        select.btn-secondary {
            appearance: none;
            -webkit-appearance: none;
            -moz-appearance: none;
            padding-right: 40px;
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='%23333' viewBox='0 0 16 16'%3E%3Cpath d='M7.247 11.14 2.451 5.658C1.885 5.013 2.345 4 3.204 4h9.592a1 1 0 0 1 .753 1.659l-4.796 5.48a1 1 0 0 1-1.506 0z'/%3E%3C/svg%3E");
            background-repeat: no-repeat;
            background-position: right 15px center;
        }
        
        /* Category Filter */
        .category-filter {
            display: flex;
            gap: 10px;
            margin-bottom: 25px;
            flex-wrap: wrap;
        }
        
        .category-btn {
            padding: 10px 20px;
            background: white;
            border: 2px solid #e0e0e0;
            border-radius: 25px;
            cursor: pointer;
            transition: all 0.3s;
            font-weight: 500;
            color: #666;
        }
        
        .category-btn:hover {
            border-color: #8a4fff;
            color: #8a4fff;
        }
        
        .category-btn.active {
            background: linear-gradient(135deg, #8a4fff, #6c63ff);
            color: white;
            border-color: #8a4fff;
        }
        
        /* Table */
        .table-container {
            background: white;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
            margin-bottom: 30px;
        }
        
        table {
            width: 100%;
            border-collapse: collapse;
        }
        
        thead {
            background: linear-gradient(135deg, #8a4fff, #6c63ff);
        }
        
        th {
            padding: 20px;
            text-align: left;
            font-weight: 600;
            color: white;
            font-size: 0.95rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        
        td {
            padding: 20px;
            border-bottom: 1px solid #f0f0f0;
        }
        
        tbody tr {
            transition: background-color 0.2s;
        }
        
        tbody tr:hover {
            background-color: #f9f9ff;
        }
        
        tbody tr:last-child td {
            border-bottom: none;
        }
        
        /* Product Info */
        .product-info {
            display: flex;
            align-items: center;
            gap: 15px;
        }
        
        .product-image {
            width: 60px;
            height: 60px;
            border-radius: 10px;
            background: #f5f5f5;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
            color: #8a4fff;
        }
        
        .product-details {
            display: flex;
            flex-direction: column;
        }
        
        .product-title {
            font-weight: 600;
            color: #333;
            font-size: 1rem;
            margin-bottom: 5px;
        }
        
        .product-id {
            font-size: 0.85rem;
            color: #666;
        }
        
        /* Category Tags */
        .category-tag {
            padding: 6px 15px;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 600;
            display: inline-block;
        }
        
        .category-books {
            background-color: rgba(33, 150, 243, 0.1);
            color: #2196F3;
        }
        
        .category-electronics {
            background-color: rgba(255, 152, 0, 0.1);
            color: #FF9800;
        }
        
        .category-furniture {
            background-color: rgba(76, 175, 80, 0.1);
            color: #4CAF50;
        }
        
        .category-clothing {
            background-color: rgba(156, 39, 176, 0.1);
            color: #9C27B0;
        }
        
        .category-other {
            background-color: rgba(158, 158, 158, 0.1);
            color: #666;
        }
        
        /* Status Badges */
        .status-badge {
            padding: 6px 15px;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 600;
            display: inline-block;
        }
        
        .status-active {
            background-color: rgba(76, 175, 80, 0.1);
            color: #4CAF50;
        }
        
        .status-pending {
            background-color: rgba(255, 152, 0, 0.1);
            color: #FF9800;
        }
        
        .status-sold {
            background-color: rgba(33, 150, 243, 0.1);
            color: #2196F3;
        }
        
        .status-removed {
            background-color: rgba(244, 67, 54, 0.1);
            color: #F44336;
        }
        
        /* Price */
        .price {
            font-weight: 700;
            color: #333;
            font-size: 1.1rem;
        }
        
        /* Seller Info */
        .seller-info {
            display: flex;
            flex-direction: column;
        }
        
        .seller-name {
            font-weight: 500;
            color: #333;
            margin-bottom: 3px;
        }
        
        .seller-email {
            font-size: 0.85rem;
            color: #666;
        }
        
        /* Action Buttons */
        .action-buttons {
            display: flex;
            gap: 8px;
        }
        
        .icon-btn {
            width: 36px;
            height: 36px;
            border-radius: 8px;
            border: 1px solid #e0e0e0;
            background: white;
            color: #666;
            cursor: pointer;
            transition: all 0.2s;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        .icon-btn:hover {
            background-color: #f5f5f5;
            transform: translateY(-2px);
        }
        
        .icon-btn.view:hover {
            color: #2196F3;
            border-color: #2196F3;
        }
        
        .icon-btn.edit:hover {
            color: #4CAF50;
            border-color: #4CAF50;
        }
        
        .icon-btn.delete:hover {
            color: #F44336;
            border-color: #F44336;
        }
        
        /* Pagination */
        .pagination {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 10px;
            margin-top: 30px;
        }
        
        .page-btn {
            padding: 10px 20px;
            border-radius: 8px;
            border: 1px solid #ddd;
            background: white;
            color: #333;
            cursor: pointer;
            transition: all 0.3s;
            display: flex;
            align-items: center;
            gap: 5px;
        }
        
        .page-btn:hover:not(:disabled) {
            background: #f5f5f5;
        }
        
        .page-btn:disabled {
            opacity: 0.5;
            cursor: not-allowed;
        }
        
        .page-info {
            padding: 0 15px;
            font-weight: 500;
        }
        
        /* Modal */
        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
            z-index: 2000;
            align-items: center;
            justify-content: center;
        }
        
        .modal-content {
            background: white;
            border-radius: 15px;
            width: 90%;
            max-width: 600px;
            max-height: 90vh;
            overflow-y: auto;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
        }
        
        .modal-header {
            padding: 20px;
            border-bottom: 1px solid #eee;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .modal-header h3 {
            color: #333;
            font-size: 1.3rem;
        }
        
        .close-modal {
            background: none;
            border: none;
            font-size: 1.5rem;
            cursor: pointer;
            color: #666;
            transition: color 0.2s;
        }
        
        .close-modal:hover {
            color: #333;
        }
        
        .modal-body {
            padding: 20px;
        }
        
        .modal-footer {
            padding: 20px;
            border-top: 1px solid #eee;
            display: flex;
            justify-content: flex-end;
            gap: 10px;
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: #333;
        }
        
        .form-group input,
        .form-group select,
        .form-group textarea {
            width: 100%;
            padding: 12px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 1rem;
            transition: border-color 0.3s;
        }
        
        .form-group input:focus,
        .form-group select:focus,
        .form-group textarea:focus {
            outline: none;
            border-color: #8a4fff;
        }
        
        .form-group textarea {
            min-height: 100px;
            resize: vertical;
        }
        
        /* Footer */
        .dashboard-footer {
            margin-top: 50px;
            background: white;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 -2px 10px rgba(0, 0, 0, 0.05);
        }
        
        .footer-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 30px;
        }
        
        .footer-column h3,
        .footer-column h4 {
            color: #333;
            margin-bottom: 15px;
        }
        
        .footer-column p {
            color: #666;
            line-height: 1.6;
        }
        
        .footer-links {
            display: flex;
            flex-direction: column;
            gap: 10px;
        }
        
        .footer-links a {
            color: #666;
            text-decoration: none;
            transition: color 0.2s;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        
        .footer-links a:hover {
            color: #8a4fff;
        }
        
        .footer-bottom {
            margin-top: 30px;
            padding-top: 20px;
            border-top: 1px solid #eee;
            text-align: center;
            color: #666;
            font-size: 0.9rem;
        }
        
        /* Empty state */
        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: #666;
        }
        
        .empty-state i {
            font-size: 4rem;
            color: #ddd;
            margin-bottom: 20px;
            display: block;
        }
        
        .empty-state h3 {
            font-size: 1.5rem;
            margin-bottom: 10px;
            color: #333;
        }
    </style>
</head>
<body>
    <!-- Navigation (Same as adminDashboard) -->
    <nav class="top-navigation">
        <div class="nav-main">
            <div class="nav-top-row">
                <div class="logo-container">
                    <a href="adminDashboard.jsp" class="logo">
                        <i class="fas fa-crown logo-icon"></i>
                        <span class="logo-text">Admin Dashboard</span>
                    </a>
                </div>
                
                <div class="search-container">
                    <div class="search-box">
                        <input type="text" placeholder="Search products..." id="searchInput">
                        <button class="search-btn">
                            <i class="fas fa-search"></i>
                        </button>
                    </div>
                </div>
                
                <div class="user-menu-top">
                    <div class="admin-badge">
                        <i class="fas fa-shield-alt"></i>
                        <span>Administrator</span>
                    </div>
                    
                    <div class="logout-container">
                        <button class="logout-btn" onclick="logout()">
                            <i class="fas fa-sign-out-alt"></i>
                            <span>Logout</span>
                        </button>
                    </div>
                    
                    <div class="user-avatar-top">
                        <%
                            String username = (String) session.getAttribute("username");
                            String userInitial = "A";
                            if (username != null && !username.isEmpty()) {
                                userInitial = username.substring(0, 1).toUpperCase();
                            }
                        %>
                        <%= userInitial %>
                    </div>
                </div>
            </div>
            
            <div class="nav-bottom-row">
                <div class="nav-buttons">
                    <a href="adminDashboard.jsp" class="nav-button">
                        <i class="fas fa-tachometer-alt"></i>
                        <span>Dashboard</span>
                    </a>
                    <a href="manage-students.jsp" class="nav-button">
                        <i class="fas fa-users"></i>
                        <span>Students</span>
                    </a>
                    <a href="manage-products.jsp" class="nav-button active">
                        <i class="fas fa-boxes"></i>
                        <span>Products</span>
                        <span class="nav-badge" id="productsBadge">${empty totalProducts ? 0 : totalProducts}</span>
                    </a>
                </div>
            </div>
        </div>
    </nav>
    
    <!-- Main Content -->
    <div class="main-container">
        <!-- Welcome Header -->
        <div class="welcome-header">
            <h1><i class="fas fa-boxes"></i> Manage Products</h1>
            <p>View, edit, and manage marketplace products on Campus Marketplace</p>
        </div>
        
        <!-- Stats Summary -->
        <div class="stats-summary">
            <div class="stat-box">
                <h4>Total Products</h4>
                <div class="value">${empty totalProducts ? 0 : totalProducts}</div>
            </div>
            <div class="stat-box">
                <h4>Active</h4>
                <div class="value">${empty activeProducts ? 0 : activeProducts}</div>
            </div>
            <div class="stat-box">
                <h4>Pending</h4>
                <div class="value">${empty pendingProducts ? 0 : pendingProducts}</div>
            </div>
            <div class="stat-box">
                <h4>Sold</h4>
                <div class="value">${empty soldProducts ? 0 : soldProducts}</div>
            </div>
        </div>
        
        <!-- Controls -->
        <div class="admin-controls">
            <div class="search-bar">
                <i class="fas fa-search"></i>
                <input type="text" id="searchProducts" placeholder="Search products by name, category, or seller...">
            </div>
            <select class="btn btn-secondary" id="filterStatus">
                <option value="all">All Status</option>
                <option value="active">Active</option>
                <option value="pending">Pending Review</option>
                <option value="sold">Sold</option>
                <option value="removed">Removed</option>
            </select>
            <button class="btn btn-secondary" onclick="exportProducts()">
                <i class="fas fa-download"></i> Export CSV
            </button>
            <button class="btn btn-primary" onclick="openAddProductModal()">
                <i class="fas fa-plus"></i> Add Product
            </button>
        </div>
        
        <!-- Category Filter -->
        <div class="category-filter">
            <button class="category-btn active" data-category="all">All Categories</button>
            <button class="category-btn" data-category="books">Books</button>
            <button class="category-btn" data-category="electronics">Electronics</button>
            <button class="category-btn" data-category="furniture">Furniture</button>
            <button class="category-btn" data-category="clothing">Clothing</button>
            <button class="category-btn" data-category="other">Other</button>
        </div>
        
        <!-- Products Table -->
        <div class="table-container">
            <table id="productsTable">
                <thead>
                    <tr>
                        <th>Product</th>
                        <th>Category</th>
                        <th>Price</th>
                        <th>Seller</th>
                        <th>Status</th>
                        <th>Date Posted</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${not empty products}">
                            <c:forEach var="product" items="${products}">
                                <tr>
                                    <td>
                                        <div class="product-info">
                                            <div class="product-image">
                                                <c:choose>
                                                    <c:when test="${product.category == 'BOOKS' || product.category == 'books'}">
                                                        <i class="fas fa-book"></i>
                                                    </c:when>
                                                    <c:when test="${product.category == 'ELECTRONICS' || product.category == 'electronics'}">
                                                        <i class="fas fa-laptop"></i>
                                                    </c:when>
                                                    <c:when test="${product.category == 'FURNITURE' || product.category == 'furniture'}">
                                                        <i class="fas fa-chair"></i>
                                                    </c:when>
                                                    <c:when test="${product.category == 'CLOTHING' || product.category == 'clothing'}">
                                                        <i class="fas fa-tshirt"></i>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <i class="fas fa-box"></i>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                            <div class="product-details">
                                                <div class="product-title">${product.name}</div>
                                                <div class="product-id">ID: #${product.id}</div>
                                            </div>
                                        </div>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${product.category == 'BOOKS' || product.category == 'books'}">
                                                <span class="category-tag category-books">Books</span>
                                            </c:when>
                                            <c:when test="${product.category == 'ELECTRONICS' || product.category == 'electronics'}">
                                                <span class="category-tag category-electronics">Electronics</span>
                                            </c:when>
                                            <c:when test="${product.category == 'FURNITURE' || product.category == 'furniture'}">
                                                <span class="category-tag category-furniture">Furniture</span>
                                            </c:when>
                                            <c:when test="${product.category == 'CLOTHING' || product.category == 'clothing'}">
                                                <span class="category-tag category-clothing">Clothing</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="category-tag category-other">Other</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <div class="price">
                                            RM <fmt:formatNumber value="${product.price}" minFractionDigits="2" maxFractionDigits="2"/>
                                        </div>
                                    </td>
                                    <td>
                                        <div class="seller-info">
                                            <div class="seller-name">${product.sellerName}</div>
                                            <div class="seller-email">${product.sellerEmail}</div>
                                        </div>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${product.status == 'ACTIVE' || product.status == 'active'}">
                                                <span class="status-badge status-active">Active</span>
                                            </c:when>
                                            <c:when test="${product.status == 'PENDING' || product.status == 'pending'}">
                                                <span class="status-badge status-pending">Pending</span>
                                            </c:when>
                                            <c:when test="${product.status == 'SOLD' || product.status == 'sold'}">
                                                <span class="status-badge status-sold">Sold</span>
                                            </c:when>
                                            <c:when test="${product.status == 'REMOVED' || product.status == 'removed'}">
                                                <span class="status-badge status-removed">Removed</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="status-badge">${product.status}</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${not empty product.createdAt}">
                                                <fmt:formatDate value="${product.createdAt}" pattern="MMM dd, yyyy"/>
                                            </c:when>
                                            <c:otherwise>
                                                N/A
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <div class="action-buttons">
                                            <button class="icon-btn view" onclick="viewProduct(${product.id})" title="View">
                                                <i class="fas fa-eye"></i>
                                            </button>
                                            <button class="icon-btn edit" onclick="editProduct(${product.id})" title="Edit">
                                                <i class="fas fa-edit"></i>
                                            </button>
                                            <button class="icon-btn delete" onclick="deleteProduct(${product.id})" title="Delete">
                                                <i class="fas fa-trash"></i>
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr>
                                <td colspan="7" style="text-align: center; padding: 40px; color: #666;">
                                    <div class="empty-state">
                                        <i class="fas fa-box-open"></i>
                                        <h3>No Products Found</h3>
                                        <p>There are no products in the database yet.</p>
                                    </div>
                                </td>
                            </tr>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>
        
        <!-- Pagination -->
        <c:if test="${not empty products}">
            <div class="pagination">
                <button class="page-btn" ${page <= 1 ? 'disabled' : ''} onclick="changePage(${page-1})">
                    <i class="fas fa-chevron-left"></i> Previous
                </button>
                <span class="page-info">Page ${page} of ${totalPages}</span>
                <button class="page-btn" ${page >= totalPages ? 'disabled' : ''} onclick="changePage(${page+1})">
                    Next <i class="fas fa-chevron-right"></i>
                </button>
            </div>
        </c:if>
    </div>
    
    <!-- Footer -->
    <footer class="dashboard-footer">
        <div class="footer-content">
            <div class="footer-grid">
                <div class="footer-column">
                    <h3><i class="fas fa-crown"></i> Admin Panel</h3>
                    <p>Campus Marketplace Administration System. Manage students, products, and platform settings.</p>
                </div>
                <div class="footer-column">
                    <h4>Quick Links</h4>
                    <div class="footer-links">
                        <a href="adminDashboard.jsp"><i class="fas fa-tachometer-alt"></i> Dashboard</a>
                        <a href="manage-students.jsp"><i class="fas fa-users"></i> Students</a>
                        <a href="manage-products.jsp"><i class="fas fa-boxes"></i> Products</a>
                        <a href="reports.jsp"><i class="fas fa-chart-bar"></i> Reports</a>
                    </div>
                </div>
                <div class="footer-column">
                    <h4>System Status</h4>
                    <div class="footer-links">
                        <a style="color: #4CAF50;"><i class="fas fa-circle"></i> Operational</a>
                        <a style="color: #4CAF50;"><i class="fas fa-database"></i> Database: Connected</a>
                        <a><i class="fas fa-clock"></i> Last Updated: Just now</a>
                    </div>
                </div>
            </div>
            <div class="footer-bottom">
                <p>&copy; 2024 Campus Marketplace Admin Panel. Restricted Access. | Version 2.1.0</p>
            </div>
        </div>
    </footer>
    
    <!-- Add Product Modal -->
    <div id="addProductModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h3>Add New Product</h3>
                <button class="close-modal" onclick="closeModal()">&times;</button>
            </div>
            <form id="addProductForm">
                <div class="modal-body">
                    <div class="form-group">
                        <label>Product Name *</label>
                        <input type="text" name="name" required>
                    </div>
                    <div class="form-group">
                        <label>Description *</label>
                        <textarea name="description" required></textarea>
                    </div>
                    <div class="form-group">
                        <label>Category *</label>
                        <select name="category" required>
                            <option value="">Select Category</option>
                            <option value="BOOKS">Books</option>
                            <option value="ELECTRONICS">Electronics</option>
                            <option value="FURNITURE">Furniture</option>
                            <option value="CLOTHING">Clothing</option>
                            <option value="OTHER">Other</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Price (RM) *</label>
                        <input type="number" name="price" step="0.01" min="0" required>
                    </div>
                    <div class="form-group">
                        <label>Quantity *</label>
                        <input type="number" name="quantity" min="0" required value="1">
                    </div>
                    <div class="form-group">
                        <label>Condition</label>
                        <select name="condition">
                            <option value="NEW">New</option>
                            <option value="LIKE_NEW">Like New</option>
                            <option value="GOOD">Good</option>
                            <option value="FAIR">Fair</option>
                            <option value="POOR">Poor</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Seller Username</label>
                        <input type="text" name="sellerUsername" placeholder="Leave empty for admin">
                    </div>
                    <div class="form-group">
                        <label>Initial Status</label>
                        <select name="status">
                            <option value="ACTIVE">Active</option>
                            <option value="PENDING">Pending Review</option>
                            <option value="INACTIVE">Inactive</option>
                        </select>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" onclick="closeModal()">Cancel</button>
                    <button type="submit" class="btn btn-primary">Add Product</button>
                </div>
            </form>
        </div>
    </div>
    
    <script>
        // Modal functions
        function openAddProductModal() {
            document.getElementById('addProductModal').style.display = 'flex';
        }
        
        function closeModal() {
            document.getElementById('addProductModal').style.display = 'none';
        }
        
        // Close modal when clicking outside
        window.onclick = function(event) {
            const modal = document.getElementById('addProductModal');
            if (event.target === modal) {
                closeModal();
            }
        }
        
        // Form submission
        document.getElementById('addProductForm')?.addEventListener('submit', function(e) {
            e.preventDefault();
            alert('In a real application, this would submit the form to add a new product.');
            closeModal();
        });
        
        // Product actions
        function viewProduct(productId) {
            window.location.href = `product-detail.jsp?id=${productId}`;
        }
        
        function editProduct(productId) {
            window.location.href = `admin?action=editProduct&id=${productId}`;
        }
        
        function deleteProduct(productId) {
            if (confirm('Are you sure you want to delete this product? This action cannot be undone.')) {
                window.location.href = `admin?action=deleteProduct&id=${productId}`;
            }
        }
        
        function exportProducts() {
            alert('Export functionality would download a CSV file of all products.');
        }
        
        // Search functionality
        document.getElementById('searchProducts')?.addEventListener('input', function(e) {
            const searchTerm = e.target.value.toLowerCase();
            const rows = document.querySelectorAll('#productsTable tbody tr');
            
            rows.forEach(row => {
                const text = row.textContent.toLowerCase();
                row.style.display = text.includes(searchTerm) ? '' : 'none';
            });
        });
        
        // Filter by status
        document.getElementById('filterStatus')?.addEventListener('change', function(e) {
            const status = e.target.value;
            const rows = document.querySelectorAll('#productsTable tbody tr');
            
            rows.forEach(row => {
                if (status === 'all') {
                    row.style.display = '';
                } else {
                    const badge = row.querySelector('.status-badge');
                    if (badge) {
                        const rowStatus = badge.textContent.toLowerCase();
                        row.style.display = rowStatus.includes(status) ? '' : 'none';
                    }
                }
            });
        });
        
        // Category filter
        document.querySelectorAll('.category-btn').forEach(btn => {
            btn.addEventListener('click', function() {
                // Update active button
                document.querySelectorAll('.category-btn').forEach(b => {
                    b.classList.remove('active');
                });
                this.classList.add('active');
                
                const category = this.dataset.category;
                const rows = document.querySelectorAll('#productsTable tbody tr');
                
                rows.forEach(row => {
                    if (category === 'all') {
                        row.style.display = '';
                    } else {
                        const categoryCell = row.querySelector('.category-tag');
                        if (categoryCell) {
                            const categoryText = categoryCell.textContent.toLowerCase();
                            row.style.display = categoryText.includes(category) ? '' : 'none';
                        }
                    }
                });
            });
        });
        
        // Pagination
        function changePage(newPage) {
            window.location.href = `admin?action=products&page=${newPage}`;
        }
        
        // Logout
        function logout() {
            if (confirm('Are you sure you want to logout from admin panel?')) {
                window.location.href = 'LogoutServlet';
            }
        }
        
        // Initialize table sorting
        document.addEventListener('DOMContentLoaded', function() {
            const table = document.getElementById('productsTable');
            if (table) {
                const headers = table.querySelectorAll('th');
                headers.forEach((header, index) => {
                    header.style.cursor = 'pointer';
                    header.addEventListener('click', () => {
                        sortTable(index);
                    });
                });
            }
        });
        
        // Simple table sorting
        function sortTable(columnIndex) {
            const table = document.getElementById('productsTable');
            const tbody = table.querySelector('tbody');
            const rows = Array.from(tbody.querySelectorAll('tr'));
            
            rows.sort((a, b) => {
                const aText = a.cells[columnIndex].textContent.trim();
                const bText = b.cells[columnIndex].textContent.trim();
                
                if (columnIndex === 2) { // Price column
                    const aPrice = parseFloat(aText.replace('RM ', '').replace(',', ''));
                    const bPrice = parseFloat(bText.replace('RM ', '').replace(',', ''));
                    return aPrice - bPrice;
                }
                
                if (columnIndex === 5) { // Date column
                    // Simple date comparison - in real app use Date objects
                    return aText.localeCompare(bText);
                }
                
                return aText.localeCompare(bText);
            });
            
            // Reverse if already sorted
            if (table.dataset.sortedColumn === columnIndex) {
                rows.reverse();
                table.dataset.sortedColumn = null;
            } else {
                table.dataset.sortedColumn = columnIndex;
            }
            
            // Re-append rows
            rows.forEach(row => tbody.appendChild(row));
        }
    </script>
</body>
</html>