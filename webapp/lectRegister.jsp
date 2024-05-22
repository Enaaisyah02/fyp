<%-- 
    Document   : lectRegister
    Created on : 22 Dec 2023, 5:03:10 pm
    Author     : ainan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page session="true"%>
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

                    <c:if test="${lecturer != null}">
                        <form action="lectServlet" method="post">
                            <input type="hidden" name="action" value="lectupdate">
                        </c:if>

                        <c:if test="${lecturer == null}">
                            <form action="lectServlet" method="post">
                                <input type="hidden" name="action" value="lectinsert">
                            </c:if> 

                            <h2>
                                <c:if test="${lecturer == null}">
                                    Add Lecturer 
                                </c:if>
                                <c:if test="${lecturer != null}">
                                    Update Lecturer Form
                                </c:if>
                            </h2> 
                            <br><br>
                            <c:if test="${lecturer != null}">
                                <input type="hidden" name="lectId" value="<c:out value='${lecturer.lectId}'/>" />
                            </c:if> 
                            <c:if test="${lecturer == null}">
                                <fieldset class="form-group">
                                    <label> Lecturer ID</label>
                                    <input type="text" value="<c:out value='${lecturer.lectId}'/>"
                                           class="form-control" name="lectId" placeholder="Enter lecturer ID" required="required">
                                </c:if> 
                            </fieldset>
                            <fieldset class="form-group">
                                <label> Lecturer Name</label>
                                <input type="text" value="<c:out value='${lecturer.lectName}'/>"
                                       class="form-control" name="lectName" placeholder="Enter lecturer name" required="required">
                            </fieldset>
                            <fieldset class="form-group">
                                <label> Phone Number</label>
                                <input type="text" value="<c:out value='${lecturer.phoneNo}'/>"
                                       class="form-control" name="phoneNo" placeholder="Enter lecturer's phone no">
                            </fieldset>  
                            <fieldset class="form-group">
                                <label for="program">Program:</label>
                                <select id="program" name="program" required>
                                    <option value="">Select Reference Field</option>
                                    <c:choose>
                                        <c:when test="${lecturer.program eq 'Physical Chemistry'}">
                                            <option value ="Physical Chemistry" selected>Physical Chemistry</option>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="Physical Chemistry"> Physical Chemistry</option>
                                        </c:otherwise>
                                    </c:choose>
                                    <c:choose>
                                        <c:when test="${lecturer.program eq 'Inorganic Chemistry'}">
                                            <option value ="Inorganic Chemistry" selected>Inorganic Chemistry</option>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="Inorganic Chemistry"> Inorganic Chemistry</option>
                                        </c:otherwise>
                                    </c:choose>
                                    <c:choose>
                                        <c:when test="${lecturer.program eq 'Material Chemistry'}">
                                            <option value ="Material Chemistry" selected>Material Chemistry</option>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="Material Chemistry"> Material Chemistry</option>
                                        </c:otherwise>
                                    </c:choose>
                                    <c:choose>
                                        <c:when test="${lecturer.program eq 'Organic Chemistry'}">
                                            <option value ="Organic Chemistry" selected>Organic Chemistry</option>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="Organic Chemistry"> Organic Chemistry</option>
                                        </c:otherwise>
                                    </c:choose>

                                </select>
                            </fieldset>

                            <fieldset class="form-group">
                                <label> Semester </label>
                                <input type="number" value="<c:out value='${lecturer.semester}'/>"
                                       class="form-control" name="semester" placeholder="Enter semester" required min="1">
                            </fieldset>         

                            <fieldset class="form-group">
                                <label> Email </label>
                                <input type="text" value="<c:out value='${lecturer.email}'/>"
                                       class="form-control" name="email" placeholder="Enter lecturer's email">
                            </fieldset>
                            <fieldset class="form-group">
                                <label> Password </label>
                                <input type="text" value="<c:out value='${lecturer.password}'/>"
                                       class="form-control" name="password" placeholder="Enter lecturer's password" style="-webkit-text-security: disc;">
                            </fieldset>


                            <button type="submit" class="btn btn-success">Save</button>

                        </form>
                </div>
            </div>
        </div>
        <jsp:include page="footer.jsp"/>
    </body>
</html>
