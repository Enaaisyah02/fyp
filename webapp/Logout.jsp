<%-- 
    Document   : Logout
    Created on : 20 Dec 2023, 4:05:11 am
    Author     : ainan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>logout page</title>
    </head>
    <body>
    <body>
        <%
            // Invalidate the session
            session.invalidate();
        %>

        <%-- Redirect to LoginUser.jsp --%>
        <%
            response.sendRedirect("Homepage.jsp");
        %>

    </body>
</html>
