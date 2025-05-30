<!DOCTYPE html>
<html>
<head>
    <title>Factorial Calculator</title>
</head>
<body>
    <form method="post">
        <label for="number">Enter a number:</label>
        <input type="number" id="number" name="number">
        <button type="submit">Calculate</button>
    </form>

    <% 
        String numStr = request.getParameter("number");
        if (numStr != null) {
            int num = Integer.parseInt(numStr);
            int factorial = 1;
            for (int i = 1; i <= num; i++) {
                factorial *= i;
            }
    %>
        <p>Factorial of <%= num %> is <%= factorial %>.</p>
    <% } %>
</body>
</html>
