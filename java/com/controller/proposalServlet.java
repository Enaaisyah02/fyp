/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.controller;


import com.model.proposal;
import com.DAO.proposalDAO;
import jakarta.servlet.http.Part;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.text.ParseException;

@WebServlet(name = "proposalServlet", urlPatterns = {"/proposalServlet"})
@MultipartConfig

public class proposalServlet extends HttpServlet {

    private proposalDAO proposalDAO;

    @Override
    public void init() {
        proposalDAO = new proposalDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getServletPath();
        System.out.println("proposalDAO => Action = " + action);
        try {
            switch (action) {
                case "/proposalServlet":
                case "/proposalnew":
                    showNewForm(request, response);
                    break;
                case "/proposalinsert":
                    insertproposal(request, response);
                    break;
                case "/proposaldelete":
                    deleteproposal(request, response);
                    break;
                case "/proposaledit":
                    showEditForm(request, response);
                    break;
                case "/proposalupdate":
                    updateproposal(request, response);
                    break;
                case "/proposallist":
                    listproposal(request, response);
                    break;
                case "/downloadFiles":
                    FileDownload(request, response);
                    break;
                default:
                    response.getWriter().println("Invalid action requested.");
                    break;
            }
        } catch (SQLException ex) {
            response.getWriter().println("An error occurred during the database operation.");
            throw new ServletException(ex);
        } catch (Exception ex) {
            response.getWriter().println("An unexpected error occurred.");
            throw new ServletException(ex);
        }
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("/proposal.jsp");
        dispatcher.forward(request, response);
    }

    private void insertproposal(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {
        System.out.println("Inside Insert Servlet");
        try {
            String stuId = request.getParameter("stuId");
            Part filePart = request.getPart("proposalDesc");
            // Check if filePart is not null

            //handle file
            InputStream fileContent = filePart.getInputStream();
            byte[] fileBytes = readBytes(fileContent);

            proposal proposal = new proposal(fileBytes, stuId);
            fileContent.close();
            proposalDAO.insertproposal(proposal);
            response.sendRedirect("proposallist");

        } catch (SQLException ex) {
            ex.printStackTrace();
            throw new ServletException("Error inserting data into the database", ex);
        }
    }
    private void deleteproposal(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        
        proposalDAO.deleteproposal(id);
        response.sendRedirect("proposallist");
    }
    private void showEditForm(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException, ParseException {
        int id = Integer.parseInt(request.getParameter("id"));
        
        proposal oldproposal = proposalDAO.selectproposal(id);
        request.setAttribute("proposal", oldproposal);
        
         ServletContext sc = getServletContext();
        
        RequestDispatcher dispatcher = sc.getRequestDispatcher("/proposal.jsp");
        dispatcher.forward(request, response);
    }
    private void updateproposal(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException, ServletException {
        try {
            int Id = Integer.parseInt(request.getParameter("id"));
            Part filePart = request.getPart("proposalDesc");
            String stuId = request.getParameter("stuId");
            //HANDLE FILE
            InputStream fileContent = filePart.getInputStream();
            byte[] fileBytes = readBytes(fileContent);

            proposal proposal = new proposal(Id, fileBytes, stuId);
            fileContent.close();
            proposalDAO.updateproposal(proposal);
            response.sendRedirect("proposallist");
            
        } catch (SQLException ex) {
            ex.printStackTrace();
            throw new ServletException("Error updating data in the database", ex);
        }
    }
    private void listproposal(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException, ServletException, ParseException {
        List<proposal> listproposal = proposalDAO.selectAllproposal();
        request.setAttribute("listproposal", listproposal);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/proposalList.jsp");
        dispatcher.forward(request, response);
    }
private void FileDownload(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        proposalDAO proposalDAO = new proposalDAO();

        try {
            byte[] fileData = proposalDAO.getFileData(id);
            if (fileData != null) {
                response.setContentType("application/pdf");
                response.setHeader("Content-Disposition", "attachment; filename=\"product_file.pdf\"");
                response.getOutputStream().write(fileData);
            } else {
                response.getWriter().println("File not found");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().println("Error retrieving file data");
        }
    }
private byte[] readBytes(InputStream inputStream) throws IOException {
        ByteArrayOutputStream byteBuffer = new ByteArrayOutputStream();
        int bufferSize = 1024;
        byte[] buffer = new byte[bufferSize];

        int len;
        while ((len = inputStream.read(buffer)) != -1) {
            byteBuffer.write(buffer, 0, len);
        }

        return byteBuffer.toByteArray();
    }

    private byte[] getFileContentFromDatabase(int id) {
        byte[] fileContent = null;
        // Your DAO logic to retrieve file content based on prodID and return it as byte[]
        return fileContent;
    }

}