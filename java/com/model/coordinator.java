/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.model;

/**
 *
 * @author ainan
 */
public class coordinator {

    protected String coorId;
    protected String lectId;
    protected String coorName;
    protected String phonenNo;
    protected String program;
    protected String email;
    protected String password;
    protected int semester;

   

    public String getCoorId() {
        return coorId;
    }

    public void setCoorId(String coorId) {
        this.coorId = coorId;
    }

    public String getLectId() {
        return lectId;
    }

    public void setLectId(String lectId) {
        this.lectId = lectId;
    }

    public String getCoorName() {
        return coorName;
    }

    public void setCoorName(String coorName) {
        this.coorName = coorName;
    }

    public String getPhonenNo() {
        return phonenNo;
    }

    public void setPhonenNo(String phonenNo) {
        this.phonenNo = phonenNo;
    }

    public String getProgram() {
        return program;
    }

    public void setProgram(String program) {
        this.program = program;
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
    public int getSemester() {
        return semester;
    }

    public void setSemester(int semester) {
        this.semester = semester;
    }

}
