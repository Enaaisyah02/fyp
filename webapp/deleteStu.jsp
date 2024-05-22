<%-- 
    Document   : deleteStu
    Created on : 15 Jan 2024, 3:17:13 am
    Author     : ainan
--%>

<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String stuId = request.getParameter("stuId");

    try {
        Class.forName("com.mysql.jdbc.Driver");
        String myURL = "jdbc:mysql://localhost:3306/myfyp";
        Connection cn = DriverManager.getConnection(myURL, "root", "admin");

        String deleteQuery = "DELETE FROM student WHERE stuId = ?";
        PreparedStatement ps = cn.prepareStatement(deleteQuery);
        ps.setString(1, stuId);

        int rowsAffected = ps.executeUpdate();
        cn.close();

        // Redirect back to coordinatorList.jsp after deletion
        response.sendRedirect("stuList.jsp");

    } catch (Exception e) {
        e.printStackTrace();
    }
%>