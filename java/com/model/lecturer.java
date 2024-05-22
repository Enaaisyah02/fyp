/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.model;

/**
 *
 * @author ainan
 */
public class lecturer {

    protected String lectId;
    protected String lectName;
    protected String phoneNo;
    protected String program;
    protected int semester;
    protected String email;
    protected String password;
    

    public lecturer(String lectId, String lectName, String phoneNo, String program, int semester, String email, String password) {
        super();
        this.lectId = lectId;
        this.lectName = lectName;
        this.phoneNo = phoneNo;
        this.program = program;
        this.semester = semester;
        this.email = email;
        this.password = password;
        
    }

    public lecturer(String lectName, String phoneNo, String program, int semester, String email, String password) {
        super();
        this.lectName = lectName;
        this.phoneNo = phoneNo;
        this.program = program;
        this.semester = semester;
        this.email = email;
        this.password = password;
        

    }

    public String getLectId() {
        return lectId;
    }

    public void setLectId(String lectId) {
        this.lectId = lectId;
    }

    public String getLectName() {
        return lectName;
    }

    public void setLectName(String lectName) {
        this.lectName = lectName;
    }

    public String getPhoneNo() {
        return phoneNo;
    }

    public void setPhoneNo(String phoneNo) {
        this.phoneNo = phoneNo;
    }

    public String getProgram() {
        return program;
    }

    public void setProgram(String program) {
        this.program = program;
    }

    public int getSemester() {
        return semester;
    }

    public void setSemester(int semester) {
        this.semester = semester;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

   
}
