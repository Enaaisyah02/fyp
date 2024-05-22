<%-- 
    Document   : FYPmaterial
    Created on : 23 Mar 2024, 2:17:36 am
    Author     : ainan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page session="true" %>
<!DOCTYPE html>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>

        <jsp:include page="NavCoor.jsp"/>

        <br>
        <div class="container col-md-5">
            <div class="card">
                <div class="card-body">

                    <%  
                         String userId = (String) session.getAttribute("userId");
                    %>

                    <br>
                    <div class="container col-md-5">
                        <div class="card">
                            <div class="card-body"> 
                                <c:choose>
                                    <c:when test="${FYPMaterial == null}">
                                        <form action="materialinsert" method ="post" enctype="multipart/form-data">
                                        </c:when> 
                                        <c:otherwise>
                                            <form action="materialupdate" method="post" enctype="multipart/form-data">
                                                <input type="hidden" name="id" value="<c:out value='${FYPMaterial.id}' />" />
                                            </c:otherwise>
                                        </c:choose>

                                        <caption>
                                            <h2>
                                                <c:choose>
                                                    <c:when test = "${FYPMaterial !=null}">
                                                        Update FYPMaterial
                                                    </c:when>
                                                    <c:otherwise>Add New FYPMaterial</c:otherwise>
                                                </c:choose>
                                            </h2>
                                        </caption>
                                        <fieldset class="form-group">
                                            <label>Title</label><input type="text" value="<c:out value='${FYPMaterial.title}'/>"
                                                                       class="form-control" id="title" name="title" required="required">

                                            <fieldset class="form-group">
                                                <label> Upload File</label><input id="fileDesc" name="fileDesc" type="file">                                                                                
                                            </fieldset>     


                                            <button type="submit" class="btn btn-success">Save</button>
                                    </form>
                            </div>
                        </div>
                    </div> 





                    <jsp:include page="footer.jsp"/>
                    </body>
                    </html>
