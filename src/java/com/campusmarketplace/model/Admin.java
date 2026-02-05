/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.campusmarketplace.model;

public class Admin extends User {
    private String adminRole;
    private String department;
    
    public Admin() {
        this.setUserType("admin");
    }
    
    // Getters and Setters
    public String getAdminRole() { return adminRole; }
    public void setAdminRole(String adminRole) { this.adminRole = adminRole; }
    
    public String getDepartment() { return department; }
    public void setDepartment(String department) { this.department = department; }
}