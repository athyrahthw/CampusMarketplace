package com.campusmarketplace.servlet;

import com.campusmarketplace.dao.ProductDAO;
import com.campusmarketplace.model.Product;
import com.campusmarketplace.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/ProductDetailServlet")
public class ProductDetailServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Check if user is logged in
        HttpSession session = request.getSession(false);
        if (session == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        try {
            // Get product ID from request parameter
            String productIdStr = request.getParameter("id");
            
            if (productIdStr == null || productIdStr.isEmpty()) {
                // No product ID provided, redirect to dashboard
                response.sendRedirect("dashboard.jsp");
                return;
            }
            
            int productId = Integer.parseInt(productIdStr);
            
            // Fetch product from database
            ProductDAO productDAO = new ProductDAO();
            Product product = productDAO.getProductById(productId);
            
            if (product == null) {
                // Product not found
                request.setAttribute("error", "Product not found or has been removed.");
                request.getRequestDispatcher("dashboard.jsp").forward(request, response);
                return;
            }
            
            // Set product as request attribute
            request.setAttribute("product", product);
            
            // Forward to product detail page
            request.getRequestDispatcher("product-detail.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            // Invalid product ID format
            request.setAttribute("error", "Invalid product ID.");
            request.getRequestDispatcher("dashboard.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error loading product details. Please try again.");
            request.getRequestDispatcher("dashboard.jsp").forward(request, response);
        }
    }
}