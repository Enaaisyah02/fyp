<%@page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>

<%@ include file="fetchLecturers.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Generate Presentation Schedule</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #f5f5f5;
        }

        h2 {
            margin-bottom: 20px;
            color: #333;
        }

        form {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            max-width: 600px;
            margin: 0 auto;
        }

        label {
            font-weight: bold;
        }

        input[type="date"],
        select {
            width: 100%;
            padding: 8px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }

        button {
            background-color: #007bff;
            color: #fff;
            border: none;
            border-radius: 4px;
            padding: 10px 20px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        button:hover {
            background-color: #0056b3;
        }

        #selectedLecturers {
            margin-top: 10px;
        }

        #lecturersList {
            display: none;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
        }

        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }

        th {
            background-color: #f2f2f2;
        }

        .selectButton {
            background-color: #007bff;
            color: #fff;
            border: none;
            border-radius: 4px;
            padding: 6px 12px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .selectButton:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    
    <h2>Generate Presentation Schedule</h2>
    <form id="scheduleForm" action="dopresentSch.jsp" method="post">
        <!-- Presentation Date Input -->
        <label for="presentationDate">Presentation Date:</label>
        <input type="date" id="presentationDate" name="presentationDate" required><br><br>

        <!-- Venue Selection -->
        <label for="venue">Venue:</label>
        <select id="venue" name="venue" required>
            <option value="">Select Venue</option>
            <option value="Venue A">Lab MP1</option>
            <option value="Venue B">Lab MP2</option>
            <option value="Venue C">Lab MP3</option>
            <!-- Add more venue options as needed -->
        </select><br><br>

        <!-- View Lecturers Button -->
        <button type="button" id="viewLecturersButton">View Lecturers</button><br><br>

        <!-- Selected Lecturers -->
        <label>Selected Lecturers:</label><br>
        <div id="selectedLecturers"></div><br><br>

        <!-- Submit Button -->
        <input type="submit" value="Generate Schedule">
    </form>

    <div id="lecturersList"></div>

    <script>
        // Function to fetch and display the list of lecturers
        function viewLecturers() {
            fetch('fetchLecturers.jsp')
                .then(response => response.json())
                .then(data => {
                    const lecturersListDiv = document.getElementById('lecturersList');
                    lecturersListDiv.innerHTML = '<table><tr><th>Lecturer ID</th><th>Lecturer Name</th><th>Program</th><th>Select</th></tr>';
                    data.forEach(lecturer => {
                        const row = document.createElement('tr');
                        row.innerHTML = `<td>${lecturer.lectId}</td><td>${lecturer.lectName}</td><td>${lecturer.program}</td><td><button class="selectButton" onclick="selectLecturer('${lecturer.lectId}', '${lecturer.lectName}')">Select</button></td>`;
                        lecturersListDiv.querySelector('table').appendChild(row);
                    });
                    lecturersListDiv.style.display = 'block';
                })
                .catch(error => {
                    console.error('Error fetching lecturers:', error);
                });
        }

        // Function to add selected lecturer to the form
        function selectLecturer(lecturerId, lecturerName) {
            const selectedLecturersDiv = document.getElementById('selectedLecturers');
            const selectedLecturersInput = document.createElement('input');
            selectedLecturersInput.type = 'hidden';
            selectedLecturersInput.name = 'selectedLecturers';
            selectedLecturersInput.value = `${lecturerId}:${lecturerName}`;
            selectedLecturersDiv.appendChild(selectedLecturersInput);
            selectedLecturersDiv.innerHTML += `${lecturerName}<br>`;
        }

        // Add event listener to the "View Lecturers" button
        document.getElementById('viewLecturersButton').addEventListener('click', viewLecturers);
    </script>
</body>
</html>
