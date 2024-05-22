<%@ page import="java.sql.*, java.util.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page session="true" %>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>View Registered Students</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
        }

        .container {
            max-width: 800px;
            margin: 20px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        .header-container {
            background-color: #f2f2f2;
            padding: 20px;
            border-radius: 5px;
            margin-bottom: 20px;
        }

        h2 {
            text-align: center;
            margin-bottom: 20px;
        }

        table {
            width: 100%;
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

        tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        tr:nth-child(odd) {
            background-color: #e0e0e0;
        }

        .view-button {
            background-color: #4CAF50;
            border: none;
            color: white;
            padding: 8px 16px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 14px;
            border-radius: 5px;
            cursor: pointer;
        }

        .view-button:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
    <jsp:include page="NavLect.jsp" />
    <%  
        String lectId = (String) session.getAttribute("lectId");
        String lectName = (String) session.getAttribute("lectName");
    %>
    <div class="container">
        <div class="header-container">
            <h2>Students Registered Under You - <%= lectName %></h2>
        </div>
        <table>
            <tr>
                <th>Student ID</th>
                <th>Student Name</th>
                <th>Registration Date</th>
                <th>Actions</th> <!-- Added column for actions -->
            </tr>
            <%  
                String jdbcUrl = "jdbc:mysql://localhost:3306/myfyp";
                String dbUser = "root";
                String dbPassword = "admin";

                Connection connection = null;

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    connection = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);

                    String selectQuery = "SELECT * FROM assignsv WHERE lectId = ?";
                    PreparedStatement preparedStatement = connection.prepareStatement(selectQuery);
                    preparedStatement.setString(1, lectId);
                    ResultSet resultSet = preparedStatement.executeQuery();

                    while (resultSet.next()) {
            %>
            <tr>
                <td><%= resultSet.getString("stuId") %></td>
                <td><%= resultSet.getString("stuName") %></td>
                <td><%= resultSet.getDate("registration_date") %></td>
                <td>
                    <form action="ViewLectStu.jsp" method="GET"> <!-- Form to submit student ID to details page -->
                        <input type="hidden" name="stuId" value="<%= resultSet.getString("stuId") %>">
                        <button type="submit" class="view-button">View</button>
                    </form>
                </td>
            </tr>
            <% 
                    }
                } catch (ClassNotFoundException | SQLException e) {
                    e.printStackTrace();
                } finally {
                    try {
                        if (connection != null) {
                            connection.close();
                        }
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            %>
        </table>
    </div>
</body>
</html>
