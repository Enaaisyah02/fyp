/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.model;

/**
 *
 * @author ainan
 */
public class proposal {
    
    private int id;
    private byte [] proposalDesc;
    private String stuId;
    
    public proposal(int id, byte [] proposalDesc, String stuId){
        
        super();
        this.id = id;
        this.proposalDesc = proposalDesc;
        this.stuId = stuId;
    }
    
    public proposal(byte [] proposalDesc, String stuId){
        
        super();
        this.proposalDesc = proposalDesc;
        this.stuId = stuId;
    }
    
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public byte[] getProposalDesc() {
        return proposalDesc;
    }

    public void setProposalDesc(byte[] proposalDesc) {
        this.proposalDesc = proposalDesc;
    }
    public String getStuId() {
        return stuId;
    }

    public void setStuId(String stuId) {
        this.stuId = stuId;
    }
    
    
}
