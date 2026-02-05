<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.campusmarketplace.model.User" %>
<%
    // Check if user is logged in
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login");
        return;
    }
    
    // Check if user is admin
    if (!"admin".equals(user.getUserType())) {
        response.sendRedirect("dashboard.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Campus Marketplace</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/admin-dashboard.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body>
    <!-- Admin Navigation -->
    <div class="admin-wrapper">
        <!-- Sidebar -->
        <nav class="admin-sidebar">
            <div class="sidebar-header">
                <h2><i class="fas fa-cogs"></i> Admin Panel</h2>
                <p><%= user.getUsername() %></p>
            </div>
            
            <ul class="sidebar-menu">
                <li class="active">
                    <a href="admin-dashboard.jsp">
                        <i class="fas fa-tachometer-alt"></i> Dashboard
                    </a>
                </li>
                <li>
                    <a href="admin-users.jsp">
                        <i class="fas fa-users"></i> User Management
                    </a>
                </li>
                <li>
                    <a href="admin-items.jsp">
                        <i class="fas fa-boxes"></i> Item Management
                    </a>
                </li>
                <li>
                    <a href="admin-reports.jsp">
                        <i class="fas fa-chart-bar"></i> Reports & Analytics
                    </a>
                </li>
                <li>
                    <a href="admin-announcements.jsp">
                        <i class="fas fa-bullhorn"></i> Announcements
                    </a>
                </li>
                <li>
                    <a href="admin-categories.jsp">
                        <i class="fas fa-tags"></i> Categories
                    </a>
                </li>
                <li>
                    <a href="admin-settings.jsp">
                        <i class="fas fa-cog"></i> System Settings
                    </a>
                </li>
                <li class="logout-item">
                    <a href="logout" class="logout-btn">
                        <i class="fas fa-sign-out-alt"></i> Logout
                    </a>
                </li>
            </ul>
            
            <div class="sidebar-footer">
                <p>Campus Marketplace v1.0</p>
                <p>Admin Panel</p>
            </div>
        </nav>

        <!-- Main Content -->
        <div class="admin-main">
            <!-- Top Bar -->
            <header class="admin-topbar">
                <div class="topbar-left">
                    <button class="sidebar-toggle">
                        <i class="fas fa-bars"></i>
                    </button>
                    <h1>Admin Dashboard</h1>
                </div>
                <div class="topbar-right">
                    <div class="admin-notifications">
                        <button class="notification-btn">
                            <i class="fas fa-bell"></i>
                            <span class="notification-count">3</span>
                        </button>
                    </div>
                    <div class="admin-profile">
                        <img src="https://via.placeholder.com/40" alt="Admin">
                        <span><%= user.getUsername() %></span>
                    </div>
                </div>
            </header>

            <!-- Dashboard Content -->
            <div class="admin-content">
                <!-- Welcome Section -->
                <div class="welcome-section">
                    <h2>Welcome, Admin <%= user.getUsername() %>!</h2>
                    <p>Here's what's happening with your marketplace today.</p>
                </div>

                <!-- Stats Cards -->
                <div class="stats-grid">
                    <div class="stat-card">
                        <div class="stat-icon total-users">
                            <i class="fas fa-users"></i>
                        </div>
                        <div class="stat-info">
                            <h3>1,254</h3>
                            <p>Total Users</p>
                        </div>
                        <div class="stat-trend up">
                            <i class="fas fa-arrow-up"></i> 12%
                        </div>
                    </div>
                    
                    <div class="stat-card">
                        <div class="stat-icon active-items">
                            <i class="fas fa-box"></i>
                        </div>
                        <div class="stat-info">
                            <h3>342</h3>
                            <p>Active Items</p>
                        </div>
                        <div class="stat-trend up">
                            <i class="fas fa-arrow-up"></i> 8%
                        </div>
                    </div>
                    
                    <div class="stat-card">
                        <div class="stat-icon transactions">
                            <i class="fas fa-exchange-alt"></i>
                        </div>
                        <div class="stat-info">
                            <h3>89</h3>
                            <p>Today's Transactions</p>
                        </div>
                        <div class="stat-trend down">
                            <i class="fas fa-arrow-down"></i> 3%
                        </div>
                    </div>
                    
                    <div class="stat-card">
                        <div class="stat-icon revenue">
                            <i class="fas fa-dollar-sign"></i>
                        </div>
                        <div class="stat-info">
                            <h3>$2,450</h3>
                            <p>Total Revenue</p>
                        </div>
                        <div class="stat-trend up">
                            <i class="fas fa-arrow-up"></i> 15%
                        </div>
                    </div>
                </div>

                <!-- Quick Actions -->
                <div class="quick-actions-section">
                    <h3>Quick Actions</h3>
                    <div class="quick-actions-grid">
                        <a href="admin-users.jsp" class="quick-action">
                            <i class="fas fa-user-plus"></i>
                            <span>Add New User</span>
                        </a>
                        <a href="admin-announcements.jsp" class="quick-action">
                            <i class="fas fa-bullhorn"></i>
                            <span>Post Announcement</span>
                        </a>
                        <a href="admin-reports.jsp" class="quick-action">
                            <i class="fas fa-chart-pie"></i>
                            <span>Generate Report</span>
                        </a>
                        <a href="admin-settings.jsp" class="quick-action">
                            <i class="fas fa-cog"></i>
                            <span>System Settings</span>
                        </a>
                    </div>
                </div>

                <!-- Recent Activity Table -->
                <div class="recent-activity">
                    <div class="section-header">
                        <h3>Recent User Activity</h3>
                        <a href="admin-users.jsp" class="view-all">View All <i class="fas fa-arrow-right"></i></a>
                    </div>
                    <div class="activity-table">
                        <table>
                            <thead>
                                <tr>
                                    <th>User</th>
                                    <th>Activity</th>
                                    <th>Time</th>
                                    <th>Status</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>
                                        <div class="user-cell">
                                            <img src="https://via.placeholder.com/35" alt="User">
                                            <div>
                                                <strong>john_doe</strong>
                                                <p>Student</p>
                                            </div>
                                        </div>
                                    </td>
                                    <td>Listed new item: "Calculus Textbook"</td>
                                    <td>10:30 AM</td>
                                    <td><span class="status approved">Approved</span></td>
                                </tr>
                                <tr>
                                    <td>
                                        <div class="user-cell">
                                            <img src="https://via.placeholder.com/35" alt="User">
                                            <div>
                                                <strong>tech_guy</strong>
                                                <p>Student</p>
                                            </div>
                                        </div>
                                    </td>
                                    <td>Completed purchase: "MacBook Air"</td>
                                    <td>9:15 AM</td>
                                    <td><span class="status pending">Pending</span></td>
                                </tr>
                                <tr>
                                    <td>
                                        <div class="user-cell">
                                            <img src="https://via.placeholder.com/35" alt="User">
                                            <div>
                                                <strong>new_user123</strong>
                                                <p>New User</p>
                                            </div>
                                        </div>
                                    </td>
                                    <td>Registered new account</td>
                                    <td>8:45 AM</td>
                                    <td><span class="status approved">Approved</span></td>
                                </tr>
                                <tr>
                                    <td>
                                        <div class="user-cell">
                                            <img src="https://via.placeholder.com/35" alt="User">
                                            <div>
                                                <strong>admin_sarah</strong>
                                                <p>Admin</p>
                                            </div>
                                        </div>
                                    </td>
                                    <td>Updated system settings</td>
                                    <td>Yesterday</td>
                                    <td><span class="status approved">Completed</span></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>

                <!-- Recent Reports -->
                <div class="recent-reports">
                    <div class="section-header">
                        <h3>Recent Reports</h3>
                        <a href="admin-reports.jsp" class="view-all">View All <i class="fas fa-arrow-right"></i></a>
                    </div>
                    <div class="reports-list">
                        <div class="report-item">
                            <div class="report-header">
                                <h4><i class="fas fa-exclamation-triangle"></i> Reported Item</h4>
                                <span class="report-date">Today, 11:30 AM</span>
                            </div>
                            <p>Item "Gaming Console" reported for prohibited content</p>
                            <div class="report-actions">
                                <button class="btn-small btn-review">Review</button>
                                <button class="btn-small btn-dismiss">Dismiss</button>
                            </div>
                        </div>
                        
                        <div class="report-item">
                            <div class="report-header">
                                <h4><i class="fas fa-flag"></i> User Complaint</h4>
                                <span class="report-date">Yesterday, 3:45 PM</span>
                            </div>
                            <p>User "seller123" reported for inappropriate behavior</p>
                            <div class="report-actions">
                                <button class="btn-small btn-review">Review</button>
                                <button class="btn-small btn-dismiss">Dismiss</button>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- System Status -->
                <div class="system-status">
                    <h3>System Status</h3>
                    <div class="status-grid">
                        <div class="status-item">
                            <div class="status-indicator good"></div>
                            <div class="status-info">
                                <h4>Database</h4>
                                <p>Operating normally</p>
                            </div>
                        </div>
                        <div class="status-item">
                            <div class="status-indicator good"></div>
                            <div class="status-info">
                                <h4>Web Server</h4>
                                <p>99.9% uptime</p>
                            </div>
                        </div>
                        <div class="status-item">
                            <div class="status-indicator warning"></div>
                            <div class="status-info">
                                <h4>Storage</h4>
                                <p>75% used</p>
                            </div>
                        </div>
                        <div class="status-item">
                            <div class="status-indicator good"></div>
                            <div class="status-info">
                                <h4>Security</h4>
                                <p>All systems secure</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Notification Modal -->
    <div class="modal" id="notificationModal">
        <div class="modal-content">
            <div class="modal-header">
                <h3>Notifications</h3>
                <button class="close-modal">&times;</button>
            </div>
            <div class="modal-body">
                <div class="notification-item">
                    <div class="notification-icon">
                        <i class="fas fa-user-plus"></i>
                    </div>
                    <div class="notification-info">
                        <p><strong>5 new users</strong> registered today</p>
                        <span>2 hours ago</span>
                    </div>
                </div>
                <div class="notification-item">
                    <div class="notification-icon">
                        <i class="fas fa-exclamation-triangle"></i>
                    </div>
                    <div class="notification-info">
                        <p><strong>2 items reported</strong> for review</p>
                        <span>4 hours ago</span>
                    </div>
                </div>
                <div class="notification-item">
                    <div class="notification-icon">
                        <i class="fas fa-chart-line"></i>
                    </div>
                    <div class="notification-info">
                        <p><strong>Monthly report</strong> is ready</p>
                        <span>1 day ago</span>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        // Sidebar toggle
        document.querySelector('.sidebar-toggle').addEventListener('click', function() {
            document.querySelector('.admin-wrapper').classList.toggle('sidebar-collapsed');
        });
        
        // Notification modal
        const notificationBtn = document.querySelector('.notification-btn');
        const notificationModal = document.getElementById('notificationModal');
        const closeModal = document.querySelector('.close-modal');
        
        notificationBtn.addEventListener('click', function() {
            notificationModal.style.display = 'block';
        });
        
        closeModal.addEventListener('click', function() {
            notificationModal.style.display = 'none';
        });
        
        // Close modal when clicking outside
        window.addEventListener('click', function(event) {
            if (event.target === notificationModal) {
                notificationModal.style.display = 'none';
            }
        });
        
        // Mark notifications as read
        document.querySelectorAll('.notification-item').forEach(item => {
            item.addEventListener('click', function() {
                this.classList.add('read');
                // Update notification count
                const countElement = document.querySelector('.notification-count');
                let count = parseInt(countElement.textContent);
                if (count > 0) {
                    countElement.textContent = count - 1;
                    if (count - 1 === 0) {
                        countElement.style.display = 'none';
                    }
                }
            });
        });
    </script>
</body>
</html>