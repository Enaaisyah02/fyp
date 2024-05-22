<%-- 
    Document   : CoordinatorDashboard
    Created on : 21 Dec 2023, 12:34:40 am
    Author     : ainan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page language="java"%>
<%@page session="true"%>


<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Coordinator Dashboard</title>
        <jsp:include page="bootstrap.jsp" />
        <style>
            body, html {
                height: 100%;
                margin: 0;
                overflow: hidden;
                overflow-y: auto; /* Add this line to enable vertical scrolling */
                max-height: 80%;
            }

            .profile-container {
                margin: 20px;
                padding: 20px;
                background-color: #fff;
                border-radius: 5px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }

            /* Style for the profile details */
            .profile-details {
                text-align: center;
                margin-top: 20px;
            }

            .profile-details h2 {
                font-size: 24px;
                color: #333;
            }

            .content {
                position: absolute;
                top: 120%;
                left: 50%;
                transform: translate(-50%, -50%);
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: center;

            }

            .content .cards {
                padding: 20px 15px;
                display: flex;
                align-items: center;
                justify-content: space-around;
                flex-wrap: wrap;
                flex-wrap: nowrap; /* Prevent cards from wrapping to the next line */
                overflow-x: auto;
            }

            .content .cards .card {
                width: 400px;
                height: 300px;
                background: white;
                margin: 10vh 20px;
                display: flex;
                align-items: center;
                justify-content: space-around;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1), 0 4px 10px rgba(0, 0, 0, 0.1);
                transition: transform 0.3s ease-in-out; /* Add transition property */
            }

            .content .cards .card:hover {
                transform: scale(1.05); /* Scale up the card on hover */
            }



            .content .cards .card .icon-design {
                display: flex;
                justify-content: center;
                align-items: center;
            }

            .content .cards .card .icon-design img {
                width: 200px;
                height: 150px;
                position: relative;
            }

            .content .content-ii {
                min-height: 60ch;
                display: flex;
                justify-content: space-around;
                align-items: flex-start;
                flex-wrap: wrap;
            }
            .image-container {
                margin: 20px;
                padding: 20px;
                background-color: #fff;
                border-radius: 5px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }

            .image-container img {
                width: 100%; /* Stretch the image to the left and right */
                height: 300px; /* Maintain aspect ratio */
                display: block;
                margin: auto;
            }


        </style>

    </head>
    <body>
        <%      
     String userId = (String) session.getAttribute("userId");
        %>
        <jsp:include page="NavCoor.jsp" />

        <%
       String coorId = (String) session.getAttribute("coorId");
       String coorName = (String) session.getAttribute("coorName");
       
// Check if session attributes are present
            if (coorId != null && coorName != null) {
                // Display user information on the page
        %>
        <div class="image-container">
            <img src="https://fssm.umt.edu.my/wp-content/uploads/2020/04/FSSM-Building.jpg" alt="">
        </div>
        <div class="profile-container">
            <div class="profile-details">
                <h1>Welcome <%= coorName%>, <%= coorId%></h1>
            </div>
        </div>
        <%
       } else {
           // If session attributes are not present, redirect to the login page
           response.sendRedirect("LoginUser.jsp");
       }
        %>

        <div class="content">
            <div class="cards">
                <a href="CoorDetails.jsp" class="card">
                    <div class="box">
                        <h2>Profile</h2>
                    </div>
                    <div class="icon-design">
                        <img src="https://www.jing.fm/clipimg/full/115-1152777_profile-png-man-user-icon.png" alt="">
                    </div>
                </a>

                <a href="presentSch.jsp" class="card">
                    <div class="box">
                        <h2>Assign Presentation</h2>
                    </div>
                    <div class="icon-design">
                        <img src="https://tse2.mm.bing.net/th?id=OIP.UMKKaeDbjDrTW1NUg9RpsgHaHa&pid=Api&P=0&h=180" alt="">
                    </div>
                </a>

                <a href="assessment.jsp" class="card">
                    <div class="box">
                        <h2>Manage Assessment</h2>
                    </div>
                    <div class="icon-design">
                        <img src="https://icon-library.com/images/assessment-icon-png/assessment-icon-png-6.jpg" alt="">
                    </div>
                </a>
                
                <a href="FYPmaterial.jsp" class="card">
                    <div class="box">
                        <h2>Manage FYP Material</h2>
                    </div>
                    <div class="icon-design">
                        <img src="https://www.iqminds.com/wp-content/uploads/2018/12/Resources.png" alt="">
                    </div>
                </a>
            </div>
            <div class="content-ii">

            </div>
        </div>
        <jsp:include page="footer.jsp" />
    </body>
</html>
