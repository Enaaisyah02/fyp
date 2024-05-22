<%-- 
    Document   : stuList
    Created on : 15 Jan 2024, 3:08:34 am
    Author     : ainan
--%>

<%-- Retrieve and display list of coordinators --%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="path/to/icon-library.css">
        <script src="https://kit.fontawesome.com/3290ed9e01.js" crossorigin="anonymous"></script>
        <jsp:include page="bootstrap.jsp" />
        <title>List of Student</title>
        <style>
            .container {
                margin-top: 20px;
            }

            .styled-table {
                width: 100%;
                background-color: #e8e5ee;
                border-collapse: collapse;
                border-radius: 5px;
                overflow: hidden;
            }

            .styled-table th,
            .styled-table td {
                padding: 12px;
                text-align: center;
                border: 1px solid #ddd;
            }

            .styled-table th {
                background-color: #e8e5ee;
                color: #333;
                font-weight: bold;
            }

            .styled-table tr:nth-child(even) {
                background-color: #fafafa;
            }

            .styled-table tr:hover {
                background-color: #f5f5f5;
            }
            th, td {
                padding: 8px;
                text-align: center;
            }
            .btnDelete {
                height: 50px;
                width: 100px;
                background-color: #00ccff;
                position: relative;
                color: black;
                border: none;
                text-align: center;
                margin-bottom: 20px;
                border-radius: 5px;
                cursor: pointer;
                transition: background-color 0.3s;
            }
            .btnDelete:hover {
                background-color:#0056b3;
            }
            
        </style>
    </head>
    <body>

        <jsp:include page="NavCoor.jsp" />


        <div class="container">
            <table class="styled-table">
                <tr>
                    <th>Student ID</th>
                    <th>Name</th>
                    <th>Phone No</th>
                    <th>Program</th>
                    <th>Semester</th>
                    <th>Course Code</th>
                    <th>Email</th>
                    <th>Action</th>
                </tr>

                <%
                    try {
                        Class.forName("com.mysql.jdbc.Driver");
                        String myURL = "jdbc:mysql://localhost:3306/myfyp";
                        Connection cn = DriverManager.getConnection(myURL, "root", "admin");

                        String query = "SELECT * FROM student"; // Fetch all coordinators

                        PreparedStatement ps = cn.prepareStatement(query);
                        ResultSet rs = ps.executeQuery();

                        while (rs.next()) {
                %>
                <tr>
                    <td><%= rs.getString("stuId")%></td>
                    <td><%= rs.getString("stuName")%></td>
                    <td><%= rs.getString("phoneNo")%></td>
                    <td><%= rs.getString("program")%></td>
                    <td><%= rs.getString("semester")%></td>
                    <td><%= rs.getString("courseCode")%></td>
                    <td><%= rs.getString("email")%></td>
                    <td>
                        <form action="deleteStu.jsp" method="POST">
                            <input type="hidden" name="stuId" value="<%= rs.getString("stuId") %>">
                            <button type="submit" class="btnDelete">
                                <i class="fas fa-trash-alt"></i>
                            </button>
                        </form>


                    </td>
                </tr>
                <%
                        }
                        cn.close();
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                %>
            </table>
        </div>
        <jsp:include page="footer.jsp" />
    </body>
</html>
