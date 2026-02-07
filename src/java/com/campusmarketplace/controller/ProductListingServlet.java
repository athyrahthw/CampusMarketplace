
package com.campusmarketplace.controller;

import com.campusmarketplace.dao.ProductDAO;
import com.campusmarketplace.model.Product;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/ProductListingServlet")
public class ProductListingServlet extends HttpServlet {
    private ProductDAO productDAO;
    
    @Override
    public void init() {
        productDAO = new ProductDAO();
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String category = request.getParameter("category");
        List<Product> products;
        
        if (category != null && !category.isEmpty() && !category.equals("all")) {
            products = productDAO.getProductsByCategory(category);
        } else {
            products = productDAO.getAllProducts();
        }
        
        request.setAttribute("products", products);
        RequestDispatcher dispatcher = request.getRequestDispatcher("productListing.jsp");
        dispatcher.forward(request, response);
    }
}