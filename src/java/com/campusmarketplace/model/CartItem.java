package com.campusmarketplace.model;

public class CartItem {
    private int id;  // Changed from String to int
    private int userId;
    private int productId;
    private int quantity;
    private Product product;
    
    // Constructors
    public CartItem() {}
    
    public CartItem(int userId, int productId, int quantity) {
        this.userId = userId;
        this.productId = productId;
        this.quantity = quantity;
    }
    
    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }  // Changed to int
    
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
    
    public int getProductId() { return productId; }
    public void setProductId(int productId) { this.productId = productId; }
    
    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }
    
    public Product getProduct() { return product; }
    public void setProduct(Product product) { this.product = product; }
    
    // Helper method to calculate item total
    public double getItemTotal() {
        if (product != null) {
            return product.getPrice() * quantity;
        }
        return 0.0;
    }
}