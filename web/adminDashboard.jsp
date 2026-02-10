<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, com.campusmarketplace.dao.DatabaseConnection" %>
<%
    // Check if user is logged in and is admin
    if (session.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    // Get statistics
    int studentCount = 0;
    int productCount = 0;
    int activeListings = 0;
    
    try (Connection conn = DatabaseConnection.getConnection()) {
        // Get student count
        try (Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery("SELECT COUNT(*) as count FROM users WHERE role = 'STUDENT' OR user_type = 'student'")) {
            if (rs.next()) studentCount = rs.getInt("count");
        }
        
        // Get product count
        try (Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery("SELECT COUNT(*) as count FROM products")) {
            if (rs.next()) productCount = rs.getInt("count");
        }
        
        // Get active listings
        try (Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery("SELECT COUNT(*) as count FROM products WHERE status = 'ACTIVE'")) {
            if (rs.next()) activeListings = rs.getInt("count");
        }
        
    } catch (SQLException e) {
        e.printStackTrace();
    }
    
    // Get user initial for avatar
    String user = (String) session.getAttribute("username");
    String userInitial = "A";
    if (user != null && !user.isEmpty()) {
        userInitial = user.substring(0, 1).toUpperCase();
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Campus Marketplace</title>
    
    <!-- External CSS Links -->
    <link rel="stylesheet" href="css/dashboard.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        /* Admin Specific Styles */
        .admin-stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
            gap: 20px;
            margin: 30px 0;
        }
        
        .admin-stat-card {
            background: white;
            border-radius: 15px;
            padding: 25px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
            border-left: 5px solid #8a4fff;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        
        .admin-stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 20px rgba(138, 79, 255, 0.15);
        }
        
        .admin-stat-card.students { border-left-color: #4CAF50; }
        .admin-stat-card.products { border-left-color: #2196F3; }
        .admin-stat-card.listings { border-left-color: #FF9800; }
        .admin-stat-card.reports { border-left-color: #9C27B0; }
        
        .stat-icon {
            width: 60px;
            height: 60px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 24px;
            margin-bottom: 15px;
        }
        
        .stat-icon.students { background: rgba(76, 175, 80, 0.1); color: #4CAF50; }
        .stat-icon.products { background: rgba(33, 150, 243, 0.1); color: #2196F3; }
        .stat-icon.listings { background: rgba(255, 152, 0, 0.1); color: #FF9800; }
        .stat-icon.reports { background: rgba(156, 39, 176, 0.1); color: #9C27B0; }
        
        .stat-number {
            font-size: 2.5em;
            font-weight: 700;
            color: #333;
            line-height: 1;
            margin: 10px 0;
        }
        
        .stat-label {
            font-size: 0.9em;
            color: #666;
            font-weight: 500;
        }
        
        .stat-change {
            display: flex;
            align-items: center;
            gap: 5px;
            font-size: 0.85em;
            margin-top: 10px;
        }
        
        .stat-change.positive { color: #4CAF50; }
        .stat-change.negative { color: #F44336; }
        
        /* Admin Actions Grid */
        .admin-actions-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 25px;
            margin: 40px 0;
        }
        
        .admin-action-card {
            background: white;
            border-radius: 15px;
            padding: 30px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
            transition: all 0.3s ease;
            text-align: center;
            border: 2px solid transparent;
        }
        
        .admin-action-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(138, 79, 255, 0.15);
            border-color: #8a4fff;
        }
        
        .action-icon {
            width: 70px;
            height: 70px;
            border-radius: 50%;
            background: linear-gradient(135deg, #8a4fff, #6c63ff);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 28px;
            color: white;
            margin: 0 auto 20px;
        }
        
        .action-title {
            font-size: 1.2em;
            font-weight: 600;
            color: #333;
            margin-bottom: 10px;
        }
        
        .action-description {
            color: #666;
            font-size: 0.9em;
            line-height: 1.5;
            margin-bottom: 20px;
        }
        
        .action-btn {
            background: linear-gradient(135deg, #8a4fff, #6c63ff);
            color: white;
            border: none;
            padding: 10px 25px;
            border-radius: 25px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }
        
        .action-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(138, 79, 255, 0.3);
        }
        
        /* Recent Activity */
        .recent-activity {
            background: white;
            border-radius: 15px;
            padding: 25px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
            margin-top: 30px;
        }
        
        .activity-list {
            margin-top: 20px;
        }
        
        .activity-item {
            display: flex;
            align-items: center;
            padding: 15px;
            border-bottom: 1px solid #eee;
            transition: background 0.2s;
        }
        
        .activity-item:hover {
            background: #f9f9f9;
        }
        
        .activity-item:last-child {
            border-bottom: none;
        }
        
        .activity-icon {
            width: 40px;
            height: 40px;
            border-radius: 10px;
            background: rgba(138, 79, 255, 0.1);
            display: flex;
            align-items: center;
            justify-content: center;
            color: #8a4fff;
            margin-right: 15px;
        }
        
        .activity-content {
            flex: 1;
        }
        
        .activity-title {
            font-weight: 500;
            color: #333;
            margin-bottom: 3px;
        }
        
        .activity-time {
            font-size: 0.85em;
            color: #888;
        }
        
        /* Quick Stats */
        .quick-stats-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 15px;
            margin: 25px 0;
        }
        
        .quick-stat {
            background: white;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0 3px 10px rgba(0, 0, 0, 0.05);
            text-align: center;
        }
        
        .quick-stat i {
            font-size: 24px;
            color: #8a4fff;
            margin-bottom: 10px;
        }
        
        .quick-stat-value {
            font-size: 1.8em;
            font-weight: 600;
            color: #333;
        }
        
        .quick-stat-label {
            font-size: 0.9em;
            color: #666;
            margin-top: 5px;
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
                    <a href="adminDashboard.jsp" class="logo">
                        <i class="fas fa-crown logo-icon"></i>
                        <span class="logo-text">Admin Dashboard</span>
                    </a>
                </div>

                <div class="search-container">
                    <div class="search-box">
                        <input type="text" placeholder="Search students, products..." id="adminSearch">
                        <button class="search-btn" id="adminSearchBtn">
                            <i class="fas fa-search"></i>
                        </button>
                    </div>
                </div>

                <div class="user-menu-top">
                    <!-- Admin Badge -->
                    <div class="admin-badge">
                        <i class="fas fa-shield-alt"></i>
                        <span>Admin</span>
                    </div>
                    
                    <!-- Logout Button -->
                    <div class="logout-container">
                        <button class="logout-btn" onclick="logout()" title="Logout">
                            <i class="fas fa-sign-out-alt"></i>
                            <span>Logout</span>
                        </button>
                    </div>
                    
                    <!-- User Avatar -->
                    <div class="user-avatar-top" title="Admin Profile" onclick="window.location.href='profile.jsp'">
                        <%= userInitial %>
                    </div>
                </div>
            </div>

            <!-- Bottom Row: Admin Navigation -->
            <div class="nav-bottom-row">
                <div class="nav-buttons">
                    <a href="adminDashboard.jsp" class="nav-button active">
                        <i class="fas fa-tachometer-alt"></i>
                        <span>Dashboard</span>
                    </a>
                    <a href="manage-students.jsp" class="nav-button">
                        <i class="fas fa-users"></i>
                        <span>Students</span>
                        <span class="nav-badge" id="studentsBadge"><%= studentCount %></span>
                    </a>
                    <a href="manage-products.jsp" class="nav-button">
                        <i class="fas fa-boxes"></i>
                        <span>Products</span>
                        <span class="nav-badge" id="productsBadge"><%= productCount %></span>
                    </a>
                </div>
            </div>
        </div>
    </nav>

    <!-- ===== MAIN CONTENT SECTION ===== -->
    <div class="main-container">
        <!-- Welcome Banner -->
        <div class="welcome-header">
            <h1><i class="fas fa-crown"></i> Admin Dashboard</h1>
            <p>Manage students, products for Campus Marketplace</p>
        </div>

        <!-- Statistics Cards -->
        <div class="admin-stats-grid">
            <div class="admin-stat-card students">
                <div class="stat-icon students">
                    <i class="fas fa-users"></i>
                </div>
                <div class="stat-number"><%= studentCount %></div>
                <div class="stat-label">Total Students</div>
                <div class="stat-change positive">
                    <i class="fas fa-arrow-up"></i>
                    <span>12% from last month</span>
                </div>
            </div>
            
            <div class="admin-stat-card products">
                <div class="stat-icon products">
                    <i class="fas fa-boxes"></i>
                </div>
                <div class="stat-number"><%= productCount %></div>
                <div class="stat-label">Total Products</div>
                <div class="stat-change positive">
                    <i class="fas fa-arrow-up"></i>
                    <span>8% from last week</span>
                </div>
            </div>
            
            <div class="admin-stat-card listings">
                <div class="stat-icon listings">
                    <i class="fas fa-store"></i>
                </div>
                <div class="stat-number"><%= activeListings %></div>
                <div class="stat-label">Active Listings</div>
                <div class="stat-change positive">
                    <i class="fas fa-arrow-up"></i>
                    <span>5 new today</span>
                </div>
            </div>
        </div>

        <!-- Quick Stats -->
        <div class="quick-stats-container">
            <div class="quick-stat">
                <i class="fas fa-check-circle"></i>
                <div class="quick-stat-value"><%= activeListings %></div>
                <div class="quick-stat-label">Active Listings</div>
            </div>
            <div class="quick-stat">
                <i class="fas fa-clock"></i>
                <div class="quick-stat-value">3</div>
                <div class="quick-stat-label">Pending Reviews</div>
            </div>
            <div class="quick-stat">
                <i class="fas fa-user-graduate"></i>
                <div class="quick-stat-value"><%= studentCount %></div>
                <div class="quick-stat-label">Registered Students</div>
            </div>
            <div class="quick-stat">
                <i class="fas fa-chart-line"></i>
                <div class="quick-stat-value"><%= productCount %></div>
                <div class="quick-stat-label">Total Products</div>
            </div>
        </div>

        <!-- Admin Actions Grid -->
        <h2 style="margin-top: 40px; color: #333; font-size: 1.5em;">
            <i class="fas fa-cogs"></i> Management Tools
        </h2>
        
        <div class="admin-actions-grid">
            <div class="admin-action-card">
                <div class="action-icon">
                    <i class="fas fa-users-cog"></i>
                </div>
                <div class="action-title">Manage Students</div>
                <div class="action-description">
                    View, add, edit, or deactivate student accounts. Monitor student activity and resolve issues.
                </div>
                <button class="action-btn" onclick="window.location.href='manage-students.jsp'">
                    <i class="fas fa-arrow-right"></i> Manage Students
                </button>
            </div>
            
            <div class="admin-action-card">
                <div class="action-icon">
                    <i class="fas fa-boxes"></i>
                </div>
                <div class="action-title">Manage Products</div>
                <div class="action-description">
                    Review, approve, or remove product listings. Monitor product categories and pricing.
                </div>
                <button class="action-btn" onclick="window.location.href='manage-products.jsp'">
                    <i class="fas fa-arrow-right"></i> Manage Products
                </button>
            </div>
        </div>

        <!-- Recent Activity -->
        <div class="recent-activity">
            <h3 style="color: #333; font-size: 1.3em; margin-bottom: 20px;">
                <i class="fas fa-history"></i> Recent Activity
            </h3>
            
            <div class="activity-list">
                <div class="activity-item">
                    <div class="activity-icon">
                        <i class="fas fa-user-plus"></i>
                    </div>
                    <div class="activity-content">
                        <div class="activity-title">New student registration: John Smith</div>
                        <div class="activity-time">10 minutes ago</div>
                    </div>
                </div>
                
                <div class="activity-item">
                    <div class="activity-icon">
                        <i class="fas fa-box"></i>
                    </div>
                    <div class="activity-content">
                        <div class="activity-title">New product listed: "Calculus Textbook"</div>
                        <div class="activity-time">1 hour ago</div>
                    </div>
                </div>
                
                <div class="activity-item">
                    <div class="activity-icon">
                        <i class="fas fa-chart-bar"></i>
                    </div>
                    <div class="activity-content">
                        <div class="activity-title">Monthly report generated for October</div>
                        <div class="activity-time">2 hours ago</div>
                    </div>
                </div>
                
                <div class="activity-item">
                    <div class="activity-icon">
                        <i class="fas fa-flag"></i>
                    </div>
                    <div class="activity-content">
                        <div class="activity-title">Product complaint resolved: #RC-45</div>
                        <div class="activity-time">4 hours ago</div>
                    </div>
                </div>
                
                <div class="activity-item">
                    <div class="activity-icon">
                        <i class="fas fa-user-check"></i>
                    </div>
                    <div class="activity-content">
                        <div class="activity-title">Student account verified: Sarah Johnson</div>
                        <div class="activity-time">Yesterday, 3:45 PM</div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- ===== FOOTER SECTION ===== -->
    <footer class="dashboard-footer">
        <div class="footer-content">
            <div class="footer-grid">
                <div class="footer-column">
                    <h3><i class="fas fa-crown"></i> Admin Dashboard</h3>
                    <p>Campus Marketplace Administration Panel. Manage platform operations, users, and content.</p>
                </div>
                <div class="footer-column">
                    <h4>Quick Links</h4>
                    <div class="footer-links">
                        <a href="adminDashboard.jsp"><i class="fas fa-tachometer-alt"></i> Dashboard</a>
                        <a href="manage-students.jsp"><i class="fas fa-users"></i> Students</a>
                        <a href="manage-products.jsp"><i class="fas fa-boxes"></i> Products</a>
                    </div>
                </div>
                <div class="footer-column">
                    <h4>System Status</h4>
                    <div class="footer-links">
                        <a style="color: #4CAF50;"><i class="fas fa-circle"></i> System: Operational</a>
                        <a style="color: #4CAF50;"><i class="fas fa-circle"></i> Database: Connected</a>
                        <a style="color: #4CAF50;"><i class="fas fa-circle"></i> Server: Online</a>
                        <a><i class="fas fa-clock"></i> Last Updated: Just now</a>
                    </div>
                </div>
            </div>
            <div class="footer-bottom">
                <p>&copy; 2024 Campus Marketplace Admin Panel. Restricted Access. | Version 2.1.0</p>
            </div>
        </div>
    </footer>

    <!-- ===== JAVASCRIPT FUNCTIONS ===== -->
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            initializeAdminDashboard();
        });

        function initializeAdminDashboard() {
            setupAdminSearch();
            setupStatCards();
            setupActivityUpdates();
        }

        function setupAdminSearch() {
            const searchInput = document.getElementById('adminSearch');
            const searchBtn = document.getElementById('adminSearchBtn');
            
            if (searchBtn) {
                searchBtn.addEventListener('click', performAdminSearch);
            }
            
            if (searchInput) {
                searchInput.addEventListener('keypress', function(e) {
                    if (e.key === 'Enter') {
                        performAdminSearch();
                    }
                });
            }
        }

        function performAdminSearch() {
            const searchInput = document.getElementById('adminSearch');
            const query = searchInput.value.trim();
            
            if (query) {
                // Determine what to search based on query
                if (query.includes('@')) {
                    window.location.href = 'manage-students.jsp?email=' + encodeURIComponent(query);
                } else {
                    window.location.href = 'manage-students.jsp?search=' + encodeURIComponent(query);
                }
            }
        }

        function setupStatCards() {
            // Animate stat cards on load
            const statCards = document.querySelectorAll('.admin-stat-card');
            statCards.forEach((card, index) => {
                card.style.opacity = '0';
                card.style.transform = 'translateY(20px)';
                
                setTimeout(() => {
                    card.style.transition = 'opacity 0.5s ease, transform 0.5s ease';
                    card.style.opacity = '1';
                    card.style.transform = 'translateY(0)';
                }, index * 100);
            });
        }

        function setupActivityUpdates() {
            // Simulate real-time updates
            setInterval(() => {
                updateLiveStats();
            }, 30000); // Update every 30 seconds
        }

        function updateLiveStats() {
            // In a real app, this would fetch from an API
            console.log('Updating admin dashboard stats...');
            
            // Update badges
            const studentsBadge = document.getElementById('studentsBadge');
            const productsBadge = document.getElementById('productsBadge');
            
            if (studentsBadge) {
                const current = parseInt(studentsBadge.textContent);
                if (current > 0) {
                    studentsBadge.textContent = current + Math.floor(Math.random() * 3);
                }
            }
            
            if (productsBadge) {
                const current = parseInt(productsBadge.textContent);
                if (current > 0) {
                    productsBadge.textContent = current + Math.floor(Math.random() * 5);
                }
            }
        }

        function logout() {
            if (confirm('Are you sure you want to logout from admin panel?')) {
                window.location.href = 'LogoutServlet';
            }
        }

        // Admin notification function
        function showAdminNotification(message, type = 'info') {
            const notification = document.createElement('div');
            notification.className = 'notification admin-notification ' + type;
            
            let icon = 'info-circle';
            if (type === 'success') icon = 'check-circle';
            if (type === 'warning') icon = 'exclamation-triangle';
            if (type === 'error') icon = 'times-circle';
            
            notification.innerHTML = `
                <i class="fas fa-${icon}"></i>
                <span>${message}</span>
                <button class="notification-close" onclick="this.parentElement.remove()">
                    <i class="fas fa-times"></i>
                </button>
            `;
            
            document.body.appendChild(notification);
            
            setTimeout(() => {
                notification.classList.add('show');
            }, 10);
            
            // Auto-remove after 5 seconds
            setTimeout(() => {
                notification.classList.remove('show');
                setTimeout(() => {
                    if (notification.parentNode) {
                        notification.parentNode.removeChild(notification);
                    }
                }, 300);
            }, 5000);
        }

        // Quick action shortcuts
        document.addEventListener('keydown', function(e) {
            // Ctrl+Shift+S for students management
            if (e.ctrlKey && e.shiftKey && e.key === 'S') {
                e.preventDefault();
                window.location.href = 'manage-students.jsp';
            }
            
            // Ctrl+Shift+P for products management
            if (e.ctrlKey && e.shiftKey && e.key === 'P') {
                e.preventDefault();
                window.location.href = 'manage-products.jsp';
            }
        });
    </script>
</body>
</html>