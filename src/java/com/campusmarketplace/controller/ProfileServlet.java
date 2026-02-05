package com.campusmarketplace.controller;

import com.campusmarketplace.dao.UserDAO;
import com.campusmarketplace.model.User;
import com.campusmarketplace.service.AuthService;
import com.campusmarketplace.util.ValidationUtil;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "ProfileServlet", urlPatterns = {"/ProfileServlet"})
public class ProfileServlet extends HttpServlet {
    
    private UserDAO userDAO;
    private AuthService authService;
    
    @Override
    public void init() throws ServletException {
        try {
            userDAO = new UserDAO();
            authService = new AuthService();
        } catch (Exception e) {
            throw new ServletException("Failed to initialize servlet", e);
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        try {
            HttpSession session = request.getSession(false);
            User user = (session != null) ? (User) session.getAttribute("user") : null;
            
            if (user == null) {
                response.sendRedirect("login.jsp");
                return;
            }
            
            // Get fresh user data from database
            User freshUser = userDAO.getUserByUsername(user.getUsername());
            
            if (freshUser == null) {
                // User not found in database (should not happen)
                session.invalidate();
                response.sendRedirect("login.jsp");
                return;
            }
            
            // Update session with fresh data
            session.setAttribute("user", freshUser);
            session.setAttribute("username", freshUser.getUsername());
            session.setAttribute("userType", freshUser.getUserType());
            
            // Forward to profile page
            request.getRequestDispatcher("profile.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error loading profile: " + e.getMessage());
            request.getRequestDispatcher("login.jsp").forward(request, response);
        } finally {
            out.close();
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        try {
            HttpSession session = request.getSession(false);
            User user = (session != null) ? (User) session.getAttribute("user") : null;
            
            if (user == null) {
                response.sendRedirect("login.jsp");
                return;
            }
            
            String action = request.getParameter("action");
            
            if ("update".equalsIgnoreCase(action)) {
                // Get form parameters
                String email = request.getParameter("email");
                String phone = request.getParameter("phone");
                String currentPassword = request.getParameter("currentPassword");
                String newPassword = request.getParameter("newPassword");
                String confirmPassword = request.getParameter("confirmPassword");
                
                // Get fresh user data from database
                User currentUser = userDAO.getUserByUsername(user.getUsername());
                if (currentUser == null) {
                    session.invalidate();
                    response.sendRedirect("login.jsp");
                    return;
                }
                
                // Validate email if provided
                if (email != null && !email.trim().isEmpty()) {
                    if (!ValidationUtil.isValidEmail(email)) {
                        request.setAttribute("errorMessage", "Invalid email format");
                        request.getRequestDispatcher("profile.jsp").forward(request, response);
                        return;
                    }
                    
                    // Check if email already exists (if changed)
                    if (!email.equals(currentUser.getEmail())) {
                        User existingUser = userDAO.getUserByEmail(email);
                        if (existingUser != null && existingUser.getId() != currentUser.getId()) {
                            request.setAttribute("errorMessage", "Email already in use");
                            request.getRequestDispatcher("profile.jsp").forward(request, response);
                            return;
                        }
                    }
                    currentUser.setEmail(email.trim());
                }
                
                // Validate phone if provided
                if (phone != null && !phone.trim().isEmpty()) {
                    if (!ValidationUtil.isValidPhone(phone)) {
                        request.setAttribute("errorMessage", "Invalid phone number format");
                        request.getRequestDispatcher("profile.jsp").forward(request, response);
                        return;
                    }
                    currentUser.setPhoneNumber(phone.trim());
                }
                
                // Handle password change if requested
                boolean passwordChanged = false;
                if (newPassword != null && !newPassword.trim().isEmpty()) {
                    // Check if current password is provided
                    if (currentPassword == null || currentPassword.trim().isEmpty()) {
                        request.setAttribute("errorMessage", "Current password is required to change password");
                        request.getRequestDispatcher("profile.jsp").forward(request, response);
                        return;
                    }
                    
                    // Verify current password
                    if (!authService.verifyPassword(currentPassword.trim(), currentUser.getPassword())) {
                        request.setAttribute("errorMessage", "Current password is incorrect");
                        request.getRequestDispatcher("profile.jsp").forward(request, response);
                        return;
                    }
                    
                    // Validate new password
                    if (!ValidationUtil.isValidPassword(newPassword)) {
                        request.setAttribute("errorMessage", "New password must be at least 6 characters");
                        request.getRequestDispatcher("profile.jsp").forward(request, response);
                        return;
                    }
                    
                    // Check if new password matches confirmation
                    if (confirmPassword == null || !newPassword.equals(confirmPassword)) {
                        request.setAttribute("errorMessage", "New password and confirmation do not match");
                        request.getRequestDispatcher("profile.jsp").forward(request, response);
                        return;
                    }
                    
                    // Hash and set new password
                    currentUser.setPassword(authService.hashPassword(newPassword.trim()));
                    passwordChanged = true;
                }
                
                // Update user in database
                boolean success = userDAO.updateUser(currentUser);
                
                if (success) {
                    // Update session with new user data
                    session.setAttribute("user", currentUser);
                    
                    String successMsg = "Profile updated successfully";
                    if (passwordChanged) {
                        successMsg += " (password changed)";
                    }
                    request.setAttribute("successMessage", successMsg);
                    
                    // Get fresh data again
                    User freshUser = userDAO.getUserByUsername(currentUser.getUsername());
                    if (freshUser != null) {
                        session.setAttribute("user", freshUser);
                    }
                    
                    request.getRequestDispatcher("profile.jsp").forward(request, response);
                } else {
                    request.setAttribute("errorMessage", "Failed to update profile. Please try again.");
                    request.getRequestDispatcher("profile.jsp").forward(request, response);
                }
                
            } else {
                // Invalid action
                response.sendRedirect("profile.jsp");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "System error: " + e.getMessage());
            request.getRequestDispatcher("profile.jsp").forward(request, response);
        } finally {
            out.close();
        }
    }
}