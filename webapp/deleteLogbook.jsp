<%-- 
    Document   : deleteLogbook
    Created on : 22 Jan 2024, 1:21:13 pm
    Author     : ainan
--%>

<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String logbookId = request.getParameter("logbookId");

    try {
        Class.forName("com.mysql.jdbc.Driver");
        String myURL = "jdbc:mysql://localhost:3306/myfyp";
        Connection cn = DriverManager.getConnection(myURL, "root", "admin");

        String deleteQuery = "DELETE FROM logbook WHERE logbookId = ?";
        PreparedStatement ps = cn.prepareStatement(deleteQuery);
        ps.setString(1, logbookId);

        int rowsAffected = ps.executeUpdate();
        cn.close();

        // Redirect back to coordinatorList.jsp after deletion
        response.sendRedirect("listLogBook.jsp");

    } catch (Exception e) {
        e.printStackTrace();
    }
%>