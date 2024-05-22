<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.*, javax.servlet.http.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Coordinator Dashboard</title>

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

    .approval-form {
        margin-top: 20px;
        padding: 10px;
        background-color: #f2f2f2;
        border-radius: 5px;
    }

    .approval-form label {
        display: block;
        margin-bottom: 10px;
    }

    .approval-form input[type="submit"] {
        background-color: #4caf50;
        color: white;
        padding: 10px 20px;
        border: none;
        cursor: pointer;
    }

    .approval-form input[type="submit"]:hover {
        background-color: #45a049;
    }

    .error-message {
        color: red;
        margin-top: 10px;
    }
</style>
</head>
<body>
     <%  
            String userId = (String) session.getAttribute("userId");
        %>
<jsp:include page="NavCoor.jsp" />

<div class="container">
    <h2>Coordinator Dashboard - Pending Project Titles</h2>

    <table>
        <thead>
            <tr>
                <th>Student ID</th>
                <th>Title</th>
                <th>Description</th>
                <th>Status</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
            <% 
            try {
                Class.forName("com.mysql.jdbc.Driver");
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/myfyp", "root", "admin");
                PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM projecttitle WHERE status = ?");
                pstmt.setString(1, "Pending");
                ResultSet rs = pstmt.executeQuery();

                while (rs.next()) {
                    String formId = rs.getString("formId"); // Corrected variable name
                    String stuId = rs.getString("stuId");
                    String title = rs.getString("title");
                    String description = rs.getString("description");
                    String status = rs.getString("status");
            %>
                    <tr>
                        <td><%= stuId %></td>
                        <td><%= title %></td>
                        <td><%= description %></td>
                        <td><%= status %></td>
                        <td>
                            <div class="approval-form">
                                <form action="doTitleApproval.jsp" method="post">
                                    <input type="hidden" name="formId" value="<%= formId %>"> <!-- Corrected variable name -->
                                    <label for="approval">Approve Project:</label>
                                    <select name="approval">
                                        <option value="Approved">Approve</option>
                                        <option value="Rejected">Reject</option>
                                    </select>
                                    <br>
                                    <label for="comments">Comments:</label><br>
                                    <textarea name="comments" rows="3" cols="50"></textarea>
                                    <br>
                                    <input type="submit" value="Submit">
                                </form>
                            </div>
                        </td>
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

    <!-- Show an error message if there is any error parameter passed from doApproveProject.jsp -->
    <% String errorMessage = (String) request.getAttribute("errorMessage"); %>
    <% if (errorMessage != null) { %>
    <p class="error-message"><%= errorMessage %></p>
    <% } %>
</div>

</body>
</html>
