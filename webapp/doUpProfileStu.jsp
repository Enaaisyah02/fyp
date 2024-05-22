<%-- 
    Document   : doUpProfileStu
    Created on : 20 Jan 2024, 8:18:06 pm
    Author     : ainan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>


<%
    // Retrieve parameters from the form
    String stuId = request.getParameter("stuId");
    String stuName = request.getParameter("stuName");
    String phoneNo = request.getParameter("phoneNo");
    String program = request.getParameter("program");
    String semester = request.getParameter("semester");
    String courseCode = request.getParameter("courseCode");
    String email = request.getParameter("email");
    String password = request.getParameter("password");

    // Assuming you have a database connection configured
    Connection cn = null;
    PreparedStatement preparedStatement = null;

    try {
        // Update the coordinator record in the database
        cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/myfyp", "root", "admin");
        String query = "UPDATE student SET stuName = ?, phoneNo = ?, program = ?, semester = ?, courseCode = ?, email = ?, password = ? WHERE stuId = ?";
        preparedStatement = cn.prepareStatement(query);
        preparedStatement.setString(1, stuName);
        preparedStatement.setString(2, phoneNo);
        preparedStatement.setString(3, program);
        preparedStatement.setString(4, semester);
        preparedStatement.setString(5, courseCode);
        preparedStatement.setString(6, email);
        preparedStatement.setString(7, password);
        preparedStatement.setString(8, stuId);

        int rowsUpdated = preparedStatement.executeUpdate();

        if (rowsUpdated > 0) {
            // Successfully updated the coordinator record
            response.sendRedirect("stuDetails.jsp");
        } else {
            // Update failed
            response.sendRedirect("stuDetails.jsp");
        }
    } catch (SQLException e) {
        e.printStackTrace();
        response.sendRedirect("stuDetails.jsp");
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
