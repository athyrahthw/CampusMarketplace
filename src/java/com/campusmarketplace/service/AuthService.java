package com.campusmarketplace.service;

import com.campusmarketplace.dao.UserDAO;
import com.campusmarketplace.model.User;
import com.campusmarketplace.util.PasswordUtil;

public class AuthService {
    
    private UserDAO userDAO;
    
    public AuthService() {
        this.userDAO = new UserDAO();
    }
    
    // ... existing authenticate method ...
    
    public boolean verifyPassword(String inputPassword, String storedHash) {
        return PasswordUtil.verifyPassword(inputPassword, storedHash);
    }
    
    public String hashPassword(String password) {
        return PasswordUtil.hashPassword(password);
    }
}