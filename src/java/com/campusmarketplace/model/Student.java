/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.campusmarketplace.model;

public class Student extends User {
    private String studentId;
    private String major;
    private int year;
    
    public Student() {
        this.setUserType("student");
    }
    
    // Getters and Setters
    public String getStudentId() { return studentId; }
    public void setStudentId(String studentId) { this.studentId = studentId; }
    
    public String getMajor() { return major; }
    public void setMajor(String major) { this.major = major; }
    
    public int getYear() { return year; }
    public void setYear(int year) { this.year = year; }
}
