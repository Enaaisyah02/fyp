<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>

<%
    // Retrieve parameters from the form
    String logbookId = request.getParameter("logbookId");
    String activity = request.getParameter("activity");
    String problem = request.getParameter("problem");
    String solution = request.getParameter("solution");
    String dateStr = request.getParameter("date");
    Part imgPart = request.getPart("imgExp");

    // Convert date string to java.sql.Date
    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
    Date date = null;
    try {
        date = new Date(dateFormat.parse(dateStr).getTime());
    } catch (ParseException e) {
        e.printStackTrace();
    }

    // Update the logbook entry in the database
    Connection connection = null;
    PreparedStatement preparedStatement = null;

    try {
        // Establish database connection
        connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/myfyp", "root", "admin");

        // Prepare the SQL statement
        String sql = "UPDATE logbook SET activity=?, problem=?, solution=?, date=?, imgExp=? WHERE logbookId=?";
        preparedStatement = connection.prepareStatement(sql);
        preparedStatement.setString(1, activity);
        preparedStatement.setString(2, problem);
        preparedStatement.setString(3, solution);
        preparedStatement.setDate(4, date);
        preparedStatement.setBinaryStream(5, imgPart.getInputStream());
        preparedStatement.setString(6, logbookId);

        // Execute the update
        int rowsAffected = preparedStatement.executeUpdate();

        // Redirect to the appropriate page based on the outcome
        if (rowsAffected > 0) {
            response.sendRedirect("listLogBook.jsp");
        } else {
            response.sendRedirect("editLogbook.jsp?logbookId=" + logbookId);
        }
    } catch (SQLException | IOException | ServletException e) {
        e.printStackTrace();
        response.sendRedirect("editLogbook.jsp?logbookId=" + logbookId);
    } finally {
        // Close resources
        if (preparedStatement != null) {
            try {
                preparedStatement.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        if (connection != null) {
            try {
                connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
%>
