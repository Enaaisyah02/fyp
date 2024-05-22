<%-- 
    Document   : listStudentTitle
    Created on : 21 May 2024, 4:11:52 pm
    Author     : ainan
--%>

<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.*, javax.servlet.http.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Approved Project Titles</title>

<style>
    body {
        font-family: 'Arial', sans-serif;
        background-color: #f4f4f4;
        margin: 0;
        padding: 20px;
    }

    .container {
        width: 80%;
        margin: 0 auto;
        background-color: #fff;
        padding: 20px;
        border-radius: 10px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }

    h2 {
        color: #333;
    }

    table {
        width: 100%;
        margin-top: 20px;
        border-collapse: collapse;
    }

    th, td {
        padding: 10px;
        border: 1px solid #ddd;
        text-align: left;
    }

    th {
        background-color: #f2f2f2;
    }
</style>
</head>
<body>
     <%  
            String userId = (String) session.getAttribute("userId");
        %>
<jsp:include page="NavCoor.jsp" />

<div class="container">
    <h2>Approved Project Titles</h2>

    <table>
        <thead>
            <tr>
                <th>Project ID</th>
                <th>Student ID</th>
                <th>Title</th>
                <th>Description</th>
                <th>Status</th>
            </tr>
        </thead>
        <tbody>
            <% 
            try {
                Class.forName("com.mysql.jdbc.Driver");
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/myfyp", "root", "admin");
                PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM projecttitle WHERE status = ?");
                pstmt.setString(1, "Approved");
                ResultSet rs = pstmt.executeQuery();

                while (rs.next()) {
                    String formId = rs.getString("formId");
                    String stuId = rs.getString("stuId");
                    String title = rs.getString("title");
                    String description = rs.getString("description");
                    String status = rs.getString("status");
            %>
                    <tr>
                        <td><%= formId %></td>
                         <td><%= stuId %></td>
                        <td><%= title %></td>
                        <td><%= description %></td>
                        <td><%= status %></td>
                    </tr>
            <% 
                }
                rs.close();
                pstmt.close();
                conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
            %>
        </tbody>
    </table>
</div>

</body>
</html>

