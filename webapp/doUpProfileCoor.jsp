<%-- 
    Document   : doEditCoor
    Created on : 27 Dec 2023, 2:15:47 am
    Author     : ainan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>


<%
    // Retrieve parameters from the form
    String coorId = request.getParameter("coorId");
    String coorName = request.getParameter("coorName");
    String phoneNo = request.getParameter("phoneNo");
    String program = request.getParameter("program");
    String email = request.getParameter("email");
    String password = request.getParameter("password");

    // Assuming you have a database connection configured
    Connection cn = null;
    PreparedStatement preparedStatement = null;

    try {
        // Update the coordinator record in the database
        cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/myfyp", "root", "admin");
        String query = "UPDATE coordinator SET coorName = ?, phoneNo = ?, program = ?,  email = ?, password = ? WHERE coorId = ?";
        preparedStatement = cn.prepareStatement(query);
        preparedStatement.setString(1, coorName);
        preparedStatement.setString(2, phoneNo);
        preparedStatement.setString(3, program);
        preparedStatement.setString(4, email);
        preparedStatement.setString(5, password);
        preparedStatement.setString(6, coorId);

        int rowsUpdated = preparedStatement.executeUpdate();

        if (rowsUpdated > 0) {
            // Successfully updated the coordinator record
            response.sendRedirect("CoorDetails.jsp");
        } else {
            // Update failed
            response.sendRedirect("CoorDetails.jsp");
        }
    } catch (SQLException e) {
        e.printStackTrace();
        response.sendRedirect("CoorDetails.jsp");
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
