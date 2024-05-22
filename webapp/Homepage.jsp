<%-- 
   Document   : Homepage
   Created on : 2 Feb 2024, 3:14:50 pm
   Author     : ainan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Homepage</title>
        <jsp:include page="bootstrap.jsp" />
        <style>
            body {
                font-family: 'Open San', sans-serif;
                background-image: linear-gradient(rgba(0,0,50,0.8),rgba(0,0,50,0.8)), url('https://fssm.umt.edu.my/wp-content/uploads/2020/04/FSSM-Building.jpg');
                background-position: center;
                background-size: cover;
                position: relative;
                height: 100vh; /* Set the height to 100% of the viewport height */
                margin: 0; /* Remove default margin to ensure full coverage */
                background-color: #b0e6f6;
            }

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
            button{
                border: none;
                outline: none;
                padding: 8px;
                width: 252px;
                color: #fff;
                font-size: 16px;
                cursor: pointer;
                margin-top: 20px;
                border-radius: 5px;
                background-color: #0000cc;
                margin-left: 330px;
            }
            button:hover{
                background: rgba(64, 86, 214, 1);
            }

        </style>

    </head>
    <body>
        <nav>
            <img src="img/hub1.png" alt="Image" class="img-fluid">
            <ul>
                <li><a href="Homepage.jsp">Home Page</a></li>
                <li><a href="stuRegister.jsp">Student's Sign Up</a></li>
            </ul>
        </nav>
        <h1 style="font-family: 'Arial', sans-serif;  text-align: center; color: #fff; font-size: 60px; margin-top: 250px; margin-right: 1080px; text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5);text-transform: uppercase;
            letter-spacing: 2px;
            font-weight: bold;">

            Web-based Management System
            <br>
            for Chemical Science
            <br>
            Final Year Project (FYP)

        </h1>
        <a href="LoginUser.jsp">
            <button>Login</button>
        </a>

        <div style="flex: 1; background-color: rgba(255, 255, 255, 0.8); padding: 30px; margin-top: 285px; margin-bottom: 20px; border-radius: 10px; text-align: left; color: black; font-size: 18px;">
    <h2>About Us</h2>
    <p>The Bachelor of Science (Chemistry) program offered by the Faculty of Science and Marine Environment is based on a core foundation that integrates the fields of physical, organic, and inorganic chemistry, as well as cutting-edge chemical materials.
       The program is designed to produce graduates with a broad knowledge of chemistry, possessing a balanced understanding of both theoretical and practical aspects.
       It also aims to cultivate graduates with high-quality leadership, professional ethics, and the ability to contribute expertise in the field of chemistry to the nation in the present and future.</p>
</div>

 <div style="display: flex; justify-content: space-between; padding: 30px; margin-top: 20px;">

    <!-- Left Container for Dean's Message -->
    <div style="flex: 1; background-color: rgba(255, 255, 255, 0.8); padding: 30px; border-radius: 10px; text-align: left; color: black; font-size: 18px; margin-right: 20px;">
        <h2>Dean's Message</h2>
        <img src="img/DM.png" alt="Image" class="img-fluid">
    </div>

    <!-- Right Container for History of FSSM -->
    <div style="flex: 1; background-color: rgba(255, 255, 255, 0.8); padding: 20px; border-radius: 10px; text-align: left; color: black; font-size: 18px; margin-left: 20px;">
        <h2>History of FSSM</h2>
        <img src="img/history.png" alt="Image" class="img-fluid">
    </div>

</div>
        <jsp:include page="footer.jsp" />
    </body>
</html>
