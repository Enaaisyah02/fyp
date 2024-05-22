/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.model;

import java.sql.Date;

/**
 *
 * @author ainan
 */
public class presentSch {
    
    protected int groupId;
    protected int totalPanel;
    protected String lectId;
    protected String lectName;
    protected String stuId;
    protected Date date;
    protected String venue;
    
    public presentSch(int groupId, int totalPanel, String lectId, String lectName, String stuId, Date date, String venue) {
        this.groupId = groupId;
        this.totalPanel = totalPanel;
        this.lectId = lectId;
        this.lectName = lectName;
        this.stuId = stuId;
        this.date = date;
        this.venue = venue;
    }

    public int getGroupId() {
        return groupId;
    }

    public void setGroupId(int groupId) {
        this.groupId = groupId;
    }

    public int getTotalPanel() {
        return totalPanel;
    }

    public void setTotalPanel(int totalPanel) {
        this.totalPanel = totalPanel;
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

    public String getStuId() {
        return stuId;
    }

    public void setStuId(String stuId) {
        this.stuId = stuId;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public String getVenue() {
        return venue;
    }

    public void setVenue(String venue) {
        this.venue = venue;
    }
    
    
}
