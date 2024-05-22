<%-- 
    Document   : NavStudent
    Created on : 25 Dec 2023, 3:46:35 am
    Author     : ainan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Nav Bar Student</title>
        <jsp:include page="bootstrap.jsp" />
        <link rel="stylesheet" type="text/css" href="style.css"> 
        <style>
            body {
                font-family: 'Open San', sans-serif;
                
                background-position: center;
                background-size: cover;
                height: 100vh; /* Set the height to 100% of the viewport height */
                margin: 0; /* Remove default margin to ensure full coverage */
                 background-color: #b0e6f6;
            }
            .topnav {
                background: #0099cc;
                height: 100px;
                display: flex;
                align-items: center;
                justify-content: space-between;
                padding: 0 20px;
            }

            .topnav img {
                width: 200px;
            }

            .topnav ul {
                list-style: none;
                margin: 0;
                padding: 0;
            }

            .topnav ul li {
                display: inline-block;
                margin-right: 20px;
            }

            .topnav ul li:last-child {
                margin-right: 0;
            }

            .topnav ul li a {
                color: white;
                text-decoration: none;
                font-size: 18px;
            }

            .menu-toggle {
                position: fixed;
                top: 33px;
                left: 20px;
                cursor: pointer;
                z-index: 2;
            }

            .bar {
                width: 25px;
                height: 3px;
                background-color: #fff;
                margin: 5px 0;
                transition: 0.4s;
            }

            .bar:nth-child(1) {
                transform-origin: left top;
            }

            .bar:nth-child(2) {
                transform-origin: left center;
            }

            .bar:nth-child(3) {
                transform-origin: left bottom;
            }

            .open .bar:nth-child(1) {
                transform: rotate(45deg) translate(5px, 5px);
            }

            .open .bar:nth-child(2) {
                opacity: 0;
            }

            .open .bar:nth-child(3) {
                transform: rotate(-45deg) translate(5px, -5px);
            }

            .topnav {
                background: #0099cc;
                height: 100px;
                display: flex;
                align-items: center;
                justify-content: space-between;
                padding: 0 20px;
            }

            .topnav img {
                width: 200px;
            }

            .topnav ul {
                list-style: none;
                margin: 0;
                padding: 0;
            }

            .topnav ul li {
                display: inline-block;
                margin-right: 20px;
            }

            .topnav ul li:last-child {
                margin-right: 0;
            }

            .topnav ul li a {
                color: white;
                text-decoration: none;
                font-size: 18px;
            }

            .sidenav {
                height: 100%;
                width: 0; /* Initially hide the side navigation */
                position: fixed;
                z-index: 1;
                top: 0;
                left: 0;
                background-color: #0099cc;
                overflow-x: hidden;
                padding-top: 20px;
                transition: width 0.5s; /* Add transition effect for smoother animation */
            }

            .sidenav.open {
                width: 250px; /* Show the side navigation when it has the "open" class */
            }

            .sidenav ul {
                padding: 50px 0 0; /* Add some padding to the top */
            }

            .sidenav ul li {
                list-style-type: none;
                margin-bottom: 10px;
            }

            .sidenav ul li a {
                display: block;
                padding: 10px;
                color: white;
                text-decoration: none;
            }

            .sidenav ul li a:hover {
                background-color: #999999;
            }
        </style>

    </head>
    <body>

        <nav class="topnav">
           <img src="img/hub1.png" alt="Image" class="img-fluid" style="width: 300px; height: auto;">
            <ul>
                <li><a href="StudentDashboard.jsp">Dashboard</a></li>
                <li><a href="Logout.jsp">Log Out</a></li>
                <!-- Add more navigation links as needed -->
            </ul>
        </nav>

        <!-- Hamburger menu icon for toggling the side navigation -->
        <div class="menu-toggle" onclick="toggleNav()">
            <div class="bar"></div>
            <div class="bar"></div>
            <div class="bar"></div>
        </div>

        <!-- Side navigation -->
        <div id="sidenav" class="sidenav">
            <ul>
                
                 <li><a href="stuDetails.jsp">Profile</a></li>
                 <li><a href="SV.jsp">My Supervisor</a></li>
                <li><a href="<%=request.getContextPath()%>/materiallist">List of FYP Material</a>
                <li><a href="presentationSchedule.jsp">Presentation Schedule</a></li>
                <li><a href="displayTitleInfo.jsp">Project Title </a></li>
                <li><a href="Logout.jsp">Log Out</a></li>
                <!-- Add more navigation links as needed -->
            </ul>
        </div>

        <script>
            function toggleNav() {
                var sidenav = document.getElementById("sidenav");
                sidenav.classList.toggle("open");
            }
        </script>
    </body>
</html>