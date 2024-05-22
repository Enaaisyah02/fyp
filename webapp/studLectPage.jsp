<%-- 
    Document   : studLectPage
    Created on : 22 Dec 2023, 2:15:44 am
    Author     : ainan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Student & Lecturer Page</title>
        <jsp:include page="bootstrap.jsp" />
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f8f9fa;
                color: #333;
                margin: 0;
                padding: 0;
            }

            .container {
                padding: 20px;
                margin-top: 20px;
                background-color: #fff;
                border-radius: 5px;
                box-shadow: 0px 0px 10px 0px rgba(0, 0, 0, 0.1);
            }

            h2 {
                text-align: center;
                margin-bottom: 20px;
            }

            .row {
                display: flex;
                justify-content: space-between;
                margin-top: 30px;
            }

            .col-md-6 {
                flex: 0 0 48%;
                padding: 20px;
                border-radius: 5px;
                background-color: #f8f9fa;
            }

            h3 {
                font-size: 1.5em;
                margin-bottom: 15px;
            }

            .btn {
                display: block;
                width: 100%;
                margin-bottom: 10px;
            }

            .btn-primary {
                background-color: #007bff;
                border-color: #007bff;
            }

            .btn-secondary {
                background-color: #6c757d;
                border-color: #6c757d;
            }

            .btn-primary:hover,
            .btn-secondary:hover {
                opacity: 0.8;
            }
        </style>
    </head>
    <body>
        
        <jsp:include page="NavCoor.jsp" />
      

        <div class="container">
            <h2>Welcome to Student & Lecturer Page</h2>

            <div class="row">
                <div class="col-md-6">
                    <h3>Lecturer Section</h3>
                    <a href="lectRegister.jsp" class="btn btn-primary">Register Lecturer</a>
                    <a href="lectServlet?action=lectlist" class="btn btn-secondary">List of Lecturers</a>
                </div>

                <div class="col-md-6">
                    <h3>Student Section</h3>
                    <a href="stuList.jsp" class="btn btn-primary">List of Students</a>
                    <a href="studentMarkList.jsp" class="btn btn-secondary">List of Student Marks</a>
                </div>
            </div>
        </div>
         <div class="container">
            <h2>Supervisor & Lecturer</h2>

            <div class="row">
                <div class="col-md-6">
                    <h3>Supervisor & Student Section</h3>
                    <a href="listSVstu.jsp" class="btn btn-primary">List of Supervisor & Student</a>
                </div>
        

        <jsp:include page="footer.jsp" />
    </body>
</html>