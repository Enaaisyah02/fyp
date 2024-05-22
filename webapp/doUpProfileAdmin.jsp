<%-- 
    Document   : doUpProfileAdmin
    Created on : 20 Jan 2024, 7:50:16 pm
    Author     : ainan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>


<%
    // Retrieve parameters from the form
    String adminId = request.getParameter("adminId");
    String adminName = request.getParameter("adminName");
    String password = request.getParameter("password");

    // Assuming you have a database connection configured
    Connection cn = null;
    PreparedStatement preparedStatement = null;

    try {
        // Update the coordinator record in the database
        cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/myfyp", "root", "admin");
        String query = "UPDATE adminn SET adminName = ?, password = ? WHERE adminId = ?";
        preparedStatement = cn.prepareStatement(query);
        preparedStatement.setString(1, adminName);
        preparedStatement.setString(2, password);
        preparedStatement.setString(3, adminId);

        int rowsUpdated = preparedStatement.executeUpdate();

        if (rowsUpdated > 0) {
            // Successfully updated the coordinator record
            response.sendRedirect("adminDetails.jsp");
        } else {
            // Update failed
            response.sendRedirect("adminDetails.jsp");
        }
    } catch (SQLException e) {
        e.printStackTrace();
        response.sendRedirect("adminDetails.jsp");
    } finally {
        // Close the database resources
        if (preparedStatement != null) {
            preparedStatement.close();
        }
        if (cn != null) {
            cn.close();
        }
    }
%>