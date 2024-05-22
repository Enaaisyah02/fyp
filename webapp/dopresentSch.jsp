<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.io., java.util." %>
<%@ page import="com.model.presentSch" %>

<%
// Step 1: Receive form data
Date date = Date.valueOf(request.getParameter("presentationDate"));
String venue = request.getParameter("venue");
String[] lecturersProgramA = request.getParameterValues("lecturersProgramA");
String[] lecturersProgramB = request.getParameterValues("lecturersProgramB");
String[] lecturersProgramC = request.getParameterValues("lecturersProgramC");
String[] lecturersProgramD = request.getParameterValues("lecturersProgramD");

// Step 2: Establish database connection
Connection conn = null;
PreparedStatement pstmt = null;
try {
    // Step 3: Establish database connection
    Class.forName("com.mysql.jdbc.Driver");
    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/myfyp", "root", "admin");
    
    // Step 4: Prepare SQL INSERT statement
    String sql = "INSERT INTO presentsch (groupId, totalPanel, lectId, lectName, stuId, date, venue) VALUES (?, ?, ?, ?, ?, ?, ?)";
    pstmt = conn.prepareStatement(sql);

    // Step 5: Execute INSERT statement for each lecturer
    for (String lectId : lecturersProgramA) {
        pstmt.setNull(1, java.sql.Types.INTEGER); // groupId (auto-generated)
        pstmt.setInt(2, 4); // Assuming totalPanel is fixed as 4 for each group
        pstmt.setString(3, lectId); // lectId
           // Retrieve lecturer name from the database
            String lecturerName = "";
            String lectNameQuery = "SELECT lectName FROM lecturer WHERE lectId = ?";
            PreparedStatement lectNameStmt = conn.prepareStatement(lectNameQuery);
            lectNameStmt.setString(1, lectId);
            rs = lectNameStmt.executeQuery();
            if (rs.next()) {
                lecturerName = rs.getString("lectName");
            }
            pstmt.setString(4, lecturerName); // lectName
            pstmt.setString(5, ""); // stuId (not provided in form)
            pstmt.setDate(6, date); // date
            pstmt.setString(7, venue); // venue
            pstmt.executeUpdate();
        }
    }
    // Similar execution for other programs...

    // Step 6: Close resources
    pstmt.close();
    if (rs != null) rs.close();
    conn.close();
    // Redirect to a success page or provide a response
    response.sendRedirect("success.jsp");
} catch (Exception e) {
    // Handle exceptions
    e.printStackTrace();
    // Redirect to an error page or provide a response
    response.sendRedirect("error.jsp");
} finally {
    // Ensure resources are closed in case of exceptions
    try {
        if (pstmt != null) pstmt.close();
        if (rs != null) rs.close();
        if (conn != null) conn.close();
    } catch (SQLException e) {
        e.printStackTrace();
    }
}
%>