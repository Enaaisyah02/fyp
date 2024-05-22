<%-- 
    Document   : doRegisterStu
    Created on : 1 Jan 2024, 1:36:00 pm
    Author     : ainan
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>process register coordinator</title>
        <style>
             .success-message {
            color: #28a745; /* Green color for success message */
            font-size: 18px;
            margin-top: 20px;
            text-align: center;
        }

        .details-container {
            max-width: 600px;
            margin: 20px auto; /* Adjust margin as needed */
        }

        .record-details {
            background-color: #f8f9fa; /* Light gray background for details */
            padding: 15px;
            border-radius: 8px;
            margin-top: 20px;
        }

        .record-details p {
            margin: 10px 0;
            font-size: 16px;
        }

        .record-details strong {
            font-weight: bold;
        }
        </style>

    </head>
    <body>



        <div class="container">
            <%
                int result;
                boolean isStudentIdTaken = false;
                Class.forName("com.mysql.jdbc.Driver");
                String myURL = "jdbc:mysql://localhost:3306/myfyp";
                Connection conn = DriverManager.getConnection(myURL, "root", "admin");


                // Check if coordinatorID already exists
                String sCheckQuery = "SELECT COUNT(*) FROM student WHERE stuId = ?";
                PreparedStatement checkPS = conn.prepareStatement(sCheckQuery);
                checkPS.setString(1, request.getParameter("stuId")); // Using request.getParameter to get form data
                ResultSet checkRS = checkPS.executeQuery();
                if (checkRS.next()) {
                    int count = checkRS.getInt(1);
                    if (count > 0) {
                        isStudentIdTaken = true; // stu ID already taken
                    }
                }

                if (!isStudentIdTaken) {
                    //  Stu ID is not taken, proceed with insert
                    String sInsertQry = "INSERT INTO student(stuId, stuName, phoneNo, program, semester, courseCode, email, password) VALUES (?,?,?,?,?,?,?,?)";
                    PreparedStatement myPS = conn.prepareStatement(sInsertQry);
                    myPS.setString(1, request.getParameter("stuId"));
                    myPS.setString(2, request.getParameter("stuName"));
                    myPS.setString(3, request.getParameter("phoneNo"));
                    myPS.setString(4, request.getParameter("program"));
                    myPS.setString(5, request.getParameter("semester")); 
                    myPS.setString(6, request.getParameter("courseCode"));
                    myPS.setString(7, request.getParameter("email"));
                    myPS.setString(8, request.getParameter("password"));

                    result = myPS.executeUpdate();
                    if (result > 0) {
            %>
            <p class="success-message">Record successfully </p>

            <div class="details-container">
                <div class="record-details">
                    <p><strong>Record Details:</strong></p>
                    <p><strong>Student ID:</strong> <%= request.getParameter("stuId")%></p>
                    <p><strong>Student Name:</strong> <%= request.getParameter("stuName")%></p>
                    <p><strong>Phone No:</strong> <%= request.getParameter("phoneNo")%></p>
                    <p><strong>Program:</strong> <%= request.getParameter("program")%></p>
                    <p><strong>Semester:</strong> <%= request.getParameter("semester")%></p>
                    <p><strong>Course Code:</strong> <%= request.getParameter("courseCode")%></p>
                    <p><strong>Email:</strong> <%= request.getParameter("email")%></p>
                </div>
                <p>Account already registered. </p>
                <a href="LoginUser.jsp">
                    <button id="loginBtn" type="button" class="btn">Go to Login Page</button>
                </a>
                <%
                     }
                 }

                 if (isStudentIdTaken) {
                %>
                <p class="error-message">Error: Student ID already taken!</p>
                <p>Please Register Again! <a href="stuRegister.jsp">Register Again</a>.</p>
                <%
                    }

                    conn.close();
                %>
            </div>
            <jsp:include page="footer.jsp" />
    </body>
</html>