<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.*, javax.servlet.http.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Project Information</title>
<style>
    body {
        font-family: Arial, sans-serif;
        margin: 20px;
        padding: 0;
        background-color: #f5f5f5;
    }
    .container {
        max-width: 800px;
        margin: 0 auto;
        background-color: #fff;
        padding: 20px;
        border: 1px solid #ddd;
        border-radius: 5px;
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
    .error {
        color: #f00;
        margin-top: 20px;
    }
</style>
</head>
<body>
<jsp:include page="NavStudent.jsp" />
<div class="container">
    <h2>Project Information</h2>

    <%
    // Retrieve session data
    String stuId = (String) session.getAttribute("stuId");

    // Initialize error message
    String errorMessage = null;

    // Initialize project details
    String title = "";
    String description = "";
    String status = "";

    try {
        // Establish database connection
        Class.forName("com.mysql.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/myfyp", "root", "admin");

        // Prepare SQL statement
        PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM projecttitle WHERE stuId = ?");
        pstmt.setString(1, stuId);

        // Execute the query
        ResultSet rs = pstmt.executeQuery();

        // Process the result set
        if (rs.next()) {
            title = rs.getString("title");
            description = rs.getString("description");
            status = rs.getString("status");
        } else {
            errorMessage = "No project found for the current student ID.";
        }

        // Close resources
        rs.close();
        pstmt.close();
        conn.close();
    } catch (Exception e) {
        // Handle any database errors
        e.printStackTrace();
        errorMessage = "An error occurred while processing your request.";
    }

    if (errorMessage != null) {
    %>
        <div class="error">
            <%= errorMessage %>
        </div>
    <% } else { %>
        <table>
            <tr>
                <th>Title</th>
                <td><%= title %></td>
            </tr>
            <tr>
                <th>Description</th>
                <td><%= description %></td>
            </tr>
            <tr>
                <th>Status</th>
                <td><%= status %></td>
            </tr>
        </table>
    <% } %>
</div>
</body>
</html>
