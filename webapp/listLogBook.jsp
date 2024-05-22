<%-- 
    Document   : listLogBook
    Created on : 10 Jan 2024, 1:18:05 pm
    Author     : ainan
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page session="true"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
    <head>
        <jsp:include page="bootstrap.jsp" />
        <title>List of Coordinators</title>
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
                background-color: #ccccff;
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
            .btnEdit {
                height: 50px;
                width: 100px;
                background-color: #ccccff;
                position: relative;
                color: black;
                border: none;
                text-align: center;
                margin-bottom: 20px;
                border-radius: 5px;
                cursor: pointer;
                transition: background-color 0.3s;
            }
            .btnEdit:hover {
                background-color:#0056b3;
            }
        </style>
    </head>
    <body>
        <%  
      String userId = (String) session.getAttribute("userId");
        %>
       
        <jsp:include page="NavStudent.jsp" />


        <div class="container">
            <table class="styled-table">
                <thead>
                    <tr>
                        <th>No</th>
                        <th>STUDENT ID</th>
                        <th>ACTIVITY</th>
                        <th>PROBLEM</th>
                        <th>SOLUTION</th>
                        <th>DATE</th>
                        <th>PROOF</th>
                        <th>Action</th>
                    </tr>
                </thead>

                <tbody>
                    <c:forEach var="logbook" items="${listOfLogbook}">
                        <tr>
                            <td>
                                <c:out value="${logbook.logbookId}" />
                            </td>
                            <td>
                                <c:out value="${logbook.stuId}" />
                            </td>
                            <td>
                                <c:out value="${logbook.activity}" />
                            </td>
                            <td>
                                <c:out value="${logbook.problem}" />
                            </td>
                            <td>
                                <c:out value="${logbook.solution}" />
                            </td>
                            <td>
                                <c:out value="${logbook.date}" />
                            </td>
                            <td>
                                <img src="data:image/jpeg;base64,${logbook.imgExp}" alt="Proof Image" />
                            </td>
                            <td>
                            <td><a href="logedit?logbookId=<c:out value='${logbook.logbookId}' />" class="btn btn-primary">Edit</a>
                                &nbsp;&nbsp;&nbsp;&nbsp;
                               
                                
                                <a href="#" class="btn btn-danger" onclick="confirmDelete('<c:out value='${logbook.logbookId}' />')">Delete</a>
                            </td>

                        </tr>
                    </c:forEach>    
                </tbody>
            </table>
        </div>
        <jsp:include page="footer.jsp" />
        
        <script>
                                        // JavaScript function to display a confirmation dialog
                                        function confirmDelete(logbookId) {
                                            var result = confirm("Are you sure you want to delete this product?");
                                            if (result) {
                                                // If the user confirms, redirect to the delete URL
                                                window.location.href = "logdelete?logbookId=" + logbookId;
                                            }
                                        }
                                    </script>
    </body>
</html>
v