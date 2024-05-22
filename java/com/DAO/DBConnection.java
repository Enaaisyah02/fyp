/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.DAO;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 *
 * @author ainan
 */
public class DBConnection {
    public static void main(String[]args) throws SQLException{
        Connection conn = null;
        
        try{ 
        //load the JDBC driver
        Class.forName("com.mysql.cj.jdbc.Driver");
        
        //MYSql database URL
        String url = "jdbc:mysql://localhost:3306/myfyp";
        //MYSql username and password
        String username = "root";
        String password = "admin";
        
        //Establish the connection
        conn = DriverManager.getConnection(url, username, password);
        
        //check if the connection is successfull
        if(conn!=null){
            System.out.println("Coonected to the database!");
        }else {
            System.out.println("Failed to connect to the database");
        } 
       }catch (ClassNotFoundException|SQLException e){
           e.printStackTrace();
       }finally{
            try{
                if(conn!=null){
                    conn.close();
                    
                }
            }catch(SQLException e){
                e.printStackTrace();
            }
        }
    }
}
