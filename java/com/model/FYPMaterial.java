/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.model;

public class FYPMaterial {

    private int id;
    private String title;
    private byte [] fileDesc;
    
    
     public FYPMaterial(int id, String title, byte [] fileDesc) {
        super();
        this.id = id;
        this.fileDesc = fileDesc;
        this.title = title;

    }

    public FYPMaterial(String title, byte [] fileDesc) {
        super();
        this.title = title;
        this.fileDesc = fileDesc;

    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }
    public byte[] getFileDesc() {
        return fileDesc;
    }

    public void setFileDesc(byte[] fileDesc) {
        this.fileDesc = fileDesc;
    }


    

   

}
