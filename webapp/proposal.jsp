<%-- 
    Document   : proposal
    Created on : 17 May 2024, 5:26:46 pm
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

        <jsp:include page="NavStudent.jsp"/>

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
                                    <c:when test="${proposal == null}">
                                        <form action="proposalinsert" method ="post" enctype="multipart/form-data">
                                            <input type="hidden" name="stuId" value="<%= session.getAttribute("stuId") %>">
                                        </c:when> 
                                        <c:otherwise>
                                            <form action="proposalupdate" method="post" enctype="multipart/form-data">
                                                <input type="hidden" name="id" value="<c:out value='${proposal.id}' />" />
                                            </c:otherwise>
                                        </c:choose>

                                        <caption>
                                            <h2>
                                                <c:choose>
                                                    <c:when test = "${proposal !=null}">
                                                        Update proposal
                                                    </c:when>
                                                    <c:otherwise>Add New proposal</c:otherwise>
                                                </c:choose>
                                            </h2>
                                        </caption>
                                        <fieldset class="form-group">
                                            <fieldset class="form-group">
                                                <label> Upload File</label><input id="proposalDesc" name="proposalDesc" type="file">                                                                                
                                            </fieldset>     


                                            <button type="submit" class="btn btn-success">Save</button>
                                    </form>
                            </div>
                        </div>
                    </div> 
                    <jsp:include page="footer.jsp"/>
                    </body>
                    </html>
