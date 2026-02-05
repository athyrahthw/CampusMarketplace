<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign Up - Campus Marketplace</title>
    <link rel="stylesheet" href="css/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #6a11cb 0%, #2575fc 100%);
            font-family: 'Poppins', sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .auth-container {
            background-color: white;
            border-radius: 15px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 500px;
            padding: 40px;
            text-align: center;
        }

        h1 {
            font-size: 2rem;
            font-weight: 600;
            color: #2c3e50;
            margin-bottom: 20px;
        }

        .alert {
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 20px;
            font-size: 1rem;
            color: #fff;
        }

        .alert-error {
            background-color: #e74c3c;
        }

        .alert-success {
            background-color: #2ecc71;
        }

        .form-group {
            margin-bottom: 15px;
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

        /* Password Strength Indicator */
        #passwordStrength {
            margin-top: 5px;
            font-size: 0.9rem;
            color: #e74c3c;
            text-align: left;
        }

        #passwordStrength.weak {
            color: #e74c3c;
        }

        #passwordStrength.medium {
            color: #f39c12;
        }

        #passwordStrength.strong {
            color: #2ecc71;
        }

        /* Password Mismatch */
        #passwordMismatch {
            font-size: 0.9rem;
            color: #e74c3c;
            margin-top: 5px;
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

        .auth-footer {
            margin-top: 20px;
        }

        .auth-footer a {
            color: #6a11cb;
            font-size: 1rem;
            text-decoration: none;
        }

        .auth-footer a:hover {
            text-decoration: underline;
        }

        @media (max-width: 768px) {
            .auth-container {
                width: 90%;
                padding: 20px;
            }

            h1 {
                font-size: 1.6rem;
            }
        }
    </style>
</head>
<body>
    <div class="auth-container">
        <div class="auth-header">
            <h1>Campus Marketplace</h1>
            <h2>Sign Up</h2>
        </div>

        <% if (request.getAttribute("error") != null) { %>
            <div class="alert alert-error">
                <%= request.getAttribute("error") %>
            </div>
        <% } %>

        <% if (request.getAttribute("success") != null) { %>
            <div class="alert alert-success">
                <%= request.getAttribute("success") %>
            </div>
        <% } %>

        <form action="register" method="POST" class="auth-form">
            <div class="form-group">
                <label for="username">Username</label>
                <input type="text" id="username" name="username" class="input-field" required placeholder="Enter your username">
            </div>

            <div class="form-group">
                <label for="phoneNumber">Phone Number</label>
                <input type="tel" id="phoneNumber" name="phoneNumber" class="input-field" required placeholder="Enter your phone number">
            </div>

            <div class="form-group">
                <label for="email">Email (Optional)</label>
                <input type="email" id="email" name="email" class="input-field" placeholder="Enter your email">
            </div>

            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" class="input-field" required placeholder="Enter your password">
                <div id="passwordStrength"></div>
            </div>

            <div class="form-group">
                <label for="confirmPassword">Confirm Password</label>
                <input type="password" id="confirmPassword" name="confirmPassword" class="input-field" required placeholder="Confirm your password">
                <div id="passwordMismatch"></div>
            </div>

            <button type="submit" class="btn-primary">Sign Up</button>
        </form>

        <div class="auth-footer">
            <p>Already have an account? <a href="login.jsp">Login here</a></p>
            <p><a href="index.jsp">Back to Home</a></p>
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const password = document.getElementById('password');
            const confirmPassword = document.getElementById('confirmPassword');
            const passwordStrength = document.getElementById('passwordStrength');
            const passwordMismatch = document.getElementById('passwordMismatch');

            // Password strength checker
            function checkPasswordStrength() {
                const passwordValue = password.value;
                let strength = '';
                let color = '';

                if (passwordValue.length < 6) {
                    strength = 'Weak';
                    color = '#e74c3c';
                } else if (passwordValue.length < 10) {
                    strength = 'Medium';
                    color = '#f39c12';
                } else {
                    strength = 'Strong';
                    color = '#2ecc71';
                }

                passwordStrength.textContent = `Strength: ${strength}`;
                passwordStrength.className = strength.toLowerCase();
                passwordStrength.style.color = color;
            }

            // Password match checker
            function checkPasswordMatch() {
                if (password.value !== confirmPassword.value) {
                    passwordMismatch.textContent = "Passwords don't match!";
                } else {
                    passwordMismatch.textContent = '';
                }
            }

            password.addEventListener('input', checkPasswordStrength);
            password.addEventListener('input', checkPasswordMatch);
            confirmPassword.addEventListener('input', checkPasswordMatch);
        });
    </script>
</body>
</html>