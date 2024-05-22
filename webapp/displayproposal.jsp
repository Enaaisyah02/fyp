<%-- 
    Document   : displayproposal
    Created on : 18 May 2024, 12:52:52 am
    Author     : ainan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page session="true"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <jsp:include page="bootstrap.jsp" />
        <style>
            body, html {
                height: 100%;
                margin: 0;
                overflow: hidden;
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
                top: 80%;
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
            }

            .content .cards .card {
                width: 400px; /* Adjust the width of the card */
                height: 300px; /* Adjust the height of the card */
                background: white;
                margin: 10vh 20px; /* Adjust the margin to center vertically and add horizontal gap */
                display: flex;
                align-items: center;
                justify-content: space-around;
                box-shadow: 0 2px 4px 0 rgba(0, 0, 0, 0.1), 0 4px 10px 0 rgba(0, 0, 0, 0.1);
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

        </style>

    </head>
    <body>
        <%  
               String userId = (String) session.getAttribute("userId");
        %>
        <jsp:include page="NavStudent.jsp" />

        <div class="profile-container">
            <div class="profile-details">
                <h1>Log Book Progress</h1>
            </div>
        </div>
        <div class="content">
            <div class="cards">
                <a href="proposal.jsp" class="card">
                    <div class="box">
                        <h2> Upload Proposal</h2>
                    </div>
                    <div class="icon-design">
                        <img src="https://static.thenounproject.com/png/155458-200.png" alt="">
                    </div>
                </a>

                <a href="<%=request.getContextPath()%>/loglist" class="card">
                    <div class="box">
                        <h2></h2>
                    </div>
                    <div class="icon-design">
                        <img src="https://pluspng.com/img-png/to-do-list-png-checklist-icon-checklist-icon-png-list-icon-image-1429-1200.png" alt="">
                    </div>
                </a>
            </div>
            <div class="content-ii">

            </div>
        </div>
        <jsp:include page="footer.jsp" />
    </body>
</html>
