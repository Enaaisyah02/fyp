<%@ page import="java.io.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@page session="true"%>
<!DOCTYPE html>
<html>

    <body>
        <%
    String Id = request.getParameter("Id");
    String password = request.getParameter("password");

    Connection cn = null;
    PreparedStatement statement = null;
    ResultSet resultSet = null;

    String user = "root";
    String pass = "admin";
    

    try {
        // Validate username and password from the database
        Class.forName("com.mysql.jdbc.Driver");
        cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/myfyp", user, pass);

        // Admin login validation
        String adminQuery = "SELECT * FROM adminn WHERE adminId = ? AND password = ?";
        statement = cn.prepareStatement(adminQuery);
        statement.setString(1, Id);
        statement.setString(2, password);
        resultSet = statement.executeQuery();

        if (resultSet.next()) {
            // If validation is successful for admin, store user details in session and redirect
            String adminName = resultSet.getString("adminName");
            session.setAttribute("adminId", Id);
            session.setAttribute("adminName", adminName);
            response.sendRedirect("AdminDashboard.jsp");
        } else {
            // Check for coordinator login
            String coordinatorQuery = "SELECT * FROM coordinator WHERE coorId = ? AND password = ?";
            statement = cn.prepareStatement(coordinatorQuery);
            statement.setString(1, Id);
            statement.setString(2, password);
            resultSet = statement.executeQuery();

            if (resultSet.next()) {
                // If validation is successful for coordinator, store user details in session and redirect
                String coorName = resultSet.getString("coorName");
                session.setAttribute("coorId", Id);
                session.setAttribute("coorName", coorName);
                response.sendRedirect("CoordinatorDashboard.jsp");
            } else {
                // Check for lecturer login
                String lecturerQuery = "SELECT * FROM lecturer WHERE lectId = ? AND password = ?";
                statement = cn.prepareStatement(lecturerQuery);
                statement.setString(1, Id);
                statement.setString(2, password);
                resultSet = statement.executeQuery();

                if (resultSet.next()) {
                    // If validation is successful for lecturer, store user details in session and redirect
                    String lecturerName = resultSet.getString("lectName");
                    session.setAttribute("lectId", Id);
                    session.setAttribute("lectName", lecturerName);
                    response.sendRedirect("LecturerDashboard.jsp");
                } else {
                    // Check for student login
                    String studentQuery = "SELECT * FROM student WHERE stuId = ? AND password = ?";
                    statement = cn.prepareStatement(studentQuery);
                    statement.setString(1, Id);
                    statement.setString(2, password);
                    resultSet = statement.executeQuery();

                    if (resultSet.next()) {
                        // If validation is successful for student, store user details in session and redirect
                        String studentName = resultSet.getString("stuName");
                        session.setAttribute("stuId", Id);
                        session.setAttribute("stuName", studentName);
                        response.sendRedirect("StudentDashboard.jsp");
                    } else {
                        // If validation fails for all roles, redirect to login.jsp with an error message
                        request.setAttribute("errorMessage", "Invalid email or password");
                        RequestDispatcher rd = request.getRequestDispatcher("LoginUser.jsp");
                        rd.forward(request, response);
                    }
                }
            }
        }
    } catch (SQLException | ClassNotFoundException e) {
        e.printStackTrace();
        response.sendRedirect("LoginUser.jsp");
    } finally {
        // Close the resultSet, statement, and connection
        try {
            if (resultSet != null) {
                resultSet.close();
            }
            if (statement != null) {
                statement.close();
            }
            if (cn != null) {
                cn.close();
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Consider logging the exception instead of just printing stack trace
        }
    }
        %>

    </body>
</html>
