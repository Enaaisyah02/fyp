<%-- 
    Document   : titleRegisterSuccess
    Created on : 21 May 2024, 4:57:12 pm
    Author     : ainan
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<jsp:include page="NavStudent.jsp" />
<title>Project Registration Success</title>
<style>
    body {
        font-family: 'Arial', sans-serif;
        background-color: #f4f4f4;
        margin: 0;
        padding: 20px;
    }

    .container {
        width: 50%;
        margin: 50px auto;
        background-color: #fff;
        padding: 20px;
        border-radius: 10px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        text-align: center;
    }

    h2 {
        color: #333;
    }

    p {
        font-size: 1.2em;
    }

    a {
        text-decoration: none;
        color: #4caf50;
        font-weight: bold;
    }
</style>
</head>
<body>
<div class="container">
    <h2>Project Registration Success</h2>
    <p>Your project title has been successfully registered! Please wait for coordinator approval</p>
    <p><a href="displayTitleInfo.jsp">View Your Project Titles</a></p>
</div>
    <jsp:include page="footer.jsp" />
</body>
</html>
