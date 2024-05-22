<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Base64" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>

<%
    String logbookId = request.getParameter("logbookId");

    // Assuming you have a database connection configured
    Connection cn = null;
    PreparedStatement preparedStatement = null;
    ResultSet resultSet = null;

    try {
        // Fetch the existing details of the logbook entry
        cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/myfyp", "root", "admin");

        String query = "SELECT * FROM logbook WHERE logbookId = ?";
        preparedStatement = cn.prepareStatement(query);
        preparedStatement.setString(1, logbookId);
        resultSet = preparedStatement.executeQuery();

        if (resultSet.next()) {
            // Existing details
            String activity = resultSet.getString("activity");
            String problem = resultSet.getString("problem");
            String solution = resultSet.getString("solution");
            Date date = resultSet.getDate("date");
            byte[] imgExp = resultSet.getBytes("imgExp");
            String base64Image = (imgExp != null) ? Base64.getEncoder().encodeToString(imgExp) : "";

%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Logbook Entry</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>

<h2>Edit Logbook Entry</h2>

<form action="doEditLogbook.jsp" method="POST" enctype="multipart/form-data">
    <input type="hidden" name="logbookId" value="<%= logbookId %>">
    
    <label for="activity">Activity:</label><br>
    <input type="text" id="activity" name="activity" value="<%= activity %>"><br>
    
    <label for="problem">Problem:</label><br>
    <textarea id="problem" name="problem"><%= problem %></textarea><br>
    
    <label for="solution">Solution:</label><br>
    <textarea id="solution" name="solution"><%= solution %></textarea><br>
    
    <label for="date">Date:</label><br>
    <input type="date" id="date" name="date" value="<%= new SimpleDateFormat("yyyy-MM-dd").format(date) %>"><br>
    
    <label for="imgExp">Image:</label><br>
    <%-- Display the existing image if available --%>
    <img src="data:image/jpeg;base64,<%= base64Image %>" alt="Image" style="max-width: 300px;"><br>
    <input type="file" id="imgExp" name="imgExp"><br>
    
    <input type="submit" value="Submit">
</form>

</body>
</html>

<%
        } else {
            // Logbook entry not found
            response.sendRedirect("listLogBook.jsp");
        }
    } catch (SQLException e) {
        e.printStackTrace();
        response.sendRedirect("listLogBook.jsp");
    } finally {
        // Close the database resources
        if (resultSet != null) {
            resultSet.close();
        }
        if (preparedStatement != null) {
            preparedStatement.close();
        }
        if (cn != null) {
            cn.close();
        }
    }
%>
