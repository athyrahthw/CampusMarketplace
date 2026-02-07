/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.campusmarketplace.dao;

import com.campusmarketplace.model.Product;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductDAO {
    
    public ProductDAO() {
        System.out.println("ProductDAO initialized");
    }
    
    public List<Product> getAllProducts() {
        List<Product> products = new ArrayList<>();
        // FIXED: Changed 'true' to '1' for Derby compatibility
        String sql = "SELECT * FROM products WHERE is_available = 1 ORDER BY created_at DESC";
        
        System.out.println("Executing SQL: " + sql);
        
        try (Connection conn = DatabaseConnection.getConnection()) {
            System.out.println("Database connection established");
            
            try (PreparedStatement stmt = conn.prepareStatement(sql);
                 ResultSet rs = stmt.executeQuery()) {
                
                System.out.println("Query executed");
                
                while (rs.next()) {
                    Product product = extractProduct(rs);
                    products.add(product);
                    System.out.println("Found product: " + product.getName());
                }
                
                System.out.println("Total products found: " + products.size());
            }
        } catch (SQLException e) {
            System.err.println("Error getting all products: " + e.getMessage());
            e.printStackTrace();
        }
        
        return products;
    }
    
    public Product getProductById(int id) {
        Product product = null;
        String sql = "SELECT * FROM products WHERE id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    product = extractProduct(rs);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error getting product by ID: " + e.getMessage());
            e.printStackTrace();
        }
        return product;
    }
    
    public List<Product> getProductsByCategory(String category) {
        List<Product> products = new ArrayList<>();
        // FIXED: Changed 'true' to '1' for Derby compatibility
        String sql = "SELECT * FROM products WHERE category = ? AND is_available = 1 ORDER BY created_at DESC";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, category);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    products.add(extractProduct(rs));
                }
            }
        } catch (SQLException e) {
            System.err.println("Error getting products by category: " + e.getMessage());
            e.printStackTrace();
        }
        return products;
    }
    
    public boolean addProduct(Product product) {
        String sql = "INSERT INTO products (name, price, description, category, seller_id, " +
                    "image_url, location, payment_option, product_condition, quantity, is_available) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        System.out.println("Adding product to database: " + product.getName());
        System.out.println("SQL: " + sql);
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            stmt.setString(1, product.getName());
            stmt.setDouble(2, product.getPrice());
            stmt.setString(3, product.getDescription());
            stmt.setString(4, product.getCategory());
            stmt.setInt(5, product.getSellerId());
            stmt.setString(6, product.getImageUrl());
            stmt.setString(7, product.getLocation());
            stmt.setString(8, product.getPaymentOption());
            stmt.setString(9, product.getProductCondition());
            stmt.setInt(10, product.getQuantity());
            
            // FIXED: Convert boolean to int for Derby
            stmt.setInt(11, product.isAvailable() ? 1 : 0);
            
            int rowsAffected = stmt.executeUpdate();
            System.out.println("Rows affected: " + rowsAffected);
            
            if (rowsAffected > 0) {
                // Get the generated ID
                try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        int id = generatedKeys.getInt(1);
                        product.setId(id);
                        System.out.println("Product added with ID: " + id);
                    }
                }
                return true;
            }
            
        } catch (SQLException e) {
            System.err.println("Error adding product: " + e.getMessage());
            e.printStackTrace();
        }
        
        return false;
    }
    
    private Product extractProduct(ResultSet rs) throws SQLException {
        Product product = new Product();
        
        product.setId(rs.getInt("id"));
        product.setName(rs.getString("name"));
        product.setPrice(rs.getDouble("price"));
        product.setDescription(rs.getString("description"));
        product.setCategory(rs.getString("category"));
        product.setSellerId(rs.getInt("seller_id"));
        product.setImageUrl(rs.getString("image_url"));
        product.setLocation(rs.getString("location"));
        product.setPaymentOption(rs.getString("payment_option"));
        product.setProductCondition(rs.getString("product_condition"));
        product.setQuantity(rs.getInt("quantity"));
        
        // FIXED: Handle Derby's SMALLINT boolean (1=true, 0=false)
        int availableInt = rs.getInt("is_available");
        product.setAvailable(availableInt == 1);
        
        // Handle timestamp (might be null)
        Timestamp createdAt = rs.getTimestamp("created_at");
        if (createdAt != null) {
            product.setCreatedAt(createdAt);
        }
        
        return product;
    }
}