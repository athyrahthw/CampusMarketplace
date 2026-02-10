// ManageStudentsServlet.java
package com.campusmarketplace.controller;

import com.campusmarketplace.dao.StudentDAO;
import com.campusmarketplace.model.Student;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/students")
public class ManageStudentServlet extends HttpServlet {
    private StudentDAO studentDAO;
    
    @Override
    public void init() throws ServletException {
        studentDAO = new StudentDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            // Get all students
            List<Student> students = studentDAO.getAllStudents();
            
            // Get statistics
            int totalStudents = studentDAO.getTotalStudents();
            int activeStudents = studentDAO.getActiveStudents();
            int inactiveStudents = studentDAO.getInactiveStudents();
            int pendingStudents = 0; // Adjust based on your database structure
            
            // Set attributes for JSP
            request.setAttribute("students", students);
            request.setAttribute("totalStudents", totalStudents);
            request.setAttribute("activeStudents", activeStudents);
            request.setAttribute("inactiveStudents", inactiveStudents);
            request.setAttribute("pendingStudents", pendingStudents);
            
            // Forward to JSP
            RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/manage-students.jsp");
            dispatcher.forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error loading students: " + e.getMessage());
            RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/error.jsp");
            dispatcher.forward(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Handle POST requests (add, update, delete)
        String action = request.getParameter("action");
        
        if ("add".equals(action)) {
            addStudent(request, response);
        } else if ("update".equals(action)) {
            updateStudent(request, response);
        } else if ("delete".equals(action)) {
            deleteStudent(request, response);
        } else {
            response.sendRedirect("admin/students");
        }
    }
    
    private void addStudent(HttpServletRequest request, HttpServletResponse response) 
            throws IOException, ServletException {
    
    }
    
    private void updateStudent(HttpServletRequest request, HttpServletResponse response) 
            throws IOException, ServletException {

    }
    
    private void deleteStudent(HttpServletRequest request, HttpServletResponse response) 
            throws IOException, ServletException {

    }
}