<%-- 
    Document   : deleteCoor
    Created on : 22 Dec 2023, 2:51:54 am
    Author     : ainan
--%>

<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String coorId = request.getParameter("coorId");

    try {
        Class.forName("com.mysql.jdbc.Driver");
        String myURL = "jdbc:mysql://localhost:3306/myfyp";
        Connection cn = DriverManager.getConnection(myURL, "root", "admin");

        String deleteQuery = "DELETE FROM coordinator WHERE coorId = ?";
        PreparedStatement ps = cn.prepareStatement(deleteQuery);
        ps.setString(1, coorId);

        int rowsAffected = ps.executeUpdate();
        cn.close();

        // Redirect back to coordinatorList.jsp after deletion
        response.sendRedirect("coordinatorList.jsp");

    } catch (Exception e) {
        e.printStackTrace();
    }
%>