<%@ page import="java.sql.*, java.util.Date" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page session="true" %>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Submit Lecturer</title>
    <!-- Include any necessary styles or scripts -->
    <script>
       function showError(errorMessage) {
            alert(errorMessage);
            window.location.href = "chooseSV.jsp"; // Redirect to chooseSV.jsp after displaying error
        }
        function showSuccess(successMessage) {
            alert(successMessage);
            window.location.href = "viewSVregister.jsp"; // Redirect to viewSVregister.jsp after displaying success
        }
    </script>
</head>
<body>
    <jsp:include page="NavStudent.jsp"/>
    <%  
        String userId = (String) session.getAttribute("userId");
    %>
    <%
        String selectedLecturerId = request.getParameter("selectedLecturerId");
        String selectedLecturerName = request.getParameter("selectedLecturerName");
        String studentId = (String) session.getAttribute("stuId");
        String studentName = (String) session.getAttribute("stuName");

        String jdbcUrl = "jdbc:mysql://localhost:3306/myfyp";
        String dbUser = "root";
        String dbPassword = "admin";

        Connection connection = null;
        ResultSet resultSet = null; // Declare the ResultSet here

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);

            // Check if the student is already registered with a lecturer
            String checkQuery = "SELECT COUNT(*) AS count FROM assignsv WHERE stuId = ?";
            PreparedStatement checkStatement = connection.prepareStatement(checkQuery);
            checkStatement.setString(1, studentId);
            ResultSet checkResultSet = checkStatement.executeQuery();
            checkResultSet.next();
            int count = checkResultSet.getInt("count");
            if (count > 0) {
    %>
   <script>
        showError("Error: You are already registered with a lecturer");
    </script>
    <%
            } else {
                // Proceed with registration
                // Check if the maximum limit of students per lecturer is reached
                String countQuery = "SELECT COUNT(*) AS studentCount FROM assignsv WHERE lectId = ?";
                PreparedStatement countStatement = connection.prepareStatement(countQuery);
                countStatement.setString(1, selectedLecturerId);
                ResultSet countResultSet = countStatement.executeQuery();
                countResultSet.next();
                int studentCount = countResultSet.getInt("studentCount");
                if (studentCount >= 10) {
    %>
    <script>
        showError("Error: Maximum limit of students per lecturer reached");
    </script>
    <%
                } else {
                    // Proceed with registration
                    String insertQuery = "INSERT INTO assignsv (stuId, stuName, lectId, lectName, semester, registration_date) VALUES (?, ?, ?, ?, ?, ?)";
                    PreparedStatement preparedStatement = connection.prepareStatement(insertQuery);
                    preparedStatement.setString(1, studentId);
                    preparedStatement.setString(2, studentName);
                    preparedStatement.setString(3, selectedLecturerId);
                    preparedStatement.setString(4, selectedLecturerName);
                    preparedStatement.setString(5, "5");  // Replace with the actual semester
                    preparedStatement.setDate(6, new java.sql.Date(new Date().getTime())); // Current date

                    int rowsAffected = preparedStatement.executeUpdate();

                    if (rowsAffected > 0) {
    %>
    <script>
        showSuccess("Registration Successful!");
    </script>
    <%
                    } else {
    %>
   <script>
        showError("Error registering with selected lecturer");
    </script>
    <%
                    }

                    // Retrieve the data for the selected lecturer
                    String retrieveQuery = "SELECT a.*, l.lectName, l.program FROM assignsv a " +
                               "INNER JOIN lecturer l ON a.lectId = l.lectId " +
                               "WHERE a.lectId = ?";
                    PreparedStatement retrieveStatement = connection.prepareStatement(retrieveQuery);
                    retrieveStatement.setString(1, selectedLecturerId);
                    resultSet = retrieveStatement.executeQuery(); // Assign the retrieved ResultSet to the variable

                    // Process the retrieved data if there is any
                    if (resultSet.next()) {
    %>
    <%--<p>Student ID: <%= resultSet.getString("stuId") %></p>
    <p>Student Name: <%= resultSet.getString("stuName") %></p>
    <p>Semester: <%= resultSet.getString("semester") %></p>
    <p>Lecturer ID: <%= resultSet.getString("lectId") %></p>
    <p>Lecturer Name: <%= resultSet.getString("lectName") %></p>
    <p>Program: <%= resultSet.getString("program") %></p>
    <p>Registration Date: <%= resultSet.getString("registration_date") %></p>
    <!-- Add more fields as needed -->--%>
    <%
                    }
                }
            }
        } catch (ClassNotFoundException | SQLException e) {
    %>
    <script>
        showError("Error: <%= e.getMessage() %>");
    </script>
    <%
        } finally {
            try {
                if (resultSet != null) {
                    resultSet.close(); // Close the ResultSet in the finally block
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    %>
</body>
</html>
