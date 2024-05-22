<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page session="true" %>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>List of Students Registered Under Lecturers</title>
    <!-- Include any necessary styles or scripts -->
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
        }
        .container {
            max-width: 1200px;
            margin: 50px auto;
            padding: 20px;
        }
        h2 {
            text-align: center;
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
        tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        tr:hover {
            background-color: #ddd;
        }
        .header {
            background-color: #4CAF50;
            color: white;
            padding: 10px 0;
            text-align: center;
            margin-bottom: 20px;
        }
        .delete-btn {
            background-color: #f44336;
            color: white;
            border: none;
            padding: 6px 12px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 14px;
            margin: 4px 2px;
            cursor: pointer;
            border-radius: 4px;
        }
        .delete-btn:hover {
            background-color: #d32f2f;
        }
    </style>
</head>
<body>
    <jsp:include page="NavCoor.jsp"/>
    <div class="container">
        <h2>List of Students Registered Under Lecturers</h2>
        <%
            try {
                String jdbcUrl = "jdbc:mysql://localhost:3306/myfyp";
                String dbUser = "root";
                String dbPassword = "admin";

                Connection connection = null;
                ResultSet lecturerResultSet = null;

                Class.forName("com.mysql.cj.jdbc.Driver");
                connection = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);

                String lecturerQuery = "SELECT * FROM lecturer";
                PreparedStatement lecturerStatement = connection.prepareStatement(lecturerQuery);
                lecturerResultSet = lecturerStatement.executeQuery();

                while (lecturerResultSet.next()) {
                    String lecturerId = lecturerResultSet.getString("lectId");
                    String lecturerName = lecturerResultSet.getString("lectName");

        %>
        <div class="lecturer-section">
            <div class="header">Lecturer: <%= lecturerName %> (ID: <%= lecturerId %>)</div>

            <table>
                <thead>
                    <tr>
                        <th>Student ID</th>
                        <th>Student Name</th>
                        <th>Lecturer Name</th>
                        <th>Program</th>
                        <th>Semester</th>
                        <th>Registration Date</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        ResultSet studentResultSet = null;

                        String studentQuery = "SELECT a.*, l.lectName, l.program FROM assignsv a " +
                                               "INNER JOIN lecturer l ON a.lectId = l.lectId " +
                                               "WHERE a.lectId = ?";
                        PreparedStatement studentStatement = connection.prepareStatement(studentQuery);
                        studentStatement.setString(1, lecturerId);
                        studentResultSet = studentStatement.executeQuery();

                        if (!studentResultSet.isBeforeFirst()) {
                    %>
                    <tr>
                        <td colspan="7">No students registered under this lecturer.</td>
                    </tr>
                    <%
                        } else {
                            while (studentResultSet.next()) {
                    %>
                    <tr>
                        <td><%= studentResultSet.getString("stuId") %></td>
                        <td><%= studentResultSet.getString("stuName") %></td>
                        <td><%= studentResultSet.getString("lectName") %></td>
                        <td><%= studentResultSet.getString("program") %></td>
                        <td><%= studentResultSet.getString("semester") %></td>
                        <td><%= studentResultSet.getString("registration_date") %></td>
                        <td><button class="delete-btn" onclick="deleteStudent('<%= studentResultSet.getString("stuId") %>')">Delete</button></td>
                    </tr>
                    <%
                            }
                        }
                        studentResultSet.close();
                    %>
                </tbody>
            </table>
        </div>
        <%
                }
                connection.close();
            } catch (ClassNotFoundException | SQLException e) {
                e.printStackTrace();
            }
        %>
    </div>
    <script>
    function deleteStudent(studentId) {
        if (confirm("Are you sure you want to delete this student?")) {
            // Create a new XMLHttpRequest object
            var xhr = new XMLHttpRequest();
            
            // Configure the request
            xhr.open("POST", "deleteSVstu.jsp", true);
            xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
            
            // Define what happens on successful data submission
            xhr.onload = function() {
                if (xhr.status === 200) {
                    alert("Student registration deleted successfully!");
                    // Reload the page to reflect the changes
                    location.reload();
                } else {
                    alert("Error deleting student registration.");
                }
            };
            
            // Send the request with the student ID as a parameter
            xhr.send("stuId=" + encodeURIComponent(studentId));
        }
    }
</script>

</body>
</html>
