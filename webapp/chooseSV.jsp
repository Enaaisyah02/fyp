<%@page import="java.sql.*"%>
<%@page contentType="text/html; pageEncoding=UTF-8"%>
<%@page session="true"%>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>View Lecturers</title>
    <jsp:include page="bootstrap.jsp"/>

    <script>
        function selectLecturer(lectId, lectName) {
            var selectedButton = document.getElementById("selectButton_" + lectId);
            var selectedLecturerId = document.getElementById("selectedLecturerId");
            var selectedLecturerName = document.getElementById("selectedLecturerName");

            // Toggle the selection state
            if (selectedButton.classList.contains("selected")) {
                // If already selected, unselect
                selectedButton.classList.remove("selected");
                selectedLecturerId.value = "";
                selectedLecturerName.value = "";
            } else {
                // If not selected, select
                // First, unselect all other buttons
                var allButtons = document.querySelectorAll(".lecturer-item button");
                allButtons.forEach(function (button) {
                    button.classList.remove("selected");
                });

                selectedButton.classList.add("selected");
                selectedLecturerId.value = lectId;
                selectedLecturerName.value = lectName;
            }
        }


        function searchLecturersByName() {
            var input, filter, table, tr, td, i, txtValue;
            input = document.getElementById("searchInputName");
            filter = input.value.toUpperCase();
            table = document.getElementById("lecturerTable");
            tr = table.getElementsByTagName("tr");

            for (i = 0; i < tr.length; i++) {
                td = tr[i].getElementsByTagName("td")[0];
                if (td) {
                    txtValue = td.textContent || td.innerText;
                    if (txtValue.toUpperCase().indexOf(filter) > -1) {
                        tr[i].style.display = "";
                    } else {
                        tr[i].style.display = "none";
                    }
                }
            }
        }

        function searchLecturersByProgram() {
            var input, filter, table, tr, td, i, txtValue;
            input = document.getElementById("searchInputProgram");
            filter = input.value.toUpperCase();
            table = document.getElementById("lecturerTable");
            tr = table.getElementsByTagName("tr");

            for (i = 0; i < tr.length; i++) {
                td = tr[i].getElementsByTagName("td")[2]; // Index 2 represents the program column
                if (td) {
                    txtValue = td.textContent || td.innerText;
                    if (txtValue.toUpperCase().indexOf(filter) > -1) {
                        tr[i].style.display = "";
                    } else {
                        tr[i].style.display = "none";
                    }
                }
            }
        }
    </script>
    <style>

        .container {
            max-width: 1500px;
            margin: 100px auto;
            padding: 50px;
            background-color: #fff;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        h2 {
            text-align: center;
            margin-bottom: 20px;
        }

        .search-container {
            margin-bottom: 20px;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .search-input {
            padding: 10px;
            width: 300px;
            margin-right: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 16px;
            transition: border-color 0.3s;
        }

        .lecturer-table {
            width: 100%;
            border-collapse: collapse;
        }

        .lecturer-table th,
        .lecturer-table td {
            border: 1px solid #ddd;
            padding: 12px; /* Increased padding for better readability */
            text-align: left;
        }

        .lecturer-table th {
            background-color: #f2f2f2;
            font-weight: bold; /* Bold font for table headers */
        }

        /* Alternating row colors for better readability */
        .lecturer-table tbody tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        /* Hover effect for better interaction */
        .lecturer-table tbody tr:hover {
            background-color: #f0f0f0;
        }
        .lecturer-item button {
            padding: 10px 20px;
            background-color: #f0f0f0;
            border: 1px solid #ccc;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .lecturer-item button:hover {
            background-color: #ddd; /* Change color when hovering */
        }

        .lecturer-item button.selected {
            background-color: #4caf50; /* Green color for selected button */
            color: #fff; /* Text color for selected button */
        }

    </style>
</head>
<%
    String studentId = (String) session.getAttribute("stuId");
    String studentName = (String) session.getAttribute("stuName");
    String alreadyRegisteredLecturerId = ""; // Initialize variable to store already registered lecturer's ID
%>
<body>
    <jsp:include page="NavStudent.jsp"/>

    <div class="container">
        <h2>Select Your Lecturer</h2>
        <div class="search-container">
            <input type="text" class="search-input" id="searchInputName" onkeyup="searchLecturersByName()" placeholder="Search by lecturer name...">
            <input type="text" class="search-input" id="searchInputProgram" onkeyup="searchLecturersByProgram()" placeholder="Search by program...">
        </div>

        <table class="lecturer-table">
            <thead>
                <tr>
                    <th>Lecturer Name</th>
                    <th>Lecturer ID</th>
                    <th>Program</th>
                </tr>
            </thead>
            <tbody id="lecturerTable">
                <% 
                    try {
                        Class.forName("com.mysql.jdbc.Driver");
                        String myURL = "jdbc:mysql://localhost:3306/myfyp";
                        Connection cn = DriverManager.getConnection(myURL, "root", "admin");

                        // Fetching lecturer names, IDs, and programs from the database
                        String fetchQuery = "SELECT lectId, lectName, program FROM lecturer";
                        PreparedStatement fetchPS = cn.prepareStatement(fetchQuery);
                        ResultSet rs = fetchPS.executeQuery();

                        while (rs.next()) {
                            // Check if student is already registered with this lecturer
                            String checkQuery = "SELECT COUNT(*) AS count FROM assignsv WHERE stuId = ? AND lectId = ?";
                            PreparedStatement checkPS = cn.prepareStatement(checkQuery);
                            checkPS.setString(1, studentId);
                            checkPS.setString(2, rs.getString("lectId"));
                            ResultSet checkRS = checkPS.executeQuery();
                            checkRS.next();
                            int count = checkRS.getInt("count");
                            if (count > 0) {
                                // Student is already registered with this lecturer
                                alreadyRegisteredLecturerId = rs.getString("lectId");
                            }
                %>
                <!-- Display each lecturer -->
                <tr class="lecturer-item">
                    <td><%= rs.getString("lectName") %></td>
                    <td><%= rs.getString("lectId") %></td>
                    <td><%= rs.getString("program") %></td>
                    <td><button onclick="selectLecturer('<%= rs.getString("lectId") %>','<%= rs.getString("lectName") %>')" id="selectButton_<%= rs.getString("lectId") %>"
                        <%-- Check if the lecturer is already selected by this student --%>
                        <% if (rs.getString("lectId").equals(alreadyRegisteredLecturerId)) { %>
                            class="selected"
                        <% } %>
                    >Select</button></td>
                </tr>

                <% 
                        }
                        cn.close();
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                %>
                <!-- Add more lecturer list items as needed -->
            </tbody>
        </table>

        <form action="doChooseSV.jsp" method="post" onsubmit="updateSelectedLecturerId()">
            <input type="hidden" id="selectedLecturerId" name="selectedLecturerId" value="">
            <input type="hidden" id="selectedLecturerName" name="selectedLecturerName" value="">
            <p>Welcome, <%= session.getAttribute("stuName") %> Student ID: <%= session.getAttribute("stuId") %></p>
            <button type="submit">Register with Selected Lecturer</button>
        </form>
    </div>

    <jsp:include page="footer.jsp" />  

</body>
</html>
