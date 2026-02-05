package com.campusmarketplace.controller;

import com.campusmarketplace.dao.UserDAO;
import com.campusmarketplace.model.User;
import com.campusmarketplace.util.PasswordUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})  // Changed to lowercase /login
public class LoginServlet extends HttpServlet {
    
    private UserDAO userDAO;
    
    @Override
    public void init() throws ServletException {
        try {
            userDAO = new UserDAO();
        } catch (Exception e) {
            throw new ServletException("Failed to initialize UserDAO", e);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("text/html;charset=UTF-8");
        
        try {
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String userType = request.getParameter("userType"); // "admin" or "student"
            
            // Debug logging
            System.out.println("Login attempt - Username: " + username + ", UserType: " + userType);
            
            // FIXED: Correct validation syntax
            if (username == null || username.trim().isEmpty() || 
                password == null || password.trim().isEmpty()) {
                request.setAttribute("errorMessage", "Username and password are required");
                request.getRequestDispatcher("login.jsp").forward(request, response);
                return;
            }
            
            // Get user from database
            User user = userDAO.getUserByUsername(username.trim());
            
            if (user == null) {
                // User not found
                request.setAttribute("errorMessage", "Invalid username or password");
                request.getRequestDispatcher("login.jsp").forward(request, response);
                return;
            }
            
            // Check if user is active
            if (!user.isActive()) {
                request.setAttribute("errorMessage", "Account is deactivated");
                request.getRequestDispatcher("login.jsp").forward(request, response);
                return;
            }
            
            // Verify user type
            if (userType != null && !userType.trim().isEmpty() && 
                !userType.equalsIgnoreCase(user.getUserType())) {
                request.setAttribute("errorMessage", "Invalid user type selected");
                request.getRequestDispatcher("login.jsp").forward(request, response);
                return;
            }
            
            // Verify password
            boolean passwordValid = PasswordUtil.verifyPassword(password, user.getPassword());
            
            if (!passwordValid) {
                request.setAttribute("errorMessage", "Invalid username or password");
                request.getRequestDispatcher("login.jsp").forward(request, response);
                return;
            }
            
            // Authentication successful
            System.out.println("Login successful for user: " + username);
            
            // Create session
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            session.setAttribute("username", username);
            session.setAttribute("userType", user.getUserType());
            session.setAttribute("userId", user.getId());
            
            // Set session timeout (30 minutes)
            session.setMaxInactiveInterval(30 * 60);
            
            // Redirect based on user type
            if ("admin".equalsIgnoreCase(user.getUserType())) {
                response.sendRedirect("adminDashboard.jsp");
            } else {
                response.sendRedirect("dashboard.jsp");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "System error: " + e.getMessage());
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // If GET request, check if already logged in
        HttpSession session = request.getSession(false);
        
        if (session != null && session.getAttribute("user") != null) {
            // Already logged in, redirect to dashboard
            User user = (User) session.getAttribute("user");
            if ("admin".equalsIgnoreCase(user.getUserType())) {
                response.sendRedirect("adminDashboard.jsp");
            } else {
                response.sendRedirect("dashboard.jsp");
            }
        } else {
            // Not logged in, show login page
            response.sendRedirect("login.jsp");
        }
    }
}