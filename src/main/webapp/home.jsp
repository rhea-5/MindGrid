<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sudoku Home</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Press+Start+2P&display=swap'); /* Pixel font */

        body {
            background-image: url('images/background-bench-2.png'); /* Using a .png file */
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            font-family: 'Press Start 2P', cursive;
            background-color: #12022b;
            color: #ffd100;
            margin: 0;
            padding: 0;
        }

        header {
            background-color: #912077;
            color: #ffd100;
            padding: 10px;
            text-align: center;
            border-bottom: 8px solid #7a36e5;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.4);
        }

        footer {
            color: #ffd100;
            text-align: center;
            padding: 10px;
            position: relative;
            bottom: 0;
            width: 100%;
            margin-top: 150px;
        }

        .content {
            margin: 20px auto;
            margin-top: 50px;
            padding: 25px;
            max-width: 800px;
        }

        .welcome-message {
            font-size: 1.1em;
            color: #fd9cb2;
            text-align: center;
            margin-top: 20px;
        }

        h1, h2 {
            color: #ffd100;
            text-align: center;
            margin-bottom: 20px;
            font-size: 1.5em;
            letter-spacing: 2px;
        }

        h1 {
            font-size: 2em;
        }

        nav {
            text-align: center;
            margin-top: 20px;
        }

        nav ul {
            list-style-type: none;
            padding: 0;
            display: inline-block;
            margin-bottom: 25px;
        }

        nav ul li {
            display: inline-block;
            margin: 0 10px;
        }

        nav ul li a {
            text-decoration: none;
            color: #ffd100;
            background-color: #ff5f5f; /* Bright red for better visibility */
            padding: 12px 20px;
            border-radius: 5px;
            font-weight: bold;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.5); /* Stronger shadow for depth */
            transition: background-color 0.3s, transform 0.3s, box-shadow 0.3s; /* Added box-shadow transition */
        }

        nav ul li a:hover {
            background-color: #ff3f3f; /* Darker red on hover */
            transform: translateY(-2px); /* Slightly lift on hover */
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.6); /* Enhance shadow on hover */
        }

        .features {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(200px, 1fr)); /* Smaller minimum size for feature boxes */
            gap: 20px;
            margin-top: 30px;
        }

        .feature {
            background-color: rgba(145, 32, 119, 0.5); /* Adjusted for translucency */
            color: #ffd100;
            padding: 15px; /* Reduced padding */
            border-radius: 8px; /* Added rounded corners */
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.3);
            transition: transform 0.3s ease-in-out, box-shadow 0.3s ease-in-out; /* Smooth transition */
            text-align: center; /* Center-align text */
        }

        .feature:hover {
            transform: translateY(-5px); /* Subtle hover effect */
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.5); /* Enhance shadow on hover */
        }

        .feature h3 {
            color: #ffd100;
            margin-bottom: 5px; /* Reduced margin */
            font-size: 1.1em; /* Adjusted font size */
        }

        .feature p {
            color: #fd9cb2;
            font-size: 0.9em; /* Adjusted font size */
        }

        /* Animations */
        @keyframes fadeIn {
            from { opacity: 0; transform: scale(0.8); }
            to { opacity: 1; transform: scale(1); }
        }

    </style>
</head>
<body>
    <header>
        <h3>MindGrid</h3>
    </header>
    <div class="content">
        <p class="welcome-message">Challenge yourself with different levels of Sudoku and view your game history. Start your journey now!</p>
        <h2>Get Started</h2>

        <nav>
            <ul>
                <li><a href="gamerules.jsp">Play Game</a></li>
                <li><a href="ProfileServlet">Profile</a></li>
                <li><a href="index.html">Log Out</a></li> <!-- Log Out button -->
            </ul>
        </nav>
        <br><br><br>
        <div class="features">
            <div class="feature">
                <h3>Multiple Levels</h3>
                <p>Choose from Easy, Medium, Intermediate and Difficult levels to test your Sudoku skills.</p>
            </div>
            <div class="feature">
                <h3>Hints Available</h3>
                <p>Stuck? Use hints to help you solve your puzzles.</p>
            </div>
            <div class="feature">
                <h3>Time Yourself</h3>
                <p>Challenge yourself by timing your gameplay and improving your speed!</p>
            </div>
        </div>
    </div>
    <footer>
        <p>&copy; 2024 Sudoku Game</p>
    </footer>
</body>
</html>
