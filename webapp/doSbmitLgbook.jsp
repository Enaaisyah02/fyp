<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.text.ParseException" %>

<!DOCTYPE html>
<html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <jsp:include page="bootstrap.jsp" />
        <style>
            <!-- Add your CSS styles here -->
        </style>
    </head>

    <body>
        <%  
            String userId = (String) session.getAttribute("userId");
        %>
        <jsp:include page="NavStudent.jsp" />

        <div class="main-container">
            <div class="form-container">
                <% 
                    
                            String url = "jdbc:mysql://localhost:3306/myfyp";
                            String user = "root";
                            String pass = "admin";
                            
                    PreparedStatement insertPS = null;
                    Connection cn = null;
                    
                    try {
                        // Step 1: Establish a database connection
                        Class.forName("com.mysql.cj.jdbc.Driver");
            cn = DriverManager.getConnection(url, user, pass);
                        
                        String insertQuery = "INSERT INTO logbook (activity, date, status) VALUES (?, ?, ?)";
                        insertPS = cn.prepareStatement(insertQuery);

                      // Step 2: Proceed with insert
                        
                        insertPS.setString(1, request.getParameter("activity"));
                        insertPS.setString(2, request.getParameter("date"));
                        insertPS.setString(3, "pending"); // Set the initial status to pending
                        
                        int result = insertPS.executeUpdate();
                        
                        if (result > 0) {
                %> <p> success</p> <%
                    response.sendRedirect("listLogBook.jsp");
                    } else {
                     response.sendRedirect("submitLogbook.jsp");
                %> <p>error</p><%
                    }
                } catch (SQLException e) {
                e.printStackTrace();
                } finally {
                if (cn != null) {
                try { cn.close(); 
                } catch (SQLException e) {
                e.printStackTrace();
                }
            }
        }
                %>



            </div>
        </div>
        <jsp:include page="footer.jsp" />
    </body>
</html>