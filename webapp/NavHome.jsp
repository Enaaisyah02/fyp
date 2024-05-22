<%-- 
    Document   : NavHome
    Created on : 3 Feb 2024, 2:48:31 am
    Author     : ainan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Nav Home</title>
        <jsp:include page="bootstrap.jsp" />
          <style>
            

            *{
                margin: 0;
                padding: 0;
                list-style: none;
                text-decoration: none;
            }
            nav{
                height: 100px;
                background: #0099cc;

            }
            nav img{
                width: 350px;
                position: absolute;
                top: 30ps;
                left: 1%;
                margin-top: -132px;
            }
            nav ul{
                float: right;
                margin-right: 40px;
            }
            nav ul li{
                display: inline-block;
                line-height: 95px;
                margin: 0 25px;
            }
            nav ul li a{
                position: relative;
                color: black;
                font-size: 18px;
                padding: 5px 0;
                text-transform: uppercase;
            }
            nav ul li a:before{
                position: absolute;
                content: '';
                left: 0;
                bottom: 0;
                height: 3px;
                width: 100%;
                background: black;
                transform: scaleX(0);
                transform-origin: right;
                transition: transform .4s linear;
            }
            nav ul li a:hover:before{
                transform: scaleX(1);
                transform-origin: left;
            }

        </style>

    </head>
    <body>
        <nav>
            <img src="img/hub1.png" alt="Image" class="img-fluid">
            <ul>
                <li><a href="Homepage.jsp">Home</a></li>
                
            </ul>
        </nav>

    </body>
</html>
