<%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.DriverManager" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Statement" %>
<%@page session="true"%>

<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="bootstrap.jsp" />
        <style>
            .profile-container {
                margin: 20px;
                padding: 20px;
                background-color: #fff;
                border-radius: 5px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); /* Added box shadow for a subtle effect */
            }

            /* Style for the profile details */
            .profile-details {
                text-align: center;
                margin-top: 20px;
            }


            .profile-card {
                background-color: #f5f5f5;
                border: 1px solid #ccc;
                border-radius: 10px;
                padding: 20px;
                text-align: center;
                width: 700px;
                margin: 0 auto;
                height: 380px;
            }

            .profile-card h3 {
                font-size: 24px;
                color: #333;
            }

            .profile-card p {
                font-size: 16px;
                margin: 10px 0;
                text-align: left; /* Added this line to left-align the text in <p> elements */
            }


            .action-buttons {
                margin-top: 20px;
            }

            .action-buttons a {
                text-decoration: none;
                background-color: #007bff;
                color: #fff;
                padding: 10px 20px;
                border-radius: 5px;
                font-size: 18px;
            }

            .action-buttons a:hover {
                background-color: #add8ef;
            }
        </style>
    </head>
    <body>
        <%  
            String userId = (String) session.getAttribute("userId");
        %>
        <jsp:include page="NavStudent.jsp" />
        <div class="profile-container">
            <div class="profile-details">
                <h2 style="font-family: 'Arial', sans-serif;
                    color: #333;
                    text-align: center;
                    text-transform: uppercase;
                    letter-spacing: 2px;
                    font-weight: bold;">
                    MY PROFILE
                </h2>
            </div>
        </div>
        <ul class="profile-list">
            <li class="profile-card">
                <%
                    // Get the logged-in user ID
                    String Id = (String) session.getAttribute("stuId");

                    // Check if the logged-in ID is null or empty
                    if (Id == null || Id.isEmpty()) {
                        // If the logged-in ID is not available, redirect to the login page or display an error message
                        response.sendRedirect("LoginUser.jsp");
                        // Or display an error message: out.println("Please log in to view profile details.");
                    } else {
                        Connection cn = null;
                        try {
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            String myURL = "jdbc:mysql://localhost:3306/myfyp";
                            cn = DriverManager.getConnection(myURL, "root", "admin");
                            Statement myStatement = cn.createStatement();

                            String myQuery = "SELECT * FROM student WHERE stuId = '" + Id + "'";
                            ResultSet myResultSet = myStatement.executeQuery(myQuery);

                            if (myResultSet.next()) {
                                // Display the logged-in user's details
                %>

                <p><strong>Student ID:</strong> <%= myResultSet.getString(1)%></p>
                <p><strong>Name:</strong> <%= myResultSet.getString(2)%></p>
                <p><strong>Phone No:</strong> <%= myResultSet.getString(3)%></p>
                <p><strong>Program:</strong> <%= myResultSet.getString(4)%></p>
                <p><strong>Semester:</strong> <%= myResultSet.getString(5)%></p>
                <p><strong>Course Code:</strong> <%= myResultSet.getString(6)%></p>
                <p><strong>Email:</strong> <%= myResultSet.getString(7)%></p>

                <div class="action-buttons">
                    <a href="updateProfileStu.jsp?stuId=<%= myResultSet.getString(1)%>">Edit</a>
                </div>

                <%
                            } else {
                                // Display an error message if the student's details are not found
                                out.println("Student's detail not found.");
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                        } finally {
                            try {
                                if (cn != null) {
                                    cn.close();
                                }
                            } catch (Exception e) {
                                e.printStackTrace();
                            }
                        }
                    }
                %>
            </li>
        </ul>

        <jsp:include page="footer.jsp" />
    </body>
</html>
