<%-- 
    Document   : updateProfileAdmin
    Created on : 20 Jan 2024, 7:45:58 pm
    Author     : ainan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@page session="true"%>
<html>
    <head>
        <jsp:include page="bootstrap.jsp"/>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f2f2f2;
            }

            .container {
                max-width: 500px;
                margin: 0 auto;
                background-color: #fff;
                padding: 20px;
                border-radius: 5px;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            }

            h1 {
                color: #333;
                text-align: center;
            }

            form {
                margin-top: 20px;
            }

            .form-group {
                margin-bottom: 20px;
            }

            label {
                font-weight: bold;
            }

            select, input[type="text"], input[type="number"] {
                width: 100%;
                padding: 10px;
                border: 1px solid #ccc;
                border-radius: 4px;
            }

            input[type="submit"] {
                background-color: #9b9bdc;
                color: #fff;
                border: none;
                padding: 10px 20px;
                border-radius: 4px;
                cursor: pointer;
            }

            input[type="submit"]:hover {
                background-color: #0056b3;
            }
        </style>


    </head>
    <body>


        <jsp:include page="NavAdmin.jsp" />
        <%
    String userId = (String) session.getAttribute("userId");
    String adminId = request.getParameter("adminId");

    if (adminId == null || adminId.isEmpty()) {
        response.sendRedirect("LoginUser.jsp");
    } else {
        Connection cn = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            // Validate coorId from the database
            cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/myfyp", "root", "admin");

            // Fetch the existing details of the coordinator
            String query = "SELECT * FROM adminn WHERE adminId = ?";
            preparedStatement = cn.prepareStatement(query);
            preparedStatement.setString(1, adminId);
            resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                // Existing details
                String adminName = resultSet.getString("adminName");
                String password = resultSet.getString("password");

                // ... retrieve other fields
        %>


        <div class="container">
            <h1>Update Profile</h1>
            <form method="POST" action="doUpProfileAdmin.jsp">
                <div class="form-group">
                    <label for="adminId">Admin ID:</label>
                    <input type="hidden" name="adminId" value="<%= adminId %>">
                    <input type="text" class="form-control" value="<%= adminId %>" disabled>
                </div>
                <div class="form-group">
                    <label for="adminName">Name:</label>
                    <input type="text" class="form-control" name="adminName" value="<%= adminName %>" >
                </div>
                <div class="form-group">
                    <label for="password">Password:</label>
                    <input type="text" class="form-control" name="password" value="<%= password %>">
                </div>
                <!-- Add other fields here -->
                <div class="form-group text-center">
                    <input type="submit" class="btn btn-primary" value="Update">
                </div>
            </form>
        </div>
        <%
                    } else {
                        // Coordinator not found
                        response.sendRedirect("adminDetails.jsp");
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                    response.sendRedirect("adminDetails.jsp");
                } finally {
                    // Close the database resources
                    try {
                        if (resultSet != null) {
                            resultSet.close();
                        }
                        if (preparedStatement != null) {
                            preparedStatement.close();
                        }
                        if (cn != null) {
                            cn.close();
                        }
                    } catch (SQLException ex) {
                        ex.printStackTrace();
                    }
                }
            }
        %>


        <jsp:include page="footer.jsp" />
    </body>
</html>
