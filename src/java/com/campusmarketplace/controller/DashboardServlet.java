package com.campusmarketplace.controller;

import com.campusmarketplace.dao.ProductDAO;
import com.campusmarketplace.model.Product;
import com.campusmarketplace.model.User;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/DashboardServlet")
public class DashboardServlet extends HttpServlet {
    private ProductDAO productDAO;
    
    @Override
    public void init() {
        productDAO = new ProductDAO();
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        // Check if user is logged in
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        try {
            // Get all available products from database
            List<Product> products = productDAO.getAllProducts();
            
            // Limit to 8 products for dashboard display
            int limit = Math.min(products.size(), 8);
            if (!products.isEmpty()) {
                List<Product> featuredProducts = products.subList(0, limit);
                request.setAttribute("products", featuredProducts);
            } else {
                request.setAttribute("products", products);
            }
            
        } catch (Exception e) {
            // Log error but continue - show empty state
            System.err.println("Error loading products: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "Unable to load products from database. Please try again later.");
        }
        
        RequestDispatcher dispatcher = request.getRequestDispatcher("dashboard.jsp");
        dispatcher.forward(request, response);
    }
}