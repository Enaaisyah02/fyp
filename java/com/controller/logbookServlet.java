/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.controller;

import com.model.logbook;
import com.DAO.logbookDAO;

import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.sql.Date;
import java.text.ParseException;
//import java.nio.file.Paths;
import java.util.Base64;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author ainan
 */
@WebServlet(name = "logbookServlet", urlPatterns = {"/logbookServlet"})
@MultipartConfig

public class logbookServlet extends HttpServlet {

    private logbookDAO logbookDAO;

    @Override
    public void init() {
        logbookDAO = new logbookDAO();

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
         doGet(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String action = request.getServletPath();
        System.out.println("logbookServlet => Action = " + action);

        try {
            switch (action) {
                case "/logbookServlet":
                case "/lognew":
                    showNewForm(request, response);
                    break;
                case "/loginsert":
                    insertLogbook(request, response);
                    break;
                case "/logdelete":
                    deleteLogbook(request, response);
                    break;
                case "/logedit":
                    showEditForm(request, response);
                    break;
                case "/logupdate":
                    updateLogbook(request, response);
                    break;
                case "/loglist":
                    listLogbook(request, response);
                    break;

            }
        } catch (SQLException ex) {
            response.getWriter().println("An error occured during the database operation.");
            throw new ServletException(ex);
        } catch (Exception ex) {
            Logger.getLogger(lectServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        ServletContext sc = getServletContext();
        RequestDispatcher dispatcher = sc.getRequestDispatcher("/submitLogbook.jsp");
        dispatcher.forward(request, response);

    }

    private void insertLogbook(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException, ServletException {
        System.out.println("Inside Insert Servlet");
        try {
            String stuId = request.getParameter("stuId");
            String activity = request.getParameter("activity");
            String problem = request.getParameter("problem");
            String solution = request.getParameter("solution");

            // Assuming your date is retrieved from the request parameter named "date"
            String dateString = request.getParameter("date");
            // Parse the string to java.sql.Date
            Date date = Date.valueOf(dateString);

            //insert image
            Part imagePart = request.getPart("imgExp");
            InputStream inputStream = imagePart.getInputStream();
            byte[] imageBytes = inputStream.readAllBytes();
            // After getting imageBytes
            // String base64Image = Base64.getEncoder().encodeToString(imageBytes);

            logbook logbook = new logbook(stuId, activity, problem, solution, date, imageBytes);

            inputStream.close();

            logbookDAO.insertLogbook(logbook);
            response.sendRedirect("loglist");
        } catch (SQLException ex) {
            // Log the exception or print the stack trace
            ex.printStackTrace();
            throw new ServletException("Error inserting data into the database", ex);
        }

    }

    private void deleteLogbook(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        int Id = Integer.parseInt(request.getParameter("logbookId"));

        logbookDAO.deleteLogbook(Id);
        response.sendRedirect("loglist");
    }

    private void updateLogbook(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException, ServletException, Exception {
        try {
            int logId = Integer.parseInt(request.getParameter("logbookId"));
            String stuId = request.getParameter("stuId");
            String activity = request.getParameter("activity");
            String problem = request.getParameter("problem");
            String solution = request.getParameter("solution");

            // Assuming you retrieve the existing date from the database
            Date existingDate = logbookDAO.selectLogbook(logId).getDate();
            // Use the existing date if it's not null, otherwise, parse the date from the request parameter
            Date date = (existingDate != null) ? existingDate : Date.valueOf(request.getParameter("date"));

            // image
            Part imagePart = request.getPart("imgExp");

            InputStream inputStream = imagePart.getInputStream();
            byte[] imageBytes = inputStream.readAllBytes();
            inputStream.close();

            String base64Image = Base64.getEncoder().encodeToString(imageBytes);

            logbook logbook = new logbook(logId, stuId, activity, problem, solution, date, imageBytes);
            logbookDAO.updateLogbook(logbook);
            response.sendRedirect("loglist");
        } catch (SQLException ex) {
            // Log the exception or print the stack trace
            ex.printStackTrace();
            throw new ServletException("Error inserting data into the database", ex);
        }

    }

    private void listLogbook(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException, ServletException, ParseException {
        System.out.println("Inside listLogbook method");
        List<logbook> listLogbook = logbookDAO.selectAllLogbook();
        request.setAttribute("listOfLogbook", listLogbook);
        ServletContext sc = getServletContext();
        RequestDispatcher dispatcher = sc.getRequestDispatcher("/listLogBook.jsp");
        dispatcher.forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException, Exception {
        int Id = Integer.parseInt(request.getParameter("logbookId"));

        logbook existLogbook = logbookDAO.selectLogbook(Id);
        request.setAttribute("logbook", existLogbook);

        ServletContext sc = getServletContext();

        RequestDispatcher dispatcher = sc.getRequestDispatcher("/submitLogbook.jsp");
        dispatcher.forward(request, response);
    }
}
