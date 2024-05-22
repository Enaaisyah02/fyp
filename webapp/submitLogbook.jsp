<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page session="true" %>
<!DOCTYPE html>
<html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>LOGBOOK </title>
        <jsp:include page="bootstrap.jsp" />
        <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker.min.css" integrity="sha256-FQ4YvsXbfJZIOgg0pC8ZNt3olcSWh3f+5UE+gP46vwQ=" crossorigin="anonymous" />
        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.min.js" integrity="sha256-zNl72+8M9wU37vlsdZDRi+ly6h7FeKO5t0c+7+GONzU=" crossorigin="anonymous"></script>
        <style>
            /* Custom styles */
            body {
                background-color: #f4f4f4;
                font-family: 'Arial', sans-serif;
                margin: 0;
                padding: 0;
            }

            .logbook-container {
                margin: 20px;
                padding: 10px;
                background-color: #fff;
                border-radius: 5px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.2); /* Enhanced shadow */
            }

            /* Style for the profile details */
            .logbook-details {
                text-align: center;
                margin-top: 20px;
            }

            .logbook-details h2 {
                font-size: 24px;
                color: cadetblue;
                font-weight: bold; /* Enhance font weight */
                text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.2); /* Add text shadow for emphasis */
            }



            .form-container {
                width: 1500px;
                max-width: none !important; /* Reset any maximum width */
                background-color: #fff;
                padding: 20px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                text-align: center;
                margin: auto; /* Center the form horizontally */
                border-radius: 8px;
                margin-top: 90px;
            }



            .form-header {
                margin-bottom: 20px;
            }

            .form-group {
                margin-bottom: 20px;
            }

            label {
                font-weight: bold;
            }

            .datepicker,
            .form-control {
                width: 100%;
                padding: 10px;
                border-radius: 4px;
                border: 1px solid #ced4da;
            }

            .form-control:focus {
                border-color: #4b7bec;
                box-shadow: 0 0 0 0.2rem rgba(75, 123, 236, 0.25);
            }

            .submit-btn {
                background-color: #4caf50;
                color: white;
                cursor: pointer;
                padding: 10px;
                border: none;
                border-radius: 4px;
            }

            .submit-btn:hover {
                background-color: #45a049;
            }

            .form-control[name="activity"] {
                width: 100%;
                height: 200px;
                padding: 10px;
                border-radius: 4px;
                border: 1px solid #ced4da;
            }

            .form-control[name="activity"]:focus {
                border-color: #4b7bec;
                box-shadow: 0 0 0 0.2rem rgba(75, 123, 236, 0.25);
            }
        </style>
    </head>

    <body>
        <%  
      String userId = (String) session.getAttribute("userId");
        %>
        <jsp:include page="NavStudent.jsp" />

        <br>
        <div class="container col-md-5">
            <div class="card">
                <div class="card-body"> 
                    <c:choose>
                        <c:when test="${logbook == null}">
                            <form action="loginsert" method ="post" enctype="multipart/form-data">
                                <input type="hidden" name="stuId" value="<%= session.getAttribute("stuId") %>">
                            </c:when> 
                            <c:otherwise>
                                <form action="logupdate" method="post" enctype="multipart/form-data">
                                    <input type="hidden" name="logbookId" value="<c:out value='${logbook.logbookId}' />" />
                                </c:otherwise>
                            </c:choose>

                            <caption>
                                <h2>
                                    <c:choose>
                                        <c:when test = "${logbook !=null}">
                                            Update logbook
                                        </c:when>
                                        <c:otherwise>Add New Logbook</c:otherwise>
                                    </c:choose>
                                </h2>
                            </caption>
                            <fieldset class="form-group">
                                <label>Activity</label><input type="text" value="<c:out value='${logbook.activity}'/>"
                                                              class="form-control" name="activity" required="required">
                            </fieldset>
                            <fieldset class="form-group">
                                <label>Problem</label><input type="text" value="<c:out value='${logbook.problem}'/>"
                                                             class="form-control" name="problem" required="required">
                            </fieldset>
                            <fieldset class="form-group">
                                <label>Solution</label><input type="text" value="<c:out value='${logbook.solution}'/>"
                                                              class="form-control" name="solution" required="required">
                            </fieldset>
                            <fieldset class="form-group">
                                <label>Date </label><input type="date" placeholder="Choose you date" value="<c:out value='${logbook.date}'/>"
                                                           class="form-control" name="date">
                            </fieldset>
                            <fieldset class="form-group">
                                <label>Proof</label><input type="file" class="form-control" name="imgExp" id="imgExp">
                            </fieldset>


                            <button type="submit" class="btn btn-success">Save</button>
                        </form>
                </div>
            </div>
        </div>

        <jsp:include page="footer.jsp" />
    </body>

</html>
