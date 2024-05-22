/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.DAO;

import com.model.logbook;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Blob;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;
import java.sql.Date;

public class logbookDAO {

    private String url = "jdbc:mysql://localhost:3306/myfyp";
    private String user = "root";
    private String pass = "admin";

    private static final String INSERT_LOGBOOK_SQL = "INSERT INTO logbook(stuId, activity, problem, solution, date, imgExp) VALUES "
            + "(?, ?, ?, ?, ?, ?);";
    private static final String SELECT_LOGBOOK_BY_ID = "SELECT logbookId, stuId, activity, problem, solution, date, imgExp"
            + "FROM logbook WHERE logbookId= ?";
    private static final String SELECT_ALL_LOGBOOK = "SELECT * FROM logbook";
    private static final String DELETE_LOGBOOK_SQL = "DELETE FROM logbook where logbookId=?;";
    private static final String UPDATE_LOGBOOK_SQL = "UPDATE logbook SET stuId=?, activity=?, problem=?, solution=?, date=?, imgExp=? WHERE logbookId=?;";

    public logbookDAO() {
        
    }
    
    protected Connection getConnection() {
        Connection conn = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(url, user, pass);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

        return conn;
    }

    public void insertLogbook(logbook logbook) throws SQLException {
        System.out.println(INSERT_LOGBOOK_SQL);
        System.out.println("Enter Insert");

        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(INSERT_LOGBOOK_SQL)) {
            ps.setString(1, logbook.getStuId());
            ps.setString(2, logbook.getActivity());
            ps.setString(3, logbook.getProblem());
            ps.setString(4, logbook.getSolution());
            ps.setDate(5, logbook.getDate());
            ps.setBytes(6, logbook.getImgExp());
            
            
            ps.executeUpdate();
        } catch (SQLException e) {
            printSQLException(e);
            throw e;
        }
    }

    public logbook selectLogbook(int logbookId) throws Exception {
        logbook logbook = null;
        String base64Image = null;
        

        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(SELECT_LOGBOOK_BY_ID);) {
            ps.setInt(1, logbookId);
            System.out.println(ps);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                int logId = rs.getInt("logbookId");
                String stuId = rs.getString("stuId");
                String activity = rs.getString("activity");
                String problem = rs.getString("problem");
                String solution = rs.getString("solution");
                Date date = rs.getDate("date");
                
              //image
                Blob blob = rs.getBlob("image");
                base64Image = convertBlobToBase64(blob);
                if (blob != null) {
                    InputStream inputStream = blob.getBinaryStream();

                    ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
                    byte[] buffer = new byte[4096];
                    int bytesRead = -1;

                    while ((bytesRead = inputStream.read(buffer)) != -1) {
                        outputStream.write(buffer, 0, bytesRead);
                    }
                    byte[] imageBytes = outputStream.toByteArray();
                    base64Image = Base64.getEncoder().encodeToString(imageBytes);

                    inputStream.close();

                    outputStream.close();
                
                logbook = new logbook(logId, stuId, activity, problem, solution, date, imageBytes);
            } else {
                    throw new NullPointerException("The blob object is null");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return logbook;
    }

    public List<logbook> selectAllLogbook() throws IOException {

        List<logbook> logbook = new ArrayList<>();
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(SELECT_ALL_LOGBOOK);) {
            System.out.println(ps);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {

                int logbookId = rs.getInt("logbookId");
                String stuId = rs.getString("stuId");
                String activity = rs.getString("activity");
                String problem = rs.getString("problem");
                String solution = rs.getString("solution");
                Date date = rs.getDate("date");
                
                //image
                Blob blob = rs.getBlob("imgExp");
                byte[] imageBytes = null;
                if (blob != null) {
                    try (InputStream inputStream = blob.getBinaryStream(); ByteArrayOutputStream outputStream = new ByteArrayOutputStream()) {
                        byte[] buffer = new byte[4096];
                        int bytesRead;

                        while ((bytesRead = inputStream.read(buffer)) != -1) {
                            outputStream.write(buffer, 0, bytesRead);
                        }
                        imageBytes = outputStream.toByteArray();
                    }
                }

                logbook.add(new logbook(logbookId, stuId, activity, problem, solution, date, imageBytes));
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return logbook;
    }

    public boolean deleteLogbook(int logbookId) throws SQLException {
        boolean rowDeleted = false;

        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(DELETE_LOGBOOK_SQL);) {
            ps.setInt(1, logbookId);

            rowDeleted = ps.executeUpdate() > 0;

        }
        return rowDeleted;
    }

    public boolean updateLogbook(logbook logbook) throws SQLException {
        boolean rowUpdated = false;

        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(UPDATE_LOGBOOK_SQL)) {
            ps.setString(1, logbook.getActivity());
            ps.setString(2, logbook.getProblem());
            ps.setString(3, logbook.getSolution());
            ps.setDate(4, logbook.getDate());
            ps.setBytes(5, logbook.getImgExp());
            rowUpdated = ps.executeUpdate() > 0;

            rowUpdated = ps.executeUpdate() > 0;
        }

        return rowUpdated;

    }
 private static void printSQLException(SQLException ex) {
        for (Throwable e : ex) {
            if (e instanceof SQLException) {
                e.printStackTrace(System.err);
                System.err.println("SQLState: " + ((SQLException) e).getSQLState());
                System.err.println("Error code: " + ((SQLException) e).getErrorCode());
                System.err.println("Message: " + e.getMessage());
                Throwable t = ex.getCause();
                while (t != null) {
                    System.out.println("Cause: " + t);
                    t = t.getCause();
                }
            }
        }
    }
 private String convertBlobToBase64(Blob blob) throws IOException, SQLException {
        if (blob != null) {
            try (InputStream inputStream = blob.getBinaryStream(); ByteArrayOutputStream outputStream = new ByteArrayOutputStream()) {
                byte[] buffer = new byte[4096];

                int bytesRead;

                while ((bytesRead = inputStream.read(buffer)) != -1) {
                    outputStream.write(
                            buffer, 0, bytesRead);
                }
                byte[] imageBytes = outputStream.toByteArray();
                return Base64.getEncoder().encodeToString(imageBytes);
            } catch (IOException e) {
                e.printStackTrace();
                throw e;
            }
        }
        return null;
    }
}

