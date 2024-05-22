
/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.controller;

import com.DAO.lecturerDAO;
import com.model.lecturer;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author ainan
 */
@WebServlet(name = "lectServlet", urlPatterns = {"/lectServlet"})
public class lectServlet extends HttpServlet {

    private lecturerDAO lecturerDAO;

    @Override
    public void init() {
        lecturerDAO = new lecturerDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        
        try {
            switch (action) {
                case "lectnew":
                    showNewForm(request, response);
                    break;
                case "lectinsert":
                    insertLecturer(request, response);
                    break;
                case "lectdelete":
                    deleteLecturer(request, response);
                    break;
                case "lectedit":
                    showEditForm(request, response);
                    break;
                case "lectupdate":
                    updateLecturer(request, response);
                    break;
                case "lectlist":
                    listLecturer(request, response);
                    break;
                default:
                 response.getWriter().println("Unsupported action: " + action);
                    break;    
            }
        } catch (SQLException ex) {
            response.getWriter().println("An error occured during the database operation.");
            throw new ServletException(ex);
        } catch (ParseException ex) {
            Logger.getLogger(lectServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("lectRegister.jsp");
        dispatcher.forward(request, response);

    }

    private void insertLecturer(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        String id = request.getParameter("lectId");
        String lectName = request.getParameter("lectName");
        String phoneNo = request.getParameter("phoneNo");
        String program = request.getParameter("program");
        int semester = Integer.parseInt(request.getParameter("semester"));
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        lecturer newLecturer = new lecturer(id, lectName, phoneNo, program, semester, email, password);
        lecturerDAO.insertLecturer(newLecturer);
        response.sendRedirect("lectServlet?action=lectlist");

    }

    private void deleteLecturer(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        String id = request.getParameter("lectId");

        lecturerDAO.deleteLecturer(id);
        response.sendRedirect("lectServlet?action=lectlist");
    }

    private void updateLecturer(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        String lectId = request.getParameter("lectId");
        String lectName = request.getParameter("lectName");
        String phoneNo = request.getParameter("phoneNo");
        String program = request.getParameter("program");
        int semester = Integer.parseInt(request.getParameter("semester"));
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        lecturer lectRegister = new lecturer(lectId, lectName, phoneNo, program, semester, email, password);
        lecturerDAO.updateLecturer(lectRegister);
        response.sendRedirect("lectServlet?action=lectlist");
    }
    private void listLecturer(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException, ServletException, ParseException {
        List<lecturer> listLecturer = lecturerDAO.selectAllLecturer();
        request.setAttribute("listLecturer", listLecturer);
        RequestDispatcher dispatcher = request.getRequestDispatcher("lecturerList.jsp");
        dispatcher.forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException, ParseException {
        String lectId = request.getParameter("lectId");
        lecturer oldLect = lecturerDAO.selectLecturer(lectId);
        RequestDispatcher dispatcher = request.getRequestDispatcher("lectRegister.jsp");
        request.setAttribute("lecturer", oldLect);
        dispatcher.forward(request, response);
    }

}
