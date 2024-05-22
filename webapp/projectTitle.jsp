<%@ page import="java.sql.*" %>
<%@page session="true"%>
<html>
    <head>
        <title>Project Registration</title>
        <style>
            body {
                font-family: 'Arial', sans-serif;
                background-color: #f4f4f4;
                margin: 0;
                padding: 0;
            }

            .container {
                width: 50%;
                margin: 50px auto;
                background-color: #fff;
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }

            form {
                display: flex;
                flex-direction: column;
            }

            label {
                margin-bottom: 10px;
            }

            input[type="text"],
            input[type="file"],
            input[type="submit"] {
                margin-bottom: 15px;
                padding: 10px;
                border: 1px solid #ccc;
                border-radius: 5px;
                font-size: 16px;
            }

            input[type="submit"] {
                background-color: #4caf50;
                color: white;
                cursor: pointer;
            }

            input[type="submit"]:hover {
                background-color: #45a049;
            }

            p.error-message {
                color: red;
                margin-top: 10px;
            }
            .student-info-container {
                display: flex;
                justify-content: center;
                margin-top: 20px;
            }

            .student-info-card {
                background-color: #fff;
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                text-align: center;
            }

            .student-info-card h2 {
                margin: 0;
                font-size: 1.5em;
                color: #333;
            }

        </style>
    </head>
    <body>
        <%  
            String userId = (String) session.getAttribute("userId");
        %>
        <jsp:include page="NavStudent.jsp" />
        <div class="student-info-container">
            <div class="student-info-card">
                <h2><%= session.getAttribute("stuName") %> (ID: <%= session.getAttribute("stuId") %>)</h2>
            </div>
        </div>


        <!-- Project Registration Form -->
        <div class="container">
            <h3>Project Registration Form</h3>
            <form action="doProjectTitle.jsp" method="post">
               <input type="hidden" name="stuId" value="<%= session.getAttribute("stuId") %>">
                <label for="title">Title:</label><br>
                <input type="text"  name="title"><br>
                <label for="description">Description:</label><br>
                <textarea  name="description"></textarea><br>
                <input type="submit" value="Submit">
            </form>


            <!-- Show an error message if there is any error parameter passed from doProjectTitle.jsp -->
            <% String errorMessage = (String) request.getAttribute("errorMessage"); %>
            <% if (errorMessage != null) { %>
            <p class="error-message"><%= errorMessage %></p>
            <% } %>
        </div>
    </body>
</html>
