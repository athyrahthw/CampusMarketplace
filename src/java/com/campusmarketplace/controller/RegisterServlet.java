package com.campusmarketplace.controller;

import com.campusmarketplace.dao.UserDAO;
import com.campusmarketplace.model.User;
import com.campusmarketplace.util.PasswordUtil;  // Changed from AuthService
import com.campusmarketplace.util.ValidationUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/register")  // Changed to lowercase URL
public class RegisterServlet extends HttpServlet {
    
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
        
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        String phoneNumber = request.getParameter("phoneNumber");
        String userType = "student"; // Default for registration
        
        // Validate input
        String error = ValidationUtil.validateRegistration(username, password, email, phoneNumber);
        
        if (error != null) {
            request.setAttribute("errorMessage", error);
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }
        
        // Check if username exists
        if (userDAO.getUserByUsername(username) != null) {
            request.setAttribute("errorMessage", "Username already exists");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }
        
        // Create new user
        User user = new User();
        user.setUsername(username);
        user.setPassword(PasswordUtil.hashPassword(password));  // Use PasswordUtil directly
        user.setEmail(email);
        user.setPhoneNumber(phoneNumber);
        user.setUserType(userType);
        user.setActive(true);  // IMPORTANT: Set user as active by default
        
        // Save to database - FIX: Changed from addUser() to createUser()
        boolean success = userDAO.createUser(user);
        
        if (success) {
            // Registration successful
            request.setAttribute("successMessage", "Registration successful! Please login.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        } else {
            request.setAttribute("errorMessage", "Registration failed. Please try again.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.sendRedirect("register.jsp");
    }
}