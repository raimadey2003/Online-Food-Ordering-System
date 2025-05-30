<%@ page language="java" contentType="text/html; charset=ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%
    String name = request.getParameter("name");
    String phone = request.getParameter("phone");
    String address = request.getParameter("address");

    // Database connection setup
    Connection con = null;
    PreparedStatement checkPhoneStatement = null;
    PreparedStatement insertStatement = null;
    ResultSet rs = null;

    try {
        // Establish database connection
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/mcdonalds", "root", "Raima9836@dey");

        // Prepare statement to check if phone number already exists
        String checkPhoneQuery = "SELECT * FROM customers WHERE phone = ?";
        checkPhoneStatement = con.prepareStatement(checkPhoneQuery);
        checkPhoneStatement.setString(1, phone);
        rs = checkPhoneStatement.executeQuery();

        if (rs.next()) {
            // Phone number exists, display error message
%>
            <script type="text/javascript">
                alert("User with this phone number already exists.");
                window.location.href = "register.jsp"; // Redirect back to registration page
            </script>
<%
        } else {
            // Phone number does not exist, proceed with registration
            String insertQuery = "INSERT INTO customers (name, phone, address) VALUES (?, ?, ?)";
            insertStatement = con.prepareStatement(insertQuery);
            insertStatement.setString(1, name);
            insertStatement.setString(2, phone);
            insertStatement.setString(3, address);
            int result = insertStatement.executeUpdate();

            if (result > 0) {
                // Redirect to login page or other page after successful registration
                response.sendRedirect("login.jsp?customer_id=" + phone);
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        // Close resources
        if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (checkPhoneStatement != null) try { checkPhoneStatement.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (insertStatement != null) try { insertStatement.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (con != null) try { con.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>
