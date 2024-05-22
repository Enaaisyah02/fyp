/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.DAO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.List;
import com.model.lecturer;

public class lecturerDAO {

    private String url = "jdbc:mysql://localhost:3306/myfyp";
    private String user = "root";
    private String pass = "admin";

    private static final String INSERT_LECT_SQL = "INSERT INTO lecturer(lectId, lectName, phoneNo, program, semester, email, password) VALUES (?,?,?,?,?,?,?);";
    private static final String SELECT_LECT_BY_ID = "SELECT lectId, lectName, phoneNo, program, semester, email, password "
            + "FROM lecturer WHERE lectId = ?";
    private static final String SELECT_ALL_LECT = "SELECT * FROM lecturer";
    private static final String DELETE_LECT_SQL = "DELETE FROM lecturer WHERE lectId = ?";
    private static final String UPDATE_LECT_SQL = "UPDATE lecturer SET lectName = ?, phoneNo = ?, program = ?, semester = ?, email = ?, password = ? WHERE lectId = ?;";

    public lecturerDAO() {
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

    public void insertLecturer(lecturer lectRegister) throws SQLException {
        System.out.println(INSERT_LECT_SQL);

        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(INSERT_LECT_SQL)) {
            ps.setString(1, lectRegister.getLectId());
            ps.setString(2, lectRegister.getLectName());
            ps.setString(3, lectRegister.getPhoneNo());
            ps.setString(4, lectRegister.getProgram());
            ps.setInt(5, lectRegister.getSemester());
            ps.setString(6, lectRegister.getEmail());
            ps.setString(7, lectRegister.getPassword());

            System.out.println(ps);
            ps.executeUpdate();
        } catch (SQLException e) {
            printSQLException(e);

        }
    }

    public lecturer selectLecturer(String lectId) throws SQLException, ParseException {
        lecturer lect = null;

        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(SELECT_LECT_BY_ID);) {
            ps.setString(1, lectId);
            System.out.println(ps);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                String lectName = rs.getString("lectName");
                String phoneNo = rs.getString("phoneNo");
                String program = rs.getString(" program");
                int semester = rs.getInt("semester");
                String email = rs.getString("email");
                String password = rs.getString("password");

                lect = new lecturer(lectId, lectName, phoneNo, program, semester, email, password);
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return lect;
    }

    public List<lecturer> selectAllLecturer() throws SQLException, ParseException {

        List<lecturer> lecturer = new ArrayList<>();

        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(SELECT_ALL_LECT);) {
         System.out.println(ps);   
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                String lectId = rs.getString("lectId");
                String lectName = rs.getString("lectName");
                String phoneNo = rs.getString("phoneNo");
                String program = rs.getString("program");
                int semester = rs.getInt("semester");
                String email = rs.getString("email");
                String password = rs.getString("password");

                lecturer.add(new lecturer(lectId, lectName, phoneNo, program, semester, email, password));
            }

        } catch (SQLException e) {
            printSQLException(e);
        }
        return lecturer;

    }

    public boolean deleteLecturer(String lectId) throws SQLException {
        boolean rowDeleted;

        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(DELETE_LECT_SQL);) {
            ps.setString(1, lectId);

            rowDeleted = ps.executeUpdate() > 0;

        }
        return rowDeleted;
    }

    public boolean updateLecturer(lecturer lectRegister) throws SQLException {
        boolean rowUpdated;

        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(UPDATE_LECT_SQL);) {

            ps.setString(1, lectRegister.getLectName());
            ps.setString(2, lectRegister.getPhoneNo());
            ps.setString(3, lectRegister.getProgram());
            ps.setInt(4, lectRegister.getSemester());
            ps.setString(5, lectRegister.getEmail());
            ps.setString(6, lectRegister.getPassword());
            ps.setString(7, lectRegister.getLectId());

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
}
