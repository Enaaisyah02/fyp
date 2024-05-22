<%-- 
    Document   : doRegisterCoor
    Created on : 21 Dec 2023, 11:40:21 pm
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
            /* Reset some default styles */
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
                margin: 0;
                padding: 0;
            }

            /* Container for the form */
            .container {
                max-width: 600px;
                margin: 50px auto;
                background-color: #fff;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }

            /* Center the form heading */
            h2 {
                text-align: center;
                margin-bottom: 20px;
            }

            /* Style form labels and input elements */
            .form-group {
                margin-bottom: 15px;
            }

            label {
                display: block;
                font-weight: bold;
                margin-bottom: 5px;
            }

            input[type="text"],
            input[type="email"],
            input[type="password"],
            select,
            input[type="number"] {
                width: 100%;
                padding: 10px;
                border-radius: 5px;
                border: 1px solid #ccc;
                font-size: 16px;
            }

            /* Style the submit button */
            input[type="submit"] {
                padding: 12px 24px;
                background-color: #007bff;
                color: #fff;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                font-size: 16px;
                transition: background-color 0.3s;
            }

            /* Style the submit button on hover */
            input[type="submit"]:hover {
                background-color: #0056b3;
            }

            /* Style the form placeholder text color */
            ::placeholder {
                color: #ccc;
            }
        </style>

    </head>
    <body>
        
        <jsp:include page="NavAdmin.jsp" />
     

        <div class="container">
            <%
                int result;
                boolean isCoordinatorIdTaken = false;
                Class.forName("com.mysql.jdbc.Driver");
                String myURL = "jdbc:mysql://localhost:3306/myfyp";
                Connection cn = DriverManager.getConnection(myURL, "root", "admin");

                // Check if coordinatorID already exists
                String sCheckQuery = "SELECT COUNT(*) FROM coordinator WHERE coorId = ?";
                PreparedStatement checkPS = cn.prepareStatement(sCheckQuery);
                checkPS.setString(1, request.getParameter("coorId")); // Using request.getParameter to get form data
                ResultSet checkRS = checkPS.executeQuery();
                if (checkRS.next()) {
                    int count = checkRS.getInt(1);
                    if (count > 0) {
                        isCoordinatorIdTaken = true; // CoordinatorID already taken
                    }
                }

                if (!isCoordinatorIdTaken) {
                    // CoordinatorID is not taken, proceed with insert
                    String sInsertQry = "INSERT INTO coordinator(coorId, coorName, phoneNo, program, email, password) VALUES (?,?,?,?,?,?)";
                    PreparedStatement myPS = cn.prepareStatement(sInsertQry);
                    myPS.setString(1, request.getParameter("coorId"));
                    myPS.setString(2, request.getParameter("coorName"));
                    myPS.setString(3, request.getParameter("phoneNo"));
                    myPS.setString(4, request.getParameter("program"));
                    myPS.setString(5, request.getParameter("email"));
                    myPS.setString(6, request.getParameter("password"));

                    result = myPS.executeUpdate();
                    if (result > 0) {
            %>
            <p class="success-message">Record successfully added into the Coordinator table!</p>

            <div class="record-details">
                <p><strong>Record Details:</strong></p>
                <p><strong>Coordinator ID:</strong> <%= request.getParameter("coorId")%></p>
                <p><strong>Name:</strong> <%= request.getParameter("coorName")%></p>
                <p><strong>Phone No:</strong> <%= request.getParameter("phoneNo")%></p>
                <p><strong>Program:</strong> <%= request.getParameter("program")%></p>
                <p><strong>Email:</strong> <%= request.getParameter("email")%></p>
            </div>
            <p>Account already registered. </p>
            <%
                    }
                }

                if (isCoordinatorIdTaken) {
            %>
            <p class="error-message">Error: Coordinator ID already taken!</p>
            <p>Please Register Again! <a href="coorRegister.jsp">Register Again</a>.</p>

            <%
                }

                cn.close();
            %>
        </div>

        <jsp:include page="footer.jsp" />
    </body>
</html>