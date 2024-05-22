<%-- 
    Document   : coorRegister
    Created on : 20 Dec 2023, 4:04:18 am
    Author     : ainan
--%>
<%@page session="true"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Register Coordinator</title>
        <jsp:include page="bootstrap.jsp"/>
        <style>

            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
                margin: 0;
                padding: 0;
            }

            .container {
                max-width: 600px;
                margin: 50px auto;
                background-color: #fff;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }

            h2 {
                text-align: center;
                margin-bottom: 20px;
            }

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
            select {
                width: 100%;
                padding: 8px;
                border-radius: 5px;
                border: 1px solid #ccc;
            }

            input[type="submit"] {
                padding: 10px 20px;
                background-color: #9b9bdc;
                color: #fff;
                border: none;
                border-radius: 5px;
                cursor: pointer;
            }

            input[type="submit"]:hover {
                background-color: #0056b3;
            }
        </style>
    </style>

</head>
<body>
   <%  
     String userId = (String) session.getAttribute("userId");
        %>
    <jsp:include page="NavAdmin.jsp"/>
   

    <div class="container">
        <form action="doRegisterCoor.jsp" method="POST">
            <h2>Coordinator's Registration</h2>
            <p>Please fill in all the coordinator's details.</p>

            <div class="form-group">
                <label for="coorId">Coordinator ID:</label>
                <input type="text"  name="coorId" placeholder="Enter ID">
            </div>
             
            <div class="form-group">
                <label for="coorName"> Name:</label>
                <input type="text"  name="coorName"  placeholder="Enter coordinator name" required>
            </div>
            <div class="form-group">
                <label for="phoneNo">Phone No:</label>
                <input type="text"  name="phoneNo" placeholder="Enter your Phone No">
            </div>
            <div class="form-group">
                <label for="program">Reference Field:</label>
                <select name="program">
                    <option value="" disabled selected>Select a program</option>
                    <option value="Physical Chemistry">Physical Chemistry</option>
                    <option value="Inorganic Chemistry">Inorganic Chemistry</option>
                    <option value="Material Chemistry">Material Chemistry</option>
                    <option value="Organic Chemistry">Organic Chemistry</option>
                    <!-- Add more options as needed -->
                </select>
            </div>
            <div class="form-group">
                <label for="email">Email:</label>
                <input type="Email"  name="email"   placeholder="Enter your email" required>
            </div>
            <div class="form-group">
                <label for="password">Password:</label>
                <input type="password"  name="password" placeholder="Enter Password" style="-webkit-text-security: disc;">
            </div>
            <div class="form-group">
                <input type="submit" class="submit-btn" value="Sign Up">
            </div>

        </form>
    </div>

    <jsp:include page="footer.jsp"/>
</body>
</html>
