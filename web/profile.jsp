<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.campusmarketplace.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    String successMessage = (String) request.getAttribute("successMessage");
    String errorMessage = (String) request.getAttribute("errorMessage");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Profile - Campus Marketplace</title>
    <link rel="stylesheet" href="css/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #6a11cb 0%, #2575fc 100%);
            font-family: 'Poppins', sans-serif;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .profile-container {
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 600px;
            padding: 30px;
            text-align: center;
        }

        h2 {
            font-size: 2rem;
            color: #2c3e50;
            margin-bottom: 20px;
        }

        .alert {
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 5px;
            font-size: 1rem;
        }

        .alert-error {
            background-color: #e74c3c;
            color: #fff;
        }

        .alert-success {
            background-color: #2ecc71;
            color: #fff;
        }

        .form-group {
            margin-bottom: 20px;
            text-align: left;
        }

        label {
            font-size: 1rem;
            font-weight: 600;
            color: #34495e;
            display: block;
            margin-bottom: 5px;
        }

        .input-field {
            width: 100%;
            padding: 12px;
            border: 2px solid #e0e0e0;
            border-radius: 25px;
            font-size: 1rem;
            outline: none;
            transition: border-color 0.3s ease;
        }

        .input-field:focus {
            border-color: #4CAF50;
        }

        .btn-primary {
            background: #4CAF50;
            color: white;
            padding: 12px;
            width: 100%;
            border: none;
            border-radius: 25px;
            font-size: 1.2rem;
            cursor: pointer;
            transition: background 0.3s;
        }

        .btn-primary:hover {
            background: #45a049;
        }

        .profile-footer {
            margin-top: 20px;
            font-size: 1rem;
            color: #6a11cb;
        }

        .profile-footer a {
            color: #6a11cb;
            text-decoration: none;
        }

        .profile-footer a:hover {
            text-decoration: underline;
        }

        .password-section {
            text-align: left;
            margin-top: 30px;
        }

        .password-section label {
            font-size: 1rem;
            font-weight: 600;
            color: #34495e;
            display: block;
            margin-bottom: 5px;
        }

        .password-section input {
            width: 100%;
            padding: 12px;
            border: 2px solid #e0e0e0;
            border-radius: 10px;
            font-size: 1rem;
            outline: none;
            transition: border-color 0.3s ease;
        }

        .password-section input:focus {
            border-color: #4CAF50;
        }

        .password-mismatch {
            color: #e74c3c;
            font-size: 0.9rem;
            margin-top: 10px;
        }

        .password-strength {
            color: #f39c12;
            font-size: 0.9rem;
            margin-top: 10px;
        }

    </style>
</head>
<body>
    <div class="profile-container">
        <h2>My Profile</h2>

        <% if (successMessage != null) { %>
            <div class="alert alert-success">
                <%= successMessage %>
            </div>
        <% } %>

        <% if (errorMessage != null) { %>
            <div class="alert alert-error">
                <%= errorMessage %>
            </div>
        <% } %>

        <!-- Profile Information -->
        <form action="updateProfile.jsp" method="POST">
            <div class="form-group">
                <label for="username">Username</label>
                <input type="text" id="username" name="username" value="<%= user.getUsername() %>" disabled class="input-field">
            </div>

            <div class="form-group">
                <label for="email">Email</label>
                <input type="email" id="email" name="email" value="<%= user.getEmail() != null ? user.getEmail() : "" %>" class="input-field">
            </div>

            <div class="form-group">
                <label for="phone">Phone</label>
                <input type="tel" id="phone" name="phone" value="<%= user.getPhoneNumber() != null ? user.getPhoneNumber() : "" %>" class="input-field">
            </div>

            <h3>Change Password (optional)</h3>
            <div class="password-section">
                <label for="currentPassword">Current Password</label>
                <input type="password" id="currentPassword" name="currentPassword" class="input-field">
            </div>

            <div class="password-section">
                <label for="newPassword">New Password</label>
                <input type="password" id="newPassword" name="newPassword" class="input-field">
                <div id="password-strength" class="password-strength"></div>
            </div>

            <div class="password-section">
                <label for="confirmPassword">Confirm New Password</label>
                <input type="password" id="confirmPassword" name="confirmPassword" class="input-field">
                <div id="password-mismatch" class="password-mismatch"></div>
            </div>

            <button type="submit" class="btn-primary">Update Profile</button>
        </form>

        <!-- Footer Link -->
        <div class="profile-footer">
            <p><a href="dashboard.jsp">Back to Dashboard</a></p>
        </div>
    </div>

    <script>
        // Password strength and mismatch checker
        document.addEventListener('DOMContentLoaded', function () {
            const newPassword = document.getElementById('newPassword');
            const confirmPassword = document.getElementById('confirmPassword');
            const passwordStrength = document.getElementById('password-strength');
            const passwordMismatch = document.getElementById('password-mismatch');

            // Password strength checker
            const checkPasswordStrength = () => {
                const value = newPassword.value;
                let strength = 'Weak';

                if (value.length > 8 && /[A-Z]/.test(value) && /[0-9]/.test(value)) {
                    strength = 'Strong';
                } else if (value.length > 6) {
                    strength = 'Medium';
                }

                passwordStrength.textContent = `Strength: ${strength}`;
            };

            newPassword.addEventListener('input', checkPasswordStrength);

            // Confirm password mismatch checker
            const checkPasswordMismatch = () => {
                if (newPassword.value !== confirmPassword.value) {
                    passwordMismatch.textContent = 'Passwords do not match!';
                } else {
                    passwordMismatch.textContent = '';
                }
            };

            confirmPassword.addEventListener('input', checkPasswordMismatch);
        });
    </script>
</body>
</html>