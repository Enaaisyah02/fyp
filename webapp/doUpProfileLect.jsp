<%-- 
    Document   : doUpProfileLect
    Created on : 20 Jan 2024, 4:44:47 pm
    Author     : ainan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>


<%
    // Retrieve parameters from the form
    String lectId = request.getParameter("lectId");
    String lectName = request.getParameter("lectName");
    String phoneNo = request.getParameter("phoneNo");
    String program = request.getParameter("program");
    int semester = Integer.parseInt(request.getParameter("semester"));
    String email = request.getParameter("email");
    String password = request.getParameter("password");

    // Assuming you have a database connection configured
    Connection cn = null;
    PreparedStatement preparedStatement = null;

    try {
        // Update the coordinator record in the database
        cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/myfyp", "root", "admin");
        String query = "UPDATE lecturer SET lectName = ?, phoneNo = ?, program = ?, semester = ?, email = ?, password = ? WHERE lectId = ?";
        preparedStatement = cn.prepareStatement(query);
        preparedStatement.setString(1, lectName);
        preparedStatement.setString(2, phoneNo);
        preparedStatement.setString(3, program);
        preparedStatement.setInt(4, semester);
        preparedStatement.setString(5, email);
        preparedStatement.setString(6, password);
        preparedStatement.setString(7, lectId);

        int rowsUpdated = preparedStatement.executeUpdate();

        if (rowsUpdated > 0) {
            // Successfully updated the coordinator record
            response.sendRedirect("lectDetails.jsp");
        } else {
            // Update failed
            response.sendRedirect("lectDetails.jsp");
        }
    } catch (SQLException e) {
        e.printStackTrace();
        response.sendRedirect("lectDetails.jsp");
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
