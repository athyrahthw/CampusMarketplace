package com.campusmarketplace.controller;

import com.campusmarketplace.dao.ProductDAO;
import com.campusmarketplace.model.Product;
import com.campusmarketplace.model.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.util.List;

@WebServlet("/ProductServlet")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 1, // 1 MB
    maxFileSize = 1024 * 1024 * 10,      // 10 MB
    maxRequestSize = 1024 * 1024 * 100   // 100 MB
)
public class ProductServlet extends HttpServlet {
    
    private ProductDAO productDAO;
    
    @Override
    public void init() {
        productDAO = new ProductDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if (action == null) {
            // Show all products
            List<Product> products = productDAO.getAllProducts();
            request.setAttribute("products", products);
            request.getRequestDispatcher("dashboard.jsp").forward(request, response);
            
        } else if ("view".equals(action)) {
            // View single product
            int productId = Integer.parseInt(request.getParameter("id"));
            Product product = productDAO.getProductById(productId);
            request.setAttribute("product", product);
            request.getRequestDispatcher("product.jsp").forward(request, response);
            
        } else if ("category".equals(action)) {
            // Show products by category
            String category = request.getParameter("category");
            List<Product> products = productDAO.getProductsByCategory(category);
            request.setAttribute("products", products);
            request.setAttribute("category", category);
            request.getRequestDispatcher("productListing.jsp").forward(request, response);
            
        } else if ("sell".equals(action)) {
            // Show sell product form
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("user");
            
            if (user == null) {
                response.sendRedirect("login.jsp");
                return;
            }
            request.getRequestDispatcher("sellProduct.jsp").forward(request, response);
        }
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
        
        // Handle product listing
        String productName = request.getParameter("productName");
        double price = Double.parseDouble(request.getParameter("price"));
        String description = request.getParameter("description");
        String category = request.getParameter("category");
        String location = request.getParameter("location");
        String paymentOption = request.getParameter("paymentOption");
        String condition = request.getParameter("condition");
        
        Product product = new Product();
        product.setName(productName);
        product.setPrice(price);
        product.setDescription(description);
        product.setCategory(category);
        product.setLocation(location);
        product.setPaymentOption(paymentOption);
        product.setProductCondition(condition);
        product.setSellerId(user.getId());
        
        // Handle file upload for product image
        Part filePart = request.getPart("productImage");
        if (filePart != null && filePart.getSize() > 0) {
            String fileName = getFileName(filePart);
            String uploadPath = getServletContext().getRealPath("") + "uploads";
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdir();
            
            String filePath = uploadPath + File.separator + fileName;
            filePart.write(filePath);
            product.setImageUrl("uploads/" + fileName);
        } else {
            product.setImageUrl("images/default-product.jpg");
        }
        
        productDAO.addProduct(product);
        response.sendRedirect("dashboard.jsp");
    }
    
    private String getFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] tokens = contentDisp.split(";");
        for (String token : tokens) {
            if (token.trim().startsWith("filename")) {
                return token.substring(token.indexOf("=") + 2, token.length() - 1);
            }
        }
        return "";
    }
}