<%-- 
    Document   : FYPMaterialList
    Created on : 25 Mar 2024, 3:02:51 am
    Author     : ainan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page session="true" %>
<!DOCTYPE html>
<html>
    <head>
        <title>FYP Material List</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="path/to/icon-library.css">
        <script src="https://kit.fontawesome.com/3290ed9e01.js" crossorigin="anonymous"></script>
        <jsp:include page="bootstrap.jsp" />
        <style>
            .container {
                max-width: 1000px;
                background-color: white;
            }
        </style>
    </head>
    <body>

        <jsp:include page="NavCoor.jsp"/>

        <br>

        <div class="row">
            <div class="container">
                <br>
                <h3 class="text-center">List of FYP Materials</h3>

                <table class="table table-bordered">
                    <thead>
                        <tr>
                            <th>No</th>
                            <th>Title</th>
                            <th>Material</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="fypmaterial" items="${listFYPMaterial}">
                            <tr>
                                <td><c:out value="${fypmaterial.id}" /></td>
                                <td><c:out value="${fypmaterial.title}" /></td>
                                <td><a href="downloadFile?id=${fypmaterial.id}">Download</a> <c:out value="${fypmaterial.fileDesc}"/></td>
                                <td>
                                <td><a href="materialedit?id=<c:out value='${fypmaterial.id}' />" class="btn btn-primary">Edit</a>
                                    &nbsp;&nbsp;&nbsp;&nbsp;

                                    <a href="materialdelete?id=<c:out value='${fypmaterial.id}' />" class="btn btn-danger" onclick="confirmDelete('<c:out value='${fypmaterial.id}' />')">Delete</a>
                                </td>
                        <a>
                            <td>
                                </tr>
                            </c:forEach>    
                            </tbody>
                            </table>
                            </div>        
                            </div>

                            </body>
                            </html>
