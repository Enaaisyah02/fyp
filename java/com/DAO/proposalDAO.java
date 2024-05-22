/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.DAO;

import com.model.proposal;
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

public class proposalDAO {

    private String url = "jdbc:mysql://localhost:3306/myfyp";
    private String user = "root";
    private String pass = "admin";

    private static final String INSERT_PROPOSAL_SQL = "INSERT INTO proposal (proposalDesc, stuId) VALUES (?, ?)";
    private static final String SELECT_PROPOSAL_BY_ID = "SELECT id, proposalDesc, stuId "
            + "FROM proposal WHERE id = ?";
    private static final String SELECT_ALL_PROPOSAL = "SELECT * FROM proposal";
    private static final String DELETE_PROPOSAL_SQL = "DELETE FROM proposal WHERE id = ?";
    private static final String UPDATE_PROPOSAL_SQL = "UPDATE proposal SET proposalDesc = ?, stuId = ? WHERE id = ?;";

    public proposalDAO() {

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
     public void insertproposal(proposal proposal) throws IOException, ServletException, SQLException {
        System.out.println(INSERT_PROPOSAL_SQL);
        System.out.println("Enter Insert");

        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(INSERT_PROPOSAL_SQL)) {
            
            ps.setBytes(1, proposal.getProposalDesc());
            ps.setString(2, proposal.getStuId());

            ps.executeUpdate();
        } catch (SQLException e) {
            printSQLException(e);
            throw e;
        }
    }
public boolean deleteproposal(int id) throws SQLException {
        boolean rowDeleted = false;

        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(DELETE_PROPOSAL_SQL);) {
            ps.setInt(1, id);

            rowDeleted = ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();

        }
        return rowDeleted;
    }
public proposal selectproposal(int id) throws SQLException, ParseException {
        proposal proposal = null;

        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(SELECT_PROPOSAL_BY_ID);) {
            ps.setInt(1, id);
            System.out.println(ps);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                int proposalid = rs.getInt("id");
                Blob proposalDescBlob = rs.getBlob("proposalDesc");
                String stuId = rs.getString("stuId");
                byte[] proposalDescBytes = null;
                if (proposalDescBlob != null) {
                    proposalDescBytes = proposalDescBlob.getBytes(1, (int) proposalDescBlob.length());
                }

                // Assuming you have a constructor in FYPMaterial that takes title and file as parameters
                proposal = new proposal(proposalid, proposalDescBytes, stuId);
            }
        }
        return proposal;
    }
public List<proposal> selectAllproposal() throws SQLException, ParseException {
        List<proposal> proposal = new ArrayList<proposal>();

        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(SELECT_ALL_PROPOSAL);) {
            System.out.println(ps);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                int id = rs.getInt("id");
                Blob proposalDescBlob = rs.getBlob("proposalDesc");
                String stuId = rs.getString("stuId");
                byte[] proposalDescBytes = null;
                if (proposalDescBlob != null) {
                    proposalDescBytes = proposalDescBlob.getBytes(1, (int) proposalDescBlob.length());
                }

                proposal.add(new proposal(id, proposalDescBytes, stuId));
            }
        }
        return proposal;
    }
public boolean updateproposal(proposal proposal) throws SQLException {
        boolean rowUpdated = false;

        try {
            Connection conn = getConnection();
            PreparedStatement ps = conn.prepareStatement(UPDATE_PROPOSAL_SQL);
            ps.setBytes(1, proposal.getProposalDesc());
            ps.setString(2, proposal.getStuId());
            ps.setInt(3, proposal.getId());

           rowUpdated = ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        System.out.println("update Porposal => Value for rowUpdated = " + rowUpdated);
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
            String sql = "SELECT proposalDesc FROM proposal WHERE id = ?";
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, id);
            resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                fileData = resultSet.getBytes("proposalDesc");
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
    

