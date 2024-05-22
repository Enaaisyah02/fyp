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
public class stuAssessment {
    protected int stuAssesId;
    protected int logbookId;
    protected int proposalId;
    protected String activity;
    protected Date date;
    protected  byte[] imgExp;
    protected  byte[] reportFile;

    public int getStuAssesId() {
        return stuAssesId;
    }

    public void setStuAssesId(int stuAssesId) {
        this.stuAssesId = stuAssesId;
    }

    public int getLogbookId() {
        return logbookId;
    }

    public void setLogbookId(int logbookId) {
        this.logbookId = logbookId;
    }

    public int getProposalId() {
        return proposalId;
    }

    public void setProposalId(int proposalId) {
        this.proposalId = proposalId;
    }

    public String getActivity() {
        return activity;
    }

    public void setActivity(String activity) {
        this.activity = activity;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public byte[] getImgExp() {
        return imgExp;
    }

    public void setImgExp(byte[] imgExp) {
        this.imgExp = imgExp;
    }

    public byte[] getReportFile() {
        return reportFile;
    }

    public void setReportFile(byte[] reportFile) {
        this.reportFile = reportFile;
    }
}
