<%-- 
    Document   : LecturerDashboard
    Created on : 23 Dec 2023, 11:52:42 pm
    Author     : ainan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <jsp:include page="bootstrap.jsp" />
        <title>Lecturer Dashboard</title>
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
                width: 400px; /* Adjust the width of the card */
                height: 300px; /* Adjust the height of the card */
                background: white;
                margin: 10vh 20px; /* Adjust the margin to center vertically and add horizontal gap */
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
           String data = (String) session.getAttribute("userId");
        %>
        <jsp:include page="NavLect.jsp" />

        <%
      String lectId = (String) session.getAttribute("lectId");
      String lectName = (String) session.getAttribute("lectName");
        %>
        <div class="image-container">
            <img src="https://fssm.umt.edu.my/wp-content/uploads/2020/04/FSSM-Building.jpg" alt="">
        </div>
        <div class="profile-container">
            <div class="profile-details">
                <h1>Welcome <%= lectName%>, <%= lectId%></h1>
            </div>
        </div>

        <div class="content">
            <div class="cards">
                <a href="lectDetails.jsp" class="card">
                    <div class="box">
                        <h2>Profile</h2>
                    </div>
                    <div class="icon-design">
                        <img src="https://www.jing.fm/clipimg/full/115-1152777_profile-png-man-user-icon.png" alt="">
                    </div>
                </a>

                <a href="" class="card">
                    <div class="box">
                        <h2>Presentation's Assessment</h2>
                    </div>
                    <div class="icon-design">
                        <img src="https://e7.pngegg.com/pngimages/249/113/png-clipart-educational-assessment-evaluation-test-organization-payment-card-industry-data-security-standard-evaluation-symbol-text-logo.png" alt="">
                    </div>
                </a>

                <a href="" class="card">
                    <div class="box">
                        <h2>Student's Assessment</h2>
                    </div>
                    <div class="icon-design">
                        <img src="https://tse4.mm.bing.net/th?id=OIP.FyKiW0_JlTAanAtUdXyPVgHaHa&pid=Api&P=0&h=180" alt="">
                    </div>
                </a>
                <a href="SVstuList.jsp" class="card">
                    <div class="box">
                        <h2>View Students</h2>
                    </div>
                    <div class="icon-design">
                        <img src="https://tse2.mm.bing.net/th?id=OIP.PVCpckGn7OvzE1JeMlFCuAHaHa&pid=Api&P=0&h=180" alt="">
                    </div>
                </a>


            </div>
            <div class="content-ii">

            </div>
        </div>
        <jsp:include page="footer.jsp" />
    </body>
</html>


