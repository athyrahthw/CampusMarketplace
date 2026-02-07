<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Handle redirect parameter
    String redirectParam = (String) request.getAttribute("redirect");
    if (redirectParam == null) {
        redirectParam = request.getParameter("redirect");
    }
    if (redirectParam == null || redirectParam.trim().isEmpty()) {
        redirectParam = "dashboard";
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Campus Marketplace</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/auth.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <div class="auth-container">
        <!-- Left side - Branding and Illustration -->
        <div class="auth-branding">
            <div class="brand-logo">
                <i class="fas fa-store"></i>
                <h1>Campus<span>Marketplace</span></h1>
            </div>
            <div class="brand-slogan">
                <h2>Connect, Trade, Thrive</h2>
                <p>Your campus trading hub for textbooks, gadgets, and more</p>
            </div>
            <div class="brand-illustration">
                <div class="illustration-item">
                    <i class="fas fa-book"></i>
                    <span>Textbooks</span>
                </div>
                <div class="illustration-item">
                    <i class="fas fa-laptop"></i>
                    <span>Electronics</span>
                </div>
                <div class="illustration-item">
                    <i class="fas fa-tshirt"></i>
                    <span>Clothing</span>
                </div>
                <div class="illustration-item">
                    <i class="fas fa-bicycle"></i>
                    <span>Bikes</span>
                </div>
            </div>
        </div>

        <!-- Right side - Login Form -->
        <div class="auth-form-container">
            <div class="auth-card">
                <div class="auth-header">
                    <h2>Welcome Back!</h2>
                    <p>Sign in to your account to continue</p>
                </div>

                <!-- Status Messages -->
                <% if (request.getAttribute("errorMessage") != null) { %>
                    <div class="alert alert-error">
                        <i class="fas fa-exclamation-circle"></i>
                        <div class="alert-content">
                            <strong>Login Failed</strong>
                            <p><%= request.getAttribute("errorMessage") %></p>
                        </div>
                    </div>
                <% } %>
                
                <% if (request.getAttribute("success") != null) { %>
                    <div class="alert alert-success">
                        <i class="fas fa-check-circle"></i>
                        <div class="alert-content">
                            <strong>Success!</strong>
                            <p><%= request.getAttribute("success") %></p>
                        </div>
                    </div>
                <% } %>

                <!-- Login Form -->
                <form action="login" method="POST" class="auth-form" id="loginForm">
                    <input type="hidden" name="redirect" value="<%= redirectParam %>">
                    
                    <div class="form-group floating-label">
                        <input type="text" id="username" name="username" required autocomplete="username">
                        <label for="username">
                            <i class="fas fa-user"></i>
                            Username
                        </label>
                        <div class="form-underline"></div>
                    </div>
                    
                    <div class="form-group floating-label">
                        <input type="password" id="password" name="password" required autocomplete="current-password">
                        <label for="password">
                            <i class="fas fa-lock"></i>
                            Password
                        </label>
                        <div class="form-underline"></div>
                        <button type="button" class="password-toggle" id="togglePassword">
                            <i class="fas fa-eye"></i>
                        </button>
                    </div>

                    <!-- Remember Me & Forgot Password -->
                    <div class="form-options">
                        <label class="checkbox-container">
                            <input type="checkbox" name="remember" id="remember">
                            <span class="checkmark"></span>
                            Remember me
                        </label>
                        <a href="forgot-password" class="forgot-password">
                            Forgot Password?
                        </a>
                    </div>
                    
                    <button type="submit" class="btn btn-primary btn-block btn-login">
                        <span class="btn-text">LOG IN</span>
                        <i class="fas fa-arrow-right btn-icon"></i>
                    </button>
                </form>
                
                <!-- Registration Link -->
                <div class="auth-footer">
                    <p>New to Campus Marketplace? 
                        <a href="register" class="signup-link">Create an account</a>
                    </p>
                    <a href="index.jsp" class="back-home">
                        <i class="fas fa-arrow-left"></i>
                        Back to Homepage
                    </a>
                </div>

                <!-- Security Notice -->
                <div class="security-notice">
                    <i class="fas fa-shield-alt"></i>
                    <span>Your data is securely protected with 256-bit SSL encryption</span>
                </div>
            </div>
        </div>
    </div>

    <script>
    document.addEventListener('DOMContentLoaded', function() {
        const togglePassword = document.getElementById('togglePassword');
        const passwordInput = document.getElementById('password');
        const loginForm = document.getElementById('loginForm');
        
        // Get input elements
        const usernameInput = document.getElementById('username');
        const passwordField = document.getElementById('password');

        // Password visibility toggle
        if (togglePassword && passwordInput) {
            togglePassword.addEventListener('click', function() {
                const type = passwordInput.getAttribute('type') === 'password' ? 'text' : 'password';
                passwordInput.setAttribute('type', type);
                this.innerHTML = type === 'password' ? '<i class="fas fa-eye"></i>' : '<i class="fas fa-eye-slash"></i>';
            });
        }

        // Floating label animation
        function updateLabelState(input) {
            const parent = input.parentElement;
            if (input.value || document.activeElement === input) {
                parent.classList.add('focused');
            } else {
                parent.classList.remove('focused');
            }
        }
        
        // Initialize all floating labels
        document.querySelectorAll('.floating-label input').forEach(input => {
            // Set initial state
            updateLabelState(input);
            
            input.addEventListener('focus', function() {
                this.parentElement.classList.add('focused');
            });
            
            input.addEventListener('blur', function() {
                updateLabelState(this);
            });
            
            input.addEventListener('input', function() {
                updateLabelState(this);
            });
        });

        // Form submission animation
        if (loginForm) {
            loginForm.addEventListener('submit', function(e) {
                const submitBtn = this.querySelector('.btn-login');
                if (submitBtn) {
                    submitBtn.classList.add('loading');
                    submitBtn.disabled = true;
                    const btnText = submitBtn.querySelector('.btn-text');
                    if (btnText) {
                        btnText.textContent = 'Signing in...';
                    }
                }
            });
        }
        
        // Clear any pre-filled values and reset labels
        function clearForm() {
            // Clear values
            usernameInput.value = '';
            passwordField.value = '';
            
            // Reset label states
            updateLabelState(usernameInput);
            updateLabelState(passwordField);
        }
        
        // Clear immediately
        clearForm();
        
        // Clear again after a short delay to handle browser auto-fill
        setTimeout(clearForm, 100);
    });
</script>
</body>
</html>