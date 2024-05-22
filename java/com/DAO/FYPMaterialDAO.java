/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.DAO;

import com.model.FYPMaterial;
import jakarta.servlet.ServletException;
/**
 *
 * @author ainan
 */
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Blob;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;

public class FYPMaterialDAO {

    private String url = "jdbc:mysql://localhost:3306/myfyp";
    private String user = "root";
    private String pass = "admin";

    private static final String INSERT_MATERIAL_SQL = "INSERT INTO fypmaterial (title, fileDesc) VALUES (?, ?)";
    private static final String SELECT_MATERIAL_BY_ID = "SELECT id, title, fileDesc "
            + "FROM fypmaterial WHERE id = ?";
    private static final String SELECT_ALL_MATERIAL = "SELECT * FROM fypmaterial";
    private static final String DELETE_MATERIAL_SQL = "DELETE FROM fypmaterial WHERE id = ?";
    private static final String UPDATE_MATERIAL_SQL = "UPDATE fypmaterial SET title = ?, fileDesc = ? WHERE id = ?;";

    public FYPMaterialDAO() {

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

    public void insertFYPMaterial(FYPMaterial FYPMaterial) throws IOException, ServletException, SQLException {
        System.out.println(INSERT_MATERIAL_SQL);
        System.out.println("Enter Insert");

        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(INSERT_MATERIAL_SQL)) {
            ps.setString(1, FYPMaterial.getTitle());
            ps.setBytes(2, FYPMaterial.getFileDesc());

            ps.executeUpdate();
        } catch (SQLException e) {
            printSQLException(e);
            throw e;
        }
    }

    public boolean deleteFYPMaterial(int id) throws SQLException {
        boolean rowDeleted = false;

        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(DELETE_MATERIAL_SQL);) {
            ps.setInt(1, id);

            rowDeleted = ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();

        }
        return rowDeleted;
    }

    public FYPMaterial selectFYPMaterial(int id) throws SQLException, ParseException {
        FYPMaterial FYPMaterial = null;

        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(SELECT_MATERIAL_BY_ID);) {
            ps.setInt(1, id);
            System.out.println(ps);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                int fileid = rs.getInt("id");
                String title = rs.getString("title");
                Blob fileDescBlob = rs.getBlob("fileDesc");
                byte[] fileDescBytes = null;
                if (fileDescBlob != null) {
                    fileDescBytes = fileDescBlob.getBytes(1, (int) fileDescBlob.length());
                }

                // Assuming you have a constructor in FYPMaterial that takes title and file as parameters
                FYPMaterial = new FYPMaterial(fileid, title, fileDescBytes);
            }
        }
        return FYPMaterial;
    }

    public List<FYPMaterial> selectAllFYPMaterial() throws SQLException, ParseException {
        List<FYPMaterial> FYPMaterial = new ArrayList<FYPMaterial>();

        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(SELECT_ALL_MATERIAL);) {
            System.out.println(ps);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                int id = rs.getInt("id");
                String title = rs.getString("title");
                Blob fileDescBlob = rs.getBlob("fileDesc");
                byte[] fileDescBytes = null;
                if (fileDescBlob != null) {
                    fileDescBytes = fileDescBlob.getBytes(1, (int) fileDescBlob.length());
                }

                FYPMaterial.add(new FYPMaterial(id, title, fileDescBytes));
            }
        }
        return FYPMaterial;
    }

    public boolean updateFYPMaterial(FYPMaterial FYPMaterial) throws SQLException {
        boolean rowUpdated = false;

        try {
            Connection conn = getConnection();
            PreparedStatement ps = conn.prepareStatement(UPDATE_MATERIAL_SQL);
            ps.setString(1, FYPMaterial.getTitle());
            ps.setBytes(2, FYPMaterial.getFileDesc());
            ps.setInt(3, FYPMaterial.getId());

           rowUpdated = ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        System.out.println("update FYPMaterial => Value for rowUpdated = " + rowUpdated);
        return rowUpdated;
    }

    private void printSQLException(SQLException ex) {
        for (Throwable e : ex) {
            if (e instanceof SQLException) {
                e.printStackTrace(System.err);
                System.err.println("SQLState: " + ((SQLException) e).getSQLState());
                System.err.println("Error Code: " + ((SQLException) e).getErrorCode());
                System.err.println("Message: " + e.getMessage());
                Throwable t = ex.getCause();
                while (t != null) {
                    System.out.println("Cause " + t);
                }
            }
        }
    }
// to handle file to be download

    public byte[] getFileData(int id) throws SQLException {
        byte[] fileData = null;
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            connection = getConnection();
            String sql = "SELECT fileDesc FROM fypmaterial WHERE id = ?";
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, id);
            resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                fileData = resultSet.getBytes("fileDesc");
            }
        } finally {
            // Close resources
            if (resultSet != null) {
                resultSet.close();
            }
            if (preparedStatement != null) {
                preparedStatement.close();
            }
            if (connection != null) {
                connection.close();
            }
        }

        return fileData;
    }

}
