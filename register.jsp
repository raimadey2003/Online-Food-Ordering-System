<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="jakarta.servlet.*, jakarta.servlet.http.*, jakarta.servlet.jsp.*" %>
<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.Statement, java.sql.ResultSet, java.sql.SQLException" %>

<html>
<head>
    <title>Customer Registration</title>
    <link rel="stylesheet" type="text/css" href="css/register.css"> <!-- Link to your CSS file -->
    <script type="text/javascript">
        function validateRegistrationForm() {
            var phone = document.forms["registrationForm"]["phone"].value;
            
            // Check if the phone number is exactly 10 digits
            var phonePattern = /^\d{10}$/;
            if (!phonePattern.test(phone)) {
                alert("Please enter a valid 10-digit phone number.");
                return false;
            }
            return true;
        }
    </script>
</head>
<body>
    <div class="container">
        <h2>Register</h2>
        <form name="registrationForm" action="registerCustomer.jsp" method="post" onsubmit="return validateRegistrationForm()">
            <label for="name">Name:</label>
            <input type="text" name="name" required><br><br>

            <label for="phone">Phone Number:</label>
            <input type="text" name="phone" required><br><br>

            <label for="address">Address:</label>
            <input type="text" name="address" required><br><br>

            <label for="branch">Select Branch:</label>
            <select name="branch_id" required>
                <option value="Regal Cinema Complex">Regal Cinema Complex</option>
                <option value="Connaught Place">Connaught Place</option>
                <option value="Old Delhi Railway Station">Old Delhi Railway Station</option>
                <option value="Unity One Mall">Unity One Mall</option>
                <% 
                    // Database connection parameters
                    String jdbcURL = "jdbc:mysql://localhost:3306/mcdonalds"; // Replace with your DB details
                    String jdbcUsername = "root"; // Replace with your DB username
                    String jdbcPassword = "Raima9836@dey"; // Replace with your DB password

                    Connection connection = null;
                    Statement statement = null;
                    ResultSet resultSet = null;

                    try {
                        // Load the MySQL JDBC driver
                        Class.forName("com.mysql.cj.jdbc.Driver");

                        // Establish connection
                        connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);

                        // Create SQL statement
                        statement = connection.createStatement();
                        String sql = "SELECT * FROM branches"; // Fetching all branches
                        resultSet = statement.executeQuery(sql);

                        // Loop through the result set and populate the dropdown list
                        while (resultSet.next()) {
                            int branchId = resultSet.getInt("branch_id");
                            String location = resultSet.getString("location");
                %>
                <option value="<%= branchId %>"><%= location %></option>
                <% 
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    } finally {
                        // Close resources
                        try {
                            if (resultSet != null) resultSet.close();
                            if (statement != null) statement.close();
                            if (connection != null) connection.close();
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                    }
                %>
            </select><br><br>

            <input type="submit" value="Register">
        </form>
    </div>
</body>
</html>
