<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page session="true" %>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Delete Student Registration</title>
    <!-- Include any necessary styles or scripts -->
</head>
<body>
    <jsp:include page="NavCoor.jsp"/>
    <%
        String userId = (String) session.getAttribute("userId");
    %>
    <div>
        <h2>Delete Student Registration</h2>
        <%
            try {
                String jdbcUrl = "jdbc:mysql://localhost:3306/myfyp";
                String dbUser = "root";
                String dbPassword = "admin";

                Connection connection = null;

                Class.forName("com.mysql.cj.jdbc.Driver");
                connection = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);

                String studentId = request.getParameter("stuId");

                String deleteQuery = "DELETE FROM assignsv WHERE stuId = ?";
                PreparedStatement deleteStatement = connection.prepareStatement(deleteQuery);
                deleteStatement.setString(1, studentId);
                
                int rowsAffected = deleteStatement.executeUpdate();

                if (rowsAffected > 0) {
        %>
        <h3>Student registration deleted successfully!</h3>
        <%
                } else {
        %>
        <h3>Error deleting student registration.</h3>
        <%
                }
                connection.close();
            } catch (ClassNotFoundException | SQLException e) {
                e.printStackTrace();
            }
        %>
    </div>
</body>
</html>
