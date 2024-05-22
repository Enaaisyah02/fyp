<%-- 
    Document   : doTitleApproval
    Created on : 21 May 2024, 3:15:52 pm
    Author     : ainan
--%>

<%@ page import="java.sql.*" %>
<%@ page import="java.io.*,java.util.*" %>
<%@ page import="javax.servlet.*,javax.servlet.http.*" %>

<%
String formId = request.getParameter("formId");
String approval = request.getParameter("approval");

String errorMessage = null;

try {
    Class.forName("com.mysql.jdbc.Driver");
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/myfyp", "root", "admin");

    if (approval.equals("Rejected")) {
        // Delete the project title data if it is rejected
        PreparedStatement deleteStmt = conn.prepareStatement("DELETE FROM projecttitle WHERE formId = ?");
        deleteStmt.setString(1, formId);
        int deleteRowsAffected = deleteStmt.executeUpdate();
        deleteStmt.close();

        if (deleteRowsAffected > 0) {
            // Redirect to coordinator approval page
            response.sendRedirect("coorTitleApproval.jsp");
            conn.close();
            return;
        } else {
            errorMessage = "Failed to delete project title data. Please try again.";
        }
    } else {
        // Update the status if it is Approved
        PreparedStatement updateStmt = conn.prepareStatement("UPDATE projecttitle SET status = ? WHERE formId = ?");
        updateStmt.setString(1, approval);
        updateStmt.setString(2, formId);

        int updateRowsAffected = updateStmt.executeUpdate();
        updateStmt.close();

        if (updateRowsAffected > 0) {
            // Redirect to coordinator approval page
            response.sendRedirect("coorTitleApproval.jsp");
            conn.close();
            return;
        } else {
            errorMessage = "Failed to update project status. Please try again.";
        }
    }

    conn.close();
} catch (Exception e) {
    e.printStackTrace();
    errorMessage = "An error occurred while processing your request.";
}

if (errorMessage != null) {
    request.setAttribute("errorMessage", errorMessage);
    request.getRequestDispatcher("coorTitleApproval.jsp").forward(request, response);
}
%>
