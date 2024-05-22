<%-- 
    Document   : Login
    Created on : 19 Dec 2023, 11:40:02 pm
    Author     : ainan
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@page session="true"%>


<span style="font-family: verdana, geneva, sans-serif;"> 
    <!DOCTYPE html>
    <html>
        <head>
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <title>Login Page</title>
            <jsp:include page="bootstrap.jsp"/>

            <script src="https://kit.fontawesome.com/3290ed9e01.js" crossorigin="anonymous"></script>

            <style>

                body{
                    display: flex;
                    justify-content: center;
                    align-items: center;
                    min-height: 100vh;
                    background-image: linear-gradient(rgba(0,0,50,0.8),rgba(0,0,50,0.8)), url('https://fssm.umt.edu.my/wp-content/uploads/2020/04/FSSM-Building.jpg');
                    background-position: center;
                    background-size: cover;
                    position: relative;
                }

                .container{
                    width: 100%;
                    display: flex;
                    max-width: 900px;
                    background: #fff;
                    border-radius: 15px;
                    box-shadow: 0 10px 15px rgba(0, 0, 0, 0.1);
                }

                .login{
                    width: 400px;
                }
                form{
                    width: 250px;
                    margin: 60px auto;
                }
                h1{
                    margin: 20px;
                    text-align: center;
                    font-weight: bolder;
                    text-transform: uppercase;
                }
                p{
                    text-align: center;
                    margin: 10px;
                }
                hr{
                    border-top: 2px solid blue;
                }
                .pic {
                    width: 400px; /* Set a specific width for the container */
                    height: 100%; /* Allow the height to adjust automatically */
                    display: flex;
                    justify-content: center;
                    align-items: center;
                }

                .pic img {
                    max-width: 100%; /* Set a maximum width for the image */
                    max-height: 100%; /* Set a maximum height for the image */
                    width: auto;
                    height: auto;
                    object-fit: contain; /* Ensure the image fits within the container without zooming */
                    border-top-right-radius: 30px;
                    border-bottom-right-radius: 15px;
                    margin-top: 40%;
                    margin-left:-10%;
                }

                form label{
                    display: block;
                    font-size: 16px;
                    font-weight: 600;
                    padding: 5px;
                }
                input{
                    width: 100%;
                    margin: 2px;
                    border: none;
                    outline: none;
                    padding: 8px;
                    border-radius: 5px;
                    border: 1px solid gray;
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
                    background-color: blue;
                }
                button:hover{
                    background: rgba(64, 86, 214, 1);
                }
                p{
                    margin: 20px;
                }
                a{
                    color: black;
                    text-decoration: none;
                }
                </span>

            </style>
        </head>
        <body>


            <div class="container">
                <div class="login">
                    <form action="doLogin.jsp" method="post">
                        <h1>Login</h1>
                        <hr>
                        <i class="fa-solid fa-user"></i>
                        <input type="text" placeholder="Enter ID" name="Id" required>

                        <i class="fa-solid fa-lock"></i>
                        <input type="password" placeholder="Enter Password" name="password" required>
                        <button>Submit</button>
                        <p>Forgot Password?<a href="resetPassword.jsp">Click Here!</a></p>
                    </form>

                </div>

                <div class="pic">
                    <img src="https://cdn035.yun-img.com/static/upload/mlx/visualtoolkit/20201112181917_76399.jpg">
                </div>
            </div>
            <%
     String userId = request.getParameter("Id");
     session.setAttribute("userId", userId);
    
            %>

            <jsp:include page="footer.jsp" />

        </body>
    </html>
