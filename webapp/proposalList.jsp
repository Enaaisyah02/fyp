<%-- 
    Document   : proposalList
    Created on : 17 May 2024, 5:31:12 pm
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

        <jsp:include page="NavStudent.jsp"/>

        <br>

        <div class="row">
            <div class="container">
                <br>
                <h3 class="text-center">List of Student Proposal</h3>

                <table class="table table-bordered">
                    <thead>
                        <tr>
                            <th>No</th>
                            <th>Stu Id</th>
                            <th>Proposal</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="proposal" items="${listproposal}">
                            <tr>
                                <td><c:out value="${proposal.id}" /></td>
                                <td><c:out value="${proposal.stuId}" /></td>
                                <td><a href="downloadFiles?id=${proposal.id}">Download</a> <c:out value="${proposal.proposalDesc}"/></td>
                                <td>
                                <td><a href="proposaledit?id=<c:out value='${proposal.id}' />" class="btn btn-primary">Edit</a>
                                    &nbsp;&nbsp;&nbsp;&nbsp;

                                    <a href="proposaldelete?id=<c:out value='${proposal.id}' />" class="btn btn-danger" onclick="confirmDelete('<c:out value='${proposal.id}' />')">Delete</a>
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

