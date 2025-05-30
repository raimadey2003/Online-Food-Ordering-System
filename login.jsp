<%@ page language="java" contentType="text/html; charset=ISO-8859-1"%>
<html>
<head>
    <title>Customer Login</title>
    <link rel="stylesheet" type="text/css" href="css/login.css"> <!-- Login page styles -->
    <script type="text/javascript">
        function validateForm() {
            var phone = document.forms["loginForm"]["phone"].value;
            
            // Check if the phone number field is empty
            if (phone == "") {
                alert("Phone number must be filled out");
                return false;
            }
            
            // Check if the phone number is exactly 10 digits
            var phonePattern = /^\d{10}$/;
            if (!phonePattern.test(phone)) {
                alert("Please enter a valid 10-digit phone number.");
                return false;
            }
            
            return true;
        }

        function redirectToRegister() {
            window.location.href = 'register.jsp';
        }
    </script>
</head>
<body>
    <div class="login-container">
        <h2>McDonald's</h2>
        <form name="loginForm" action="validateCustomer.jsp" method="post" onsubmit="return validateForm()">
            <label for="phone">Phone Number:</label>
            <input type="text" id="phone" name="phone" required>
            <input type="submit" value="Login"><br><br>
            <input type="submit" value="New User! Register Now" onclick="redirectToRegister()">        
        </form>
    </div>
</body>
</html>
