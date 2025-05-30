<%@ page language="java" contentType="text/html; charset=ISO-8859-1"%>
<html>
<head>
    <title>Error</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8d7da;
            color: #721c24;
            text-align: center;
            padding: 50px;
        }
        .error-message {
            background-color: #f8d7da;
            border: 1px solid #f5c6cb;
            color: #721c24;
            padding: 15px;
            border-radius: 5px;
            font-size: 18px;
        }
        .go-back {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 20px;
            background-color: #007bff;
            color: white;
            text-decoration: none;
            border-radius: 5px;
        }
        .go-back:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <h1>Error</h1>
    <div class="error-message">
        <h2>Something went wrong!</h2>
        <p>
            <%= request.getParameter("message") != null ? request.getParameter("message") : "An unexpected error occurred." %>
        </p>
        <a href="menu.jsp" class="go-back">Go Back to Home</a>
    </div>
</body>
</html>
