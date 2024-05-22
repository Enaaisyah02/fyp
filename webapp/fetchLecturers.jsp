<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>

<%
Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;

try {
    Class.forName("com.mysql.jdbc.Driver");
    String myURL = "jdbc:mysql://localhost:3306/myfyp";
    conn = DriverManager.getConnection(myURL, "root", "admin");

    String query = "SELECT lectId, lectName, program FROM lecturer";
    pstmt = conn.prepareStatement(query);
    rs = pstmt.executeQuery();

    // Prepare HTML table to display lecturer data
    out.println("<table border='1'>");
    out.println("<tr><th>Lecturer ID</th><th>Lecturer Name</th><th>Program</th></tr>");
    while (rs.next()) {
        out.println("<tr>");
        out.println("<td>" + rs.getString("lectId") + "</td>");
        out.println("<td>" + rs.getString("lectName") + "</td>");
        out.println("<td>" + rs.getString("program") + "</td>");
        out.println("</tr>");
    }
    out.println("</table>");
    
} catch (ClassNotFoundException | SQLException e) {
    e.printStackTrace();
} finally {
    // Close database resources
    try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
    try { if (pstmt != null) pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
    try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
}
%>
