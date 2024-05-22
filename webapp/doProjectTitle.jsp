<%@ page import="java.sql.*" %>
<%@ page import="java.io.*,java.util.*" %>
<%@ page import="javax.servlet.*,javax.servlet.http.*" %>

<%
// Retrieve form data
String stuId = (String) session.getAttribute("stuId");
String title = request.getParameter("title");
String description = request.getParameter("description");

// Set initial status
String status = "Pending";

// Initialize error message
String errorMessage = null;

// Insert the project title into the database
try {
    // Establish database connection
    Class.forName("com.mysql.jdbc.Driver");
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/myfyp", "root", "admin");

    // Prepare the SQL statement
    PreparedStatement pstmt = conn.prepareStatement("INSERT INTO projecttitle (stuId, title, description, status) VALUES (?, ?, ?, ?)");
    pstmt.setString(1, stuId);
    pstmt.setString(2, title); // Use the title variable directly
    pstmt.setString(3, description); // Use the description variable directly
    pstmt.setString(4, status);

    // Execute the SQL statement
    int rowsAffected = pstmt.executeUpdate();

    // Close the database connection
    pstmt.close();
    conn.close();

    if (rowsAffected > 0) {
        // If insertion succeeds, redirect to the success page
        response.sendRedirect("titleRegisterSuccess.jsp");
    } else {
        // If insertion fails for some reason, set error message
        errorMessage = "Failed to register project title. Please try again.";
    }
} catch (Exception e) {
    // Handle any database errors
    e.printStackTrace(); // Log the exception stack trace
    errorMessage = "An error occurred while processing your request.";
}

if (errorMessage != null) {
    // Forward to projectTitle.jsp with error message
    request.setAttribute("errorMessage", errorMessage);
    request.getRequestDispatcher("projectTitle.jsp").forward(request, response);
}
%>
