<%@ page import="java.sql.*" %>
<%
    String phone = request.getParameter("phone");

    // Load the MySQL JDBC driver
    Class.forName("com.mysql.cj.jdbc.Driver");

    // Establish the connection
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/mcdonalds", "root", "Raima9836@dey");
    Statement stmt = con.createStatement();
    ResultSet rs = stmt.executeQuery("SELECT * FROM customers WHERE phone='" + phone + "'");
    if (rs.next()) {
        response.sendRedirect("menu.jsp?customer_id=" + rs.getInt("customer_id"));
    } else {
        response.sendRedirect("register.jsp");
    }
%>