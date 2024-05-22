/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.controller;

import com.model.FYPMaterial;
import com.DAO.FYPMaterialDAO;
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

@WebServlet(name = "FYPMaterialServlet", urlPatterns = {"/FYPMaterialServlet"})
@MultipartConfig
public class FYPMaterialServlet extends HttpServlet {

    private FYPMaterialDAO FYPMaterialDAO;

    @Override
    public void init() {
        FYPMaterialDAO = new FYPMaterialDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
         doGet(request,response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getServletPath();
        System.out.println("FYPMaterialServlet => Action = " + action);

        try {
            switch (action) {
                case "/FYPMaterialServlet":
                case "/materialnew":
                    showNewForm(request, response);
                    break;
                case "/materialinsert":
                    insertFYPMaterial(request, response);
                    break;
                case "/materialdelete":
                    deleteFYPMaterial(request, response);
                    break;
                case "/materialedit":
                    showEditForm(request, response);
                    break;
                case "/materialupdate":
                    updateFYPMaterial(request, response);
                    break;
                case "/materiallist":
                    listFYPMaterial(request, response);
                    break;
                case "/downloadFile":
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
        RequestDispatcher dispatcher = request.getRequestDispatcher("/FYPmaterial.jsp");
        dispatcher.forward(request, response);
    }

    private void insertFYPMaterial(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {
        System.out.println("Inside Insert Servlet");
        try {
            String title = request.getParameter("title");
            Part filePart = request.getPart("fileDesc");
            // Check if filePart is not null

            //handle file
            InputStream fileContent = filePart.getInputStream();
            byte[] fileBytes = readBytes(fileContent);

            FYPMaterial FYPMaterial = new FYPMaterial(title, fileBytes);
            fileContent.close();
            FYPMaterialDAO.insertFYPMaterial(FYPMaterial);
            response.sendRedirect("materiallist");

        } catch (SQLException ex) {
            ex.printStackTrace();
            throw new ServletException("Error inserting data into the database", ex);
        }
    }

    private void deleteFYPMaterial(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        
        FYPMaterialDAO.deleteFYPMaterial(id);
        response.sendRedirect("materiallist");
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException, ParseException {
        int id = Integer.parseInt(request.getParameter("id"));
        
        FYPMaterial oldMaterial = FYPMaterialDAO.selectFYPMaterial(id);
        request.setAttribute("FYPMaterial", oldMaterial);
        
         ServletContext sc = getServletContext();
        
        RequestDispatcher dispatcher = sc.getRequestDispatcher("/FYPmaterial.jsp");
        dispatcher.forward(request, response);
    }

    private void updateFYPMaterial(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException, ServletException {
        try {
            int Id = Integer.parseInt(request.getParameter("id"));
            String title = request.getParameter("title");
            Part filePart = request.getPart("fileDesc");
            //HANDLE FILE
            InputStream fileContent = filePart.getInputStream();
            byte[] fileBytes = readBytes(fileContent);

            FYPMaterial FYPMaterial = new FYPMaterial(Id, title, fileBytes);
            fileContent.close();
            FYPMaterialDAO.updateFYPMaterial(FYPMaterial);
            response.sendRedirect("materiallist");
            
        } catch (SQLException ex) {
            ex.printStackTrace();
            throw new ServletException("Error updating data in the database", ex);
        }
    }

    private void listFYPMaterial(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException, ServletException, ParseException {
        List<FYPMaterial> listFYPMaterial = FYPMaterialDAO.selectAllFYPMaterial();
        request.setAttribute("listFYPMaterial", listFYPMaterial);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/FYPMaterialList.jsp");
        dispatcher.forward(request, response);
    }

    private void FileDownload(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        FYPMaterialDAO FYPMaterialDAO = new FYPMaterialDAO();

        try {
            byte[] fileData = FYPMaterialDAO.getFileData(id);
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
