<%@ page language="java" contentType="text/html; charset=ISO-8859-1"%>
<%@ page import="java.sql.*" %>

<html>
<head>
    <title>Menu</title>
    <!-- Link to the external CSS file for styling -->
    <link rel="stylesheet" type="text/css" href="css/menu.css">
</head>
<body>
    <div class="container">
        <h2>Menu</h2>
        <form action="addToCart.jsp" method="get">
            <table>
                <tr>
                    <th>Select</th>
                    <th>Item Name</th>
                    <th>Price</th>
                    <th>Quantity</th>
                </tr>
                <%
                    String customerIdStr = request.getParameter("customer_id");
                    if (customerIdStr != null && !customerIdStr.isEmpty()) {
                        try {
                            int customerId = Integer.parseInt(customerIdStr);
                            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/mcdonalds", "root", "Raima9836@dey");
                            Statement stmt = con.createStatement();
                            ResultSet rs = stmt.executeQuery("SELECT * FROM menu_items");
                            while (rs.next()) {
                %>
                <tr>
                    <td><input type="checkbox" name="item_ids" value="<%= rs.getInt("item_id") %>"></td>
                    <td><%= rs.getString("name") %></td>
                    <td><%= rs.getDouble("price") %></td>
                    <td><input type="number" name="quantity_<%= rs.getInt("item_id") %>" value="1" min="1"></td>
                </tr>
                <%
                            }
                        } catch (NumberFormatException e) {
                            out.println("Invalid customer ID format.");
                        }
                    } else {
                        out.println("Customer ID is missing.");
                    }
                %>
            </table>
            <input type="hidden" name="customer_id" value="<%= customerIdStr %>">
            <input type="submit" value="Add to Cart">
        </form>
    </div>
</body>
</html>
