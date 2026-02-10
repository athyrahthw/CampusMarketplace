package com.campusmarketplace.controller;

import com.campusmarketplace.dao.DatabaseConnection;
import java.io.*;
import java.sql.*;
import java.util.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;

public class AdminServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        String action = request.getParameter("action");
        if (action == null) {
            action = "dashboard";
        }
        
        try {
            switch (action) {
                case "dashboard":
                    showDashboard(request, response);
                    break;
                case "students":
                    showStudents(request, response);
                    break;
                case "products":
                    showProducts(request, response);
                    break;
                case "reports":
                    showReports(request, response);
                    break;
                default:
                    response.sendRedirect("adminDashboard.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
    
    private void showDashboard(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            // Get student count
            int studentCount = getStudentCount();
            request.setAttribute("studentCount", studentCount);
            
            // Get product count
            int productCount = getProductCount();
            request.setAttribute("productCount", productCount);
            
            RequestDispatcher dispatcher = request.getRequestDispatcher("/adminDashboard.jsp");
            dispatcher.forward(request, response);
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
    
    private void showStudents(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            List<Map<String, Object>> students = getStudents();
            request.setAttribute("students", students);
            
            RequestDispatcher dispatcher = request.getRequestDispatcher("/manage-students.jsp");
            dispatcher.forward(request, response);
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
    
    private void showProducts(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            List<Map<String, Object>> products = getProducts();
            request.setAttribute("products", products);
            
            RequestDispatcher dispatcher = request.getRequestDispatcher("/manage-products.jsp");
            dispatcher.forward(request, response);
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
    
    private void showReports(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        RequestDispatcher dispatcher = request.getRequestDispatcher("/reports.jsp");
        dispatcher.forward(request, response);
    }
    
    // Database methods for Derby
    private int getStudentCount() throws SQLException {
        String sql = "SELECT COUNT(*) as count FROM users WHERE role = 'STUDENT'";
        try (Connection conn = DatabaseConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            if (rs.next()) {
                return rs.getInt("count");
            }
        }
        return 0;
    }
    
    private int getProductCount() throws SQLException {
        String sql = "SELECT COUNT(*) as count FROM products";
        try (Connection conn = DatabaseConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            if (rs.next()) {
                return rs.getInt("count");
            }
        }
        return 0;
    }
    
    private List<Map<String, Object>> getStudents() throws SQLException {
        List<Map<String, Object>> students = new ArrayList<>();
        String sql = "SELECT id, first_name, last_name, email, username, status FROM users WHERE role = 'STUDENT'";
        
        try (Connection conn = DatabaseConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                Map<String, Object> student = new HashMap<>();
                student.put("id", rs.getInt("id"));
                student.put("firstName", rs.getString("first_name"));
                student.put("lastName", rs.getString("last_name"));
                student.put("email", rs.getString("email"));
                student.put("username", rs.getString("username"));
                student.put("status", rs.getString("status"));
                students.add(student);
            }
        }
        return students;
    }
    
    private List<Map<String, Object>> getProducts() throws SQLException {
        List<Map<String, Object>> products = new ArrayList<>();
        String sql = "SELECT p.id, p.title, p.price, p.status, u.first_name, u.last_name " +
                     "FROM products p JOIN users u ON p.seller_id = u.id";
        
        try (Connection conn = DatabaseConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                Map<String, Object> product = new HashMap<>();
                product.put("id", rs.getInt("id"));
                product.put("title", rs.getString("title"));
                product.put("price", rs.getDouble("price"));
                product.put("status", rs.getString("status"));
                product.put("sellerName", rs.getString("first_name") + " " + rs.getString("last_name"));
                products.add(product);
            }
        }
        return products;
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}