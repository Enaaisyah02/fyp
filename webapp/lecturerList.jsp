<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Coordinator List</title>
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
                <h3 class="text-center">List of Lecturer</h3>

                <table class="table table-bordered">
                    <thead>
                        <tr>
                            <th>Lecturer ID</th>
                            <th>Name</th>
                            <th>Phone No</th>
                            <th>Program</th>
                            <th>Semester</th>
                            <th>Email</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="lecturer" items="${listLecturer}">
                            <tr>
                                <td><c:out value="${lecturer.lectId}" /></td>
                                <td><c:out value="${lecturer.lectName}" /></td>
                                <td><c:out value="${lecturer.phoneNo}" /></td>
                                <td><c:out value="${lecturer.program}" /></td>
                                <td><c:out value="${lecturer.semester}" /></td>
                                <td><c:out value="${lecturer.email}" /></td>
                                <td>
                                    <a href="lectServlet?action=lectedit&lectId=<c:out value='${lecturer.lectId}' />">
                                        <i class="fas fa-edit"></i> 
                                    </a>
                                    &nbsp;&nbsp;&nbsp;&nbsp;
                                    <a href="lectServlet?action=lectdelete&lectId=<c:out value='${lecturer.lectId}' />">
                                        <i class="fas fa-trash-alt"></i> 
                                    </a>

                                </td>
                            </tr>
                        </c:forEach>    
                    </tbody>
                </table>
            </div>        
        </div>

    </body>
</html>
