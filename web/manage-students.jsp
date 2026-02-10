<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Students - Admin Dashboard</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
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
        
        .user-avatar {
            width: 45px;
            height: 45px;
            border-radius: 50%;
            background: linear-gradient(135deg, #8a4fff, #6c63ff);
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 600;
            font-size: 1rem;
        }
        
        .user-info {
            display: flex;
            align-items: center;
            gap: 12px;
        }
        
        .user-details {
            display: flex;
            flex-direction: column;
        }
        
        .user-details strong {
            font-size: 1rem;
            color: #333;
        }
        
        .user-details .username {
            font-size: 0.85rem;
            color: #666;
            margin-top: 2px;
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
        
        .status-inactive {
            background-color: rgba(244, 67, 54, 0.1);
            color: #F44336;
        }
        
        .status-pending {
            background-color: rgba(255, 152, 0, 0.1);
            color: #FF9800;
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
            max-width: 500px;
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
        .form-group select {
            width: 100%;
            padding: 12px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 1rem;
            transition: border-color 0.3s;
        }
        
        .form-group input:focus,
        .form-group select:focus {
            outline: none;
            border-color: #8a4fff;
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
                        <input type="text" placeholder="Search students..." id="searchInput">
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
                    <a href="manage-students.jsp" class="nav-button active">
                        <i class="fas fa-users"></i>
                        <span>Students</span>
                        <span class="nav-badge" id="studentsBadge">${totalStudents}</span>
                    </a>
                    <a href="manage-products.jsp" class="nav-button">
                        <i class="fas fa-boxes"></i>
                        <span>Products</span>
                        <span class="nav-badge" id="productsBadge">0</span>
                    </a>
                </div>
            </div>
        </div>
    </nav>
    
    <!-- Main Content -->
    <div class="main-container">
        <!-- Welcome Header -->
        <div class="welcome-header">
            <h1><i class="fas fa-users"></i> Manage Students</h1>
            <p>View, edit, and manage student accounts on Campus Marketplace</p>
        </div>
        
        <!-- Stats Summary -->
        <div class="stats-summary">
            <div class="stat-box">
                <h4>Total Students</h4>
                <div class="value">${empty totalStudents ? 0 : totalStudents}</div>
            </div>
            <div class="stat-box">
                <h4>Active</h4>
                <div class="value">${empty activeStudents ? 0 : activeStudents}</div>
            </div>
            <div class="stat-box">
                <h4>Pending</h4>
                <div class="value">${empty pendingStudents ? 0 : pendingStudents}</div>
            </div>
            <div class="stat-box">
                <h4>Inactive</h4>
                <div class="value">${empty inactiveStudents ? 0 : inactiveStudents}</div>
            </div>
        </div>
        
        <!-- Controls -->
        <div class="admin-controls">
            <div class="search-bar">
                <i class="fas fa-search"></i>
                <input type="text" id="searchStudents" placeholder="Search students by name, email, or username...">
            </div>
            <select class="btn btn-secondary" id="filterStatus">
                <option value="all">All Status</option>
                <option value="active">Active</option>
                <option value="inactive">Inactive</option>
                <option value="pending">Pending</option>
            </select>
            <button class="btn btn-secondary" onclick="exportStudents()">
                <i class="fas fa-download"></i> Export CSV
            </button>
            <button class="btn btn-primary" onclick="openAddStudentModal()">
                <i class="fas fa-user-plus"></i> Add New Student
            </button>
        </div>
        
        <!-- Students Table -->
        <div class="table-container">
            <table id="studentsTable">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Student</th>
                        <th>Email</th>
                        <th>Major</th>
                        <th>Joined</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${not empty students}">
                            <c:forEach var="student" items="${students}">
                                <tr>
                                    <td>#${student.id}</td>
                                    <td>
                                        <div class="user-info">
                                            <div class="user-avatar">
                                                ${not empty student.firstName ? student.firstName.substring(0, 1).toUpperCase() : 'S'}
                                            </div>
                                            <div class="user-details">
                                                <strong>${student.firstName} ${student.lastName}</strong>
                                                <span class="username">@${student.username}</span>
                                            </div>
                                        </div>
                                    </td>
                                    <td>${student.email}</td>
                                    <td>${empty student.major ? 'Not specified' : student.major}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${not empty student.createdAt}">
                                                <fmt:formatDate value="${student.createdAt}" pattern="MMM dd, yyyy"/>
                                            </c:when>
                                            <c:otherwise>
                                                N/A
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${student.status == 'ACTIVE' || student.active == true}">
                                                <span class="status-badge status-active">Active</span>
                                            </c:when>
                                            <c:when test="${student.status == 'INACTIVE' || student.active == false}">
                                                <span class="status-badge status-inactive">Inactive</span>
                                            </c:when>
                                            <c:when test="${student.status == 'PENDING'}">
                                                <span class="status-badge status-pending">Pending</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="status-badge">${student.status}</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <div class="action-buttons">
                                            <button class="icon-btn view" onclick="viewStudent(${student.id})" title="View">
                                                <i class="fas fa-eye"></i>
                                            </button>
                                            <button class="icon-btn edit" onclick="editStudent(${student.id})" title="Edit">
                                                <i class="fas fa-edit"></i>
                                            </button>
                                            <button class="icon-btn delete" onclick="deleteStudent(${student.id})" title="Delete">
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
                                    <i class="fas fa-users" style="font-size: 3rem; margin-bottom: 15px; color: #ddd; display: block;"></i>
                                    No students found in the database.
                                </td>
                            </tr>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>
        
        <!-- Pagination -->
        <c:if test="${not empty students}">
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
                    <p>Campus Marketplace Administration System. Manage students, products, orders, and platform settings.</p>
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
    
    <!-- Add Student Modal -->
    <div id="addStudentModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h3>Add New Student</h3>
                <button class="close-modal" onclick="closeModal()">&times;</button>
            </div>
            <form id="addStudentForm">
                <div class="modal-body">
                    <div class="form-group">
                        <label>First Name *</label>
                        <input type="text" name="firstName" required>
                    </div>
                    <div class="form-group">
                        <label>Last Name *</label>
                        <input type="text" name="lastName" required>
                    </div>
                    <div class="form-group">
                        <label>Email *</label>
                        <input type="email" name="email" required>
                    </div>
                    <div class="form-group">
                        <label>Username *</label>
                        <input type="text" name="username" required>
                    </div>
                    <div class="form-group">
                        <label>Major/Program</label>
                        <input type="text" name="major">
                    </div>
                    <div class="form-group">
                        <label>Initial Status</label>
                        <select name="status">
                            <option value="ACTIVE">Active</option>
                            <option value="PENDING">Pending</option>
                            <option value="INACTIVE">Inactive</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Temporary Password</label>
                        <input type="text" name="tempPassword" value="student123" readonly>
                        <small style="color: #666; display: block; margin-top: 5px;">Student will be asked to change this on first login</small>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" onclick="closeModal()">Cancel</button>
                    <button type="submit" class="btn btn-primary">Add Student</button>
                </div>
            </form>
        </div>
    </div>
    
    <script>
        // Modal functions
        function openAddStudentModal() {
            document.getElementById('addStudentModal').style.display = 'flex';
        }
        
        function closeModal() {
            document.getElementById('addStudentModal').style.display = 'none';
        }
        
        // Close modal when clicking outside
        window.onclick = function(event) {
            const modal = document.getElementById('addStudentModal');
            if (event.target === modal) {
                closeModal();
            }
        }
        
        // Form submission
        document.getElementById('addStudentForm')?.addEventListener('submit', function(e) {
            e.preventDefault();
            alert('In a real application, this would submit the form to add a new student.');
            closeModal();
        });
        
        // Student actions
        function viewStudent(studentId) {
            window.location.href = `admin?action=viewStudent&id=${studentId}`;
        }
        
        function editStudent(studentId) {
            window.location.href = `admin?action=editStudent&id=${studentId}`;
        }
        
        function deleteStudent(studentId) {
            if (confirm('Are you sure you want to delete this student? This action cannot be undone.')) {
                window.location.href = `admin?action=deleteStudent&id=${studentId}`;
            }
        }
        
        function exportStudents() {
            alert('Export functionality would download a CSV file of all students.');
            // In real app: window.location.href = 'admin?action=exportStudents';
        }
        
        // Search functionality
        document.getElementById('searchStudents')?.addEventListener('input', function(e) {
            const searchTerm = e.target.value.toLowerCase();
            const rows = document.querySelectorAll('#studentsTable tbody tr');
            
            rows.forEach(row => {
                const text = row.textContent.toLowerCase();
                row.style.display = text.includes(searchTerm) ? '' : 'none';
            });
        });
        
        // Filter by status
        document.getElementById('filterStatus')?.addEventListener('change', function(e) {
            const status = e.target.value;
            const rows = document.querySelectorAll('#studentsTable tbody tr');
            
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
        
        // Pagination
        function changePage(newPage) {
            window.location.href = `admin?action=students&page=${newPage}`;
        }
        
        // Logout
        function logout() {
            if (confirm('Are you sure you want to logout from admin panel?')) {
                window.location.href = 'LogoutServlet';
            }
        }
        
        // Initialize table sorting
        document.addEventListener('DOMContentLoaded', function() {
            const table = document.getElementById('studentsTable');
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
            const table = document.getElementById('studentsTable');
            const tbody = table.querySelector('tbody');
            const rows = Array.from(tbody.querySelectorAll('tr'));
            
            rows.sort((a, b) => {
                const aText = a.cells[columnIndex].textContent.trim();
                const bText = b.cells[columnIndex].textContent.trim();
                
                if (columnIndex === 0) { // ID column
                    return parseInt(aText.replace('#', '')) - parseInt(bText.replace('#', ''));
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