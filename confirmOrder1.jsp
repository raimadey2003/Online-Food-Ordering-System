<%@ page language="java" contentType="text/html; charset=ISO-8859-1" %>
<%@ page import="java.sql.*" %>
<html>
<head>
<title>Confirm Order</title>
<link rel="stylesheet" type="text/css" href="css/confirmOrder1.css"> <!-- Login page styles -->
</head>
<body>
<h2>Confirm Your Order</h2>
<%
// Fetch the order_id and delivery_address from the request parameters
int orderId = Integer.parseInt(request.getParameter("order_id"));
String deliveryAddress = request.getParameter("delivery_address");
// Connect to the database
String dbURL = "jdbc:mysql://localhost:3306/mcdonalds";
String dbUsername = "root"; // Your MySQL username
String dbPassword = "Raima9836@dey"; // Your MySQL password
Connection con = null;
Statement stmt = null;
ResultSet rs = null;
try {
    con = DriverManager.getConnection(dbURL, dbUsername, dbPassword);
    stmt = con.createStatement();
    
    // Fetch the order details from the database including quantities
    PreparedStatement ps = con.prepareStatement(
        "SELECT m.name, m.price, o.quantity FROM menu_items m " +
        "JOIN order_items o ON m.item_id = o.item_id " +
        "WHERE o.order_id = ?");
    ps.setInt(1, orderId);
    rs = ps.executeQuery();
    
    // Display order details
    double totalPrice = 0;
%>
<table border="1">
<tr>
    <th>Item Name</th>
    <th>Price</th>
    <th>Quantity</th>
    <th>Total</th>
</tr>
<%
    while (rs.next()) {
        String itemName = rs.getString("name");
        double itemPrice = rs.getDouble("price");
        int quantity = rs.getInt("quantity");
        double itemTotal = itemPrice * quantity; // Calculate total for each item
        totalPrice += itemTotal; // Add to total price
%>
<tr>
    <td><%= itemName %></td>
    <td>Rs. <%= itemPrice %></td>
    <td><%= quantity %></td>
    <td>Rs. <%= itemTotal %></td>
</tr>
<%
    }
    // Add Delivery fee and GST
    double deliveryFee = 30; // Delivery fee Rs. 30
    double gstRate = 0.18;   // 18% GST
    double gstAmount = totalPrice * gstRate; // Calculate GST
    double finalTotal = totalPrice + deliveryFee + gstAmount; // Final total with delivery and GST
%>
</table>
<br>
<p><strong>Total Price: </strong>Rs. <%= totalPrice %></p>
<p><strong>Delivery Fee: </strong>Rs. <%= deliveryFee %></p>
<p><strong>GST (18%): </strong>Rs. <%= gstAmount %></p>
<p><strong>Final Total: </strong>Rs. <%= finalTotal %></p>
<p><strong>Delivery Address: </strong><%= deliveryAddress %></p>

<!-- Confirmation message -->
<p>Thank you for your order! Your order number is <%= orderId %>. We will deliver your order to the address you provided as soon as possible.</p>

<%
    // Update the order status in the database
    PreparedStatement updateStmt = con.prepareStatement(
        "UPDATE orders SET status = 'Confirmed' WHERE order_id = ?");
    updateStmt.setInt(1, orderId);
    updateStmt.executeUpdate();
} catch (SQLException e) {
    out.println("Error: " + e.getMessage());
} finally {
    // Close database connections
    try {
        if (rs != null) rs.close();
        if (stmt != null) stmt.close();
        if (con != null) con.close();
    } catch (SQLException e) {
        out.println("Error closing connection: " + e.getMessage());
    }
}
%>
</body>
</html>
