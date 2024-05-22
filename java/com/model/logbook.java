/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.model;

import java.sql.Date;
import jakarta.persistence.Column;
import jakarta.persistence.Transient;
import java.util.Base64;

/**
 *
 * @author ainan
 */
public class logbook {

    protected int logbookId;
    protected String stuId;
    protected String activity;
    protected String problem;
    protected String solution;
    protected Date date;
    protected byte[] imgExp;

    @Column(name = "imgExp")
    public byte[] getImgExp() {
        return this.imgExp;
    }

    // Declare base64Image
    private String base64Image;

    @Transient
    public String getBase64Image() {
        if (this.imgExp != null) {
            base64Image = Base64.getEncoder().encodeToString(this.imgExp); // encode image
        }
        return base64Image;
    }

    public void setBase64Image(String base64Image) {
        this.base64Image = base64Image;
    }

    public logbook(int logbookId, String stuId, String activity, String problem, String solution, Date date, byte[] imgExp) {
        this.logbookId = logbookId;
        this.activity = activity;
        this.problem = problem;
        this.solution = solution;
        this.date = date;
        this.imgExp = imgExp;
    }

    public logbook(String stuId, String activity, String problem, String solution, Date date, byte[] imgExp) {
        super();
        this.activity = activity;
        this.problem = problem;
        this.solution = solution;
        this.date = date;
        this.imgExp = imgExp;
    }

    public int getLogbookId() {
        return logbookId;
    }

    public void setLogbookId(int logbookId) {
        this.logbookId = logbookId;
    }
     public String getStuId() {
        return stuId;
    }

    public void setStuId(String stuId) {
        this.stuId = stuId;
    }

    public String getActivity() {
        return activity;
    }

    public void setActivity(String activity) {
        this.activity = activity;
    }

    public String getProblem() {
        return problem;
    }

    public void setProblem(String problem) {
        this.problem = problem;
    }

    public String getSolution() {
        return solution;
    }

    public void setSolution(String solution) {
        this.solution = solution;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public void setImgExp(byte[] imgExp) {
        this.imgExp = imgExp;
    }

}
