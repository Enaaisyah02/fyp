<%-- 
    Document   : updateProfileCoor
    Created on : 20 Jan 2024, 2:30:01 pm
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


        <jsp:include page="NavCoor.jsp" />
        <%
    String userId = (String) session.getAttribute("userId");
    String coorId = request.getParameter("coorId");

    if (coorId == null || coorId.isEmpty()) {
        response.sendRedirect("LoginUser.jsp");
    } else {
        Connection cn = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            // Validate coorId from the database
            cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/myfyp", "root", "admin");

            // Fetch the existing details of the coordinator
            String query = "SELECT * FROM coordinator WHERE coorId = ?";
            preparedStatement = cn.prepareStatement(query);
            preparedStatement.setString(1, coorId);
            resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                // Existing details
                String coorName = resultSet.getString("coorName");
                String phoneNo = resultSet.getString("phoneNo");
                String program = resultSet.getString("program");
                String email = resultSet.getString("email");
                String password = resultSet.getString("password");

                // ... retrieve other fields
        %>


        <div class="container">
            <h1>Update Profile</h1>
            <form method="POST" action="doUpProfileCoor.jsp">
                <div class="form-group">
                    <label for="coorId">Coordinator ID:</label>
                    <input type="hidden" name="coorId" value="<%= coorId %>">
                    <input type="text" class="form-control" value="<%= coorId %>" disabled>
                </div>
                <div class="form-group">
                    <label for="coorName">Name:</label>
                    <input type="text" class="form-control" name="coorName" value="<%= coorName %>" >
                </div>
                <div class="form-group">
                    <label for="phoneNo">Phone No:</label>
                    <input type="tel" class="form-control" name="phoneNo" pattern="[0-9]{10}" value="<%= phoneNo %>" required>
                    <small class="form-text text-muted">Format: 10 digits only</small>
                </div>
                <div class="form-group">
                    <label for="program">Program:</label>
                    <select class="form-control" name="program">
                        <option value="Physical Chemistry" <%= program.equals("Physical Chemistry") ? "selected" : "" %>>Physical Chemistry</option>
                        <option value="Inorganic Chemistry" <%= program.equals("Inorganic Chemistry") ? "selected" : "" %>>Inorganic Chemistry</option>
                        <option value="Material Chemistry" <%= program.equals("Material Chemistry") ? "selected" : "" %>>Material Chemistry</option>
                        <option value="Organic Chemistry" <%= program.equals("Organic Chemistry") ? "selected" : "" %>>Organic Chemistry</option>
                        <!-- Add more options as needed -->
                    </select>
                </div>
                <div class="form-group">
                    <label for="email">Email:</label>
                    <input type="email" class="form-control" name="email" pattern="[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}" value="<%= email %>" required>
                    <small class="form-text text-muted">Format: user@example.com</small>
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
                        response.sendRedirect("CoorDetails.jsp");
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                    response.sendRedirect("CoorDetails.jsp");
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
