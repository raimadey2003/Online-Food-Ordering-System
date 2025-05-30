<!DOCTYPE html>
<html>
<body>
  <h1>Your Details</h1>
  <p>Name: <%= request.getParameter("name") %></p>
  <p>Age: <%= request.getParameter("age") %></p>
  <p>DOB: <%= request.getParameter("dob") %></p>
  <p>Email: <%= request.getParameter("email") %></p>
  <p>Phone: <%= request.getParameter("phone") %></p>
  <p>Address: <%= request.getParameter("address") %></p>
</body>
</html>
