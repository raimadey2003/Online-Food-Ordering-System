<%@ page language="java" contentType="text/html; charset=ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<html>
<head>
    <title>Place Order</title>
    <link rel="stylesheet" type="text/css" href="css/placeOrder.css"> <!-- Login page styles -->
</head>
<body>
    <h2>Place Your Order</h2>
    <%
        // Fetching the order_id from the URL parameter
        int orderId = Integer.parseInt(request.getParameter("order_id"));

        // Connect to the database
        String dbURL = "jdbc:mysql://localhost:3306/mcdonalds";
        String dbUsername = "root";  // Your MySQL username
        String dbPassword = "Raima9836@dey";  // Your MySQL password

        Connection con = null;
        Statement stmt = null;
        ResultSet rs = null;

        try {
            con = DriverManager.getConnection(dbURL, dbUsername, dbPassword);
            stmt = con.createStatement();

            // Fetch the order details from the database
            PreparedStatement ps = con.prepareStatement(
                "SELECT m.name, m.price, o.quantity FROM menu_items m " +
                "JOIN order_items o ON m.item_id = o.item_id " +
                "WHERE o.order_id = ?");
            ps.setInt(1, orderId);
            rs = ps.executeQuery();

            // Display cart items and calculate total price
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

    <!-- Form to confirm and place the order -->
    <form action="confirmOrder1.jsp" method="post">
        <input type="hidden" name="order_id" value="<%= orderId %>">
        <label for="delivery_address">Delivery Address:</label><br>
        <input type="text" id="delivery_address" name="delivery_address" required><br><br>
        <input type="submit" value="Confirm Order">
    </form>

    <%
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
