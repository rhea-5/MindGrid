<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Game Rules</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Press+Start+2P&display=swap'); /* Pixel font */

        body {
            font-family: 'Press Start 2P', cursive; /* Use pixel font */
            background-image: url('images/background-rules.png'); /* Background image */
            background-size: cover; /* Ensure background covers the entire page */
            background-position: top right; /* Align image to the top left */
            background-repeat: no-repeat;
            min-height: 100vh; /* Ensure body is at least the height of the viewport */
            margin: 0;
            padding: 0;   
        }

        .container {
            width: 60%;
            padding: 20px;
            background-color: rgba(147, 81, 242, 0.5); /* Background with higher translucency */
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            border-radius: 5px;
            margin-top: 100px; /* Space above the container */
            margin-left: 50px; /* Left margin */
            position: relative; /* Allows for absolute positioning inside */
            top: 50px; /* Top margin */
            left: 20px; /* Position container from the left */
        }

        h1 {
            color: #ffbbea;
            text-align: center; /* Center the heading */
        }

        p {
            font-size: 1.1em; /* Increased font size for better readability */
            line-height: 1.5;
            color: #fd9cb2; /* Updated paragraph color */
            text-align: center; /* Center the paragraph */
        }

        .rules-list {
            list-style-type: none;
            padding: 0;
            margin: 20px 0; /* Space above and below the list */
        }

        .rules-list li {
            margin-bottom: 10px;
            padding-left: 1em;
            text-indent: -1em;
            font-size: 1em; /* Font size for rules */
            color: white; /* Set rules text color to white */
        }

        .rules-list li:before {
            content: "• ";
            color: white; /* Set bullet color to white */
            font-weight: bold;
        }

        .start-game {
            margin-top: 20px;
            text-align: center; /* Center the start game button */
        }

        .start-game a {
            padding: 10px 15px;
            background-color: #ff5f5f; /* Bright red for consistency with home.jsp */
            color: #fff;
            text-decoration: none;
            border-radius: 5px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.5); /* Stronger shadow for depth */
            transition: background-color 0.3s, transform 0.3s, box-shadow 0.3s; /* Added transition */
        }

        .start-game a:hover {
            background-color: #ff3f3f; /* Darker red on hover */
            transform: translateY(-2px); /* Slightly lift on hover */
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.6); /* Enhance shadow on hover */
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Game Rules</h1>
        <p>Here are the rules to play Sudoku:</p>
        <ul class="rules-list">
            <li>The goal is to fill a 9×9 grid with numbers so that each row, column, and 3×3 section contain the digits 1 to 9 without repetition.</li>
            <li>Each Sudoku puzzle starts with some cells filled in and the rest empty.</li>
            <li>Use logic and deduction to determine which numbers go into each empty cell.</li>
            <li>You cannot use the same number more than once in a row, column, or 3×3 section.</li>
            <li>Use hints or the solve option if you get stuck, but try to complete it without help!</li>
        </ul>
        <div class="start-game">
            <br>
            <a href="newgame.jsp">Start New Game</a>
            <a href="home.jsp">Back</a>
        </div>
    </div>
</body>
</html>
