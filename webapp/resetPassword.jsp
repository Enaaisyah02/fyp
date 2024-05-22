<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="java.io.IOException" %>
<%@page session="true"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
       
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f7f7f7;
               
            }

            h1 {
                text-align: center;
                margin-top: 30px;
            }

            form {
                max-width: 300px;
                margin: 0 auto;
                background-color: #ffffff;
                padding: 20px;
                border-radius: 5px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                margin-top: 30px;
            }

            input[type="text"],
            input[type="password"] {
                width: 100%;
                padding: 10px;
                margin-bottom: 15px;
                border: 1px solid #ccc;
                border-radius: 4px;
                box-sizing: border-box;
            }

            input[type="submit"] {
                background-color: white;
                color: black;
                padding: 10px 15px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                width: 100%;
                border: 3px solid chocolate;
            }

            input[type="submit"]:hover {
                background-color: burlywood;
            }

            .error-message {
                color: #f00;
                margin-top: 10px;
            }
        </style>
    </head>
    <body>

        

        <%-- Retrieve the ID and new password from the request parameters --%>
        <%
            String Id = request.getParameter("Id");
            String newPassword = request.getParameter("newPassword");

            // Check if the ID and new password are provided
            if (ID != null && newPassword != null) {
                Connection conn = null;
                PreparedStatement stmt = null;

                try {
                    // Establish a connection to the database
                    Class.forName("com.mysql.jdbc.Driver");
                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3308/myproject", "root", "");

                    // Prepare the SQL statement to update the password
                    String query = "";

                    // Check if the ID is for empID or managerID
                    if (ID.startsWith("E")) {
                        query = "UPDATE staff SET password = ? WHERE empID = ?";
                    } else if (ID.startsWith("M")) {
                        query = "UPDATE manager SET password = ? WHERE managerID = ?";
                    } else {
                        // Invalid ID, redirect to resetPassword.jsp
                        response.sendRedirect("resetPassword.jsp");
                        return;
                    }

                    stmt = conn.prepareStatement(query);
                    stmt.setString(1, newPassword);
                    stmt.setString(2, ID);

                    // Execute the update query
                    int rowsAffected = stmt.executeUpdate();

                    if (rowsAffected > 0) {
                        // Password reset successful, redirect to login.jsp
                        response.sendRedirect("LoginUser.jsp");
                    } else {
                        // If the ID does not exist, redirect to resetPassword.jsp
                        response.sendRedirect("resetPassword.jsp");
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                } catch (ClassNotFoundException e) {
                    e.printStackTrace();
                } finally {
                    // Close the database resources
                    try {
                        if (stmt != null) {
                            stmt.close();
                        }
                        if (conn != null) {
                            conn.close();
                        }
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            } else {
                // Display the form to enter the ID and new password
        %>
        
        <form action="resetPassword.jsp" method="post">
            <h1>Reset Password</h1>
            <p>Enter your ID:</p>
            <input type="text" name="ID" required>
            <br>
            <p>Enter a new password:</p>
            <input type="password" name="newPassword" required>
            <br>
            <input type="submit" value="Reset Password">
        </form>
        <% }%>
        <jsp:include page="Footer.jsp" />
    </body>
</html>
