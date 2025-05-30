<%@ page language="java" contentType="text/html; charset=ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%
    String[] itemIdsParam = request.getParameterValues("item_ids");
    String customerIdParam = request.getParameter("customer_id");

    if (itemIdsParam == null || customerIdParam == null || customerIdParam.isEmpty()) {
        response.sendRedirect("error.jsp?message=Missing item_ids or customer_id");
        return;
    }

    int customerId = Integer.parseInt(customerIdParam);
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/mcdonalds", "root", "Raima9836@dey");

    PreparedStatement ps = con.prepareStatement("INSERT INTO orders (customer_id, status) VALUES (?, ?)", Statement.RETURN_GENERATED_KEYS);
    ps.setInt(1, customerId);
    ps.setString(2, "Pending");
    int result = ps.executeUpdate();

    if (result > 0) {
        ResultSet rs = ps.getGeneratedKeys();
        int orderId = 0;
        if (rs.next()) {
            orderId = rs.getInt(1);

            PreparedStatement ps2 = con.prepareStatement("INSERT INTO order_items (order_id, item_id, quantity) VALUES (?, ?, ?)");
            for (String itemIdParam : itemIdsParam) {
                int itemId = Integer.parseInt(itemIdParam);
                int quantity = Integer.parseInt(request.getParameter("quantity_" + itemIdParam));
                ps2.setInt(1, orderId);
                ps2.setInt(2, itemId);
                ps2.setInt(3, quantity);
                ps2.executeUpdate();
            }

            response.sendRedirect("cart.jsp?order_id=" + orderId);
        }
    }
%>
