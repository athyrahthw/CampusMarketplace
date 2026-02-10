// StudentDAO.java
package com.campusmarketplace.dao;

import com.campusmarketplace.model.Student;
import com.campusmarketplace.dao.DatabaseConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class StudentDAO {
    
    // Get all students
    public List<Student> getAllStudents() {
        List<Student> students = new ArrayList<>();
        String sql = "SELECT * FROM users WHERE role = 'STUDENT' ORDER BY id DESC";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                Student student = new Student();
                student.setId(rs.getInt("user_id"));
                student.setFirstName(rs.getString("first_name"));
                student.setLastName(rs.getString("last_name"));
                student.setUsername(rs.getString("username"));
                student.setEmail(rs.getString("email"));
                student.setMajor(rs.getString("major"));
                student.setCreatedAt(rs.getTimestamp("created_at"));
                student.setStatus(rs.getBoolean("is_active") ? "ACTIVE" : "INACTIVE");
                
                students.add(student);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return students;
    }
    
    // Get student by ID
    public Student getStudentById(int id) {
        Student student = null;
        String sql = "SELECT * FROM users WHERE user_id = ? AND role = 'STUDENT'";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    student = new Student();
                    student.setId(rs.getInt("user_id"));
                    student.setFirstName(rs.getString("first_name"));
                    student.setLastName(rs.getString("last_name"));
                    student.setUsername(rs.getString("username"));
                    student.setEmail(rs.getString("email"));
                    student.setMajor(rs.getString("major"));
                    student.setCreatedAt(rs.getTimestamp("created_at"));
                    student.setStatus(rs.getBoolean("is_active") ? "ACTIVE" : "INACTIVE");
                }
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return student;
    }
    
    // Get total students count
    public int getTotalStudents() {
        String sql = "SELECT COUNT(*) as total FROM users WHERE role = 'STUDENT'";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            if (rs.next()) {
                return rs.getInt("total");
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return 0;
    }
    
    // Get active students count
    public int getActiveStudents() {
        String sql = "SELECT COUNT(*) as total FROM users WHERE role = 'STUDENT' AND is_active = true";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            if (rs.next()) {
                return rs.getInt("total");
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return 0;
    }
    
    // Get inactive students count
    public int getInactiveStudents() {
        String sql = "SELECT COUNT(*) as total FROM users WHERE role = 'STUDENT' AND is_active = false";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            if (rs.next()) {
                return rs.getInt("total");
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return 0;
    }
    
    // Add a new student
    public boolean addStudent(Student student) {
        String sql = "INSERT INTO users (first_name, last_name, username, email, password, major, role, is_active, created_at) " +
                     "VALUES (?, ?, ?, ?, ?, ?, 'STUDENT', ?, NOW())";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, student.getFirstName());
            stmt.setString(2, student.getLastName());
            stmt.setString(3, student.getUsername());
            stmt.setString(4, student.getEmail());
            stmt.setString(5, "student123"); // Default password
            stmt.setString(6, student.getMajor());
            stmt.setBoolean(7, "ACTIVE".equals(student.getStatus()));
            
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // Update student
    public boolean updateStudent(Student student) {
        String sql = "UPDATE users SET first_name = ?, last_name = ?, username = ?, email = ?, " +
                     "major = ?, is_active = ? WHERE user_id = ? AND role = 'STUDENT'";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, student.getFirstName());
            stmt.setString(2, student.getLastName());
            stmt.setString(3, student.getUsername());
            stmt.setString(4, student.getEmail());
            stmt.setString(5, student.getMajor());
            stmt.setBoolean(6, "ACTIVE".equals(student.getStatus()));
            stmt.setInt(7, student.getId());
            
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // Delete student
    public boolean deleteStudent(int id) {
        String sql = "DELETE FROM users WHERE user_id = ? AND role = 'STUDENT'";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}