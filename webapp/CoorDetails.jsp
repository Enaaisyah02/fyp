<%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.DriverManager" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Statement" %>
<%@page session="true"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Coordinator Details</title>
    <!-- Add Bootstrap CDN links for styling -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <style>
         .profile-container {
              margin-bottom: 150px;
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

    <jsp:include page="NavCoor.jsp" />

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
                    String Id = (String) session.getAttribute("coorId");

                    if (Id == null || Id.isEmpty()) {
                        response.sendRedirect("LoginUser.jsp");
                    } else {
                        Connection cn = null;
                        try {
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            String myURL = "jdbc:mysql://localhost:3306/myfyp";
                            cn = DriverManager.getConnection(myURL, "root", "admin");
                            Statement myStatement = cn.createStatement();

                            String myQuery = "SELECT * FROM coordinator WHERE coorId = '" + Id + "'";
                            ResultSet myResultSet = myStatement.executeQuery(myQuery);

                            if (myResultSet.next()) {
                %>
                <p><strong>Coordinator ID:</strong> <%= myResultSet.getString(1)%></p>
                <p><strong>Name:</strong> <%= myResultSet.getString(2)%></p>
                <p><strong>Phone No:</strong> <%= myResultSet.getString(3)%></p>
                <p><strong>Program:</strong> <%= myResultSet.getString(4)%></p>
                <p><strong>Email:</strong> <%= myResultSet.getString(5)%></p>
                <div class="action-buttons">
                    <a href="updateProfileCoor.jsp?coorId=<%= myResultSet.getString(1)%>" class="btn btn-primary">Edit Profile</a>
                </div>
                <%
                        } else {
                            out.println("Coordinator's details not found.");
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
    </div>
    <jsp:include page="footer.jsp" />

    <!-- Add Bootstrap JS and Popper.js CDN links at the end of the body for enhanced functionality -->
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js" integrity="sha384-Ml9yNxydI4FbUEnI0hGIBGRsT5fzr1qAcC1T5xmy4e6Q8q2S5IAoo4gBaR8e6hg" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
</body>
</html>
