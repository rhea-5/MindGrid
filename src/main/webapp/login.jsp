<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Press+Start+2P&display=swap'); /* Pixel font */

        body {
            font-family: 'Press Start 2P', cursive; /* Use pixel font */
            background-image: url('images/background-cat.png'); /* Background image */
            background-size: cover; /* Ensure background covers the entire page */
            background-position: bottom right; /* Align image to the top left */
            background-repeat: no-repeat;
            min-height: 100vh; /* Ensure body is at least the height of the viewport */
            margin: 0;
            padding: 0;
            display: flex; /* Use Flexbox to center elements */
            justify-content: center; /* Center horizontally */
            align-items: center; /* Center vertically */
        }

        .container {
            margin-top: 10px;
            margin-right: 450px;
            width: 350px; /* Width of the login box */
            padding: 20px;
            background: rgba(255, 255, 255, 0); /* Fully transparent background */
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.4);
            border-radius: 10px; /* Added rounded corners */
        }

        h2 {
            text-align: center;
            color: #ffd100; /* Gold color for heading */
            margin-bottom: 20px;
        }

        input[type="text"], input[type="password"] {
            width: 100%;
            padding: 10px;
            margin: 5px 0 15px;
            border: 2px solid #912077; /* Dark pink border */
            border-radius: 5px;
            font-family: 'Press Start 2P', cursive; /* Pixel font for inputs */
            font-size: 1em; /* Font size for inputs */
        }

        input[type="submit"] {
            background-color: #ff0068; /* Change Login button color */
            color: white;
            padding: 10px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            width: 100%;
            font-family: 'Press Start 2P', cursive; /* Pixel font for button */
            font-size: 1em; /* Font size for button */
        }

        input[type="submit"]:hover {
            background-color: #d40053; /* Darker shade on hover */
        }

        .error {
            color: red;
            text-align: center;
        }

        /* Style for Register link */
        a {
            color: #ffbbea; /* Change Register link color */
            text-decoration: none; /* Remove underline */
        }

        a:hover {
            text-decoration: underline; /* Underline on hover */
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Login</h2>
        <form action="LoginServlet" method="post">
            <input type="text" name="username" placeholder="Username" required>
            <input type="password" name="password" placeholder="Password" required>
            <input type="submit" value="Login">
            <%
                String error = request.getParameter("error");
                if (error != null) {
            %>
                <div class="error"><%= error %></div>
            <%
                }
            %>
        </form>
        <p style="text-align: center;"><a href="register.jsp">Register</a></p>
    </div>
</body>
</html>
