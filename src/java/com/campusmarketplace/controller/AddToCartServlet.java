package com.campusmarketplace.controller;

import com.campusmarketplace.dao.CartDAO;
import com.campusmarketplace.model.CartItem;
import com.campusmarketplace.model.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/AddToCartServlet")
public class AddToCartServlet extends HttpServlet {
    
    private CartDAO cartDAO;
    
    @Override
    public void init() {
        cartDAO = new CartDAO();
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        String productIdParam = request.getParameter("productId");
        String quantityParam = request.getParameter("quantity");
        
        if (productIdParam == null || productIdParam.isEmpty()) {
            response.sendRedirect("dashboard.jsp");
            return;
        }
        
        int productId = Integer.parseInt(productIdParam);
        int quantity = 1; // Default quantity
        
        if (quantityParam != null && !quantityParam.isEmpty()) {
            quantity = Integer.parseInt(quantityParam);
        }
        
        CartItem cartItem = new CartItem();
        cartItem.setUserId(user.getId());
        cartItem.setProductId(productId);
        cartItem.setQuantity(quantity);
        
        cartDAO.addToCart(cartItem);
        
        // Redirect back to product page or cart
        response.sendRedirect("cart.jsp");
    }
}