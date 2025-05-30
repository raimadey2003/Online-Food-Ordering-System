<%@ page language="java" contentType="text/html; charset=ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<html>
<head>
    <title>Your Cart</title>
    <link rel="stylesheet" type="text/css" href="css/cart.css"> <!-- Login page styles -->
</head>
<body>
    <h2>Your Cart</h2>
    <table>
        <tr>
            <th>Item Name</th>
            <th>Price</th>
            <th>Quantity</th>
            <th>Subtotal</th>
        </tr>
        <%
            int orderId = Integer.parseInt(request.getParameter("order_id"));
            double totalAmount = 0;

            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/mcdonalds", "root", "Raima9836@dey");
            PreparedStatement ps = con.prepareStatement("SELECT m.name, m.price, o.quantity FROM menu_items m JOIN order_items o ON m.item_id = o.item_id WHERE o.order_id = ?");
            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                String itemName = rs.getString("name");
                double itemPrice = rs.getDouble("price");
                int quantity = rs.getInt("quantity");
                double subtotal = itemPrice * quantity;
                totalAmount += subtotal;
        %>
        <tr>
            <td><%= itemName %></td>
            <td>Rs <%= itemPrice %></td>
            <td><%= quantity %></td>
            <td>Rs <%= subtotal %></td>
        </tr>
        <%
            }

            double deliveryCharge = 30;
            double gstRate = 0.18;
            double gstAmount = totalAmount * gstRate;
            double finalAmount = totalAmount + deliveryCharge + gstAmount;
        %>
    </table>

    <hr>
    <h3>Summary</h3>
    <p>Total Item Price: Rs <%= totalAmount %></p>
    <p>Delivery Charge: Rs <%= deliveryCharge %></p>
    <p>GST (18%): Rs <%= gstAmount %></p>
    <hr>
    <p><strong>Total Amount: Rs <%= finalAmount %></strong></p>

    <a href="placeOrder.jsp?order_id=<%= orderId %>">Place Order</a>
</body>
</html>
