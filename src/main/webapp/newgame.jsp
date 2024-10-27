<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Select Difficulty Level</title>
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

        .difficulty-level {
            margin-top: 20px;
            text-align: center; /* Center the difficulty level options */
            color: white; /* Set difficulty level text color to white */
            font-size: 1.5em; /* Increase font size for difficulty levels */
        }

        .difficulty-level label {
            display: block; /* Stack the radio button and label in a column */
            margin-bottom: 15px; /* Space between options */
            color: white; /* Label color */
        }

        .difficulty-level input[type="radio"] {
            margin-right: 10px; /* Space between checkbox and label */
            width: 30px; /* Increase the width of the checkbox */
            height: 30px; /* Increase the height of the checkbox */
            transform: scale(1.5); /* Scale the radio button for a larger appearance */
        }

        .button {
            font-family: 'Press Start 2P', cursive;
            padding: 10px 15px;
            background-color: #ff5f5f; /* Bright red for consistency */
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s, transform 0.3s, box-shadow 0.3s; /* Added transition */
            font-size: 1.2em; /* Increase font size */
            text-decoration: none; /* Remove underline from link */
            display: inline-block; /* Make the link behave like a button */
        }

        .button:hover {
            background-color: #ff3f3f; /* Darker red on hover */
            transform: translateY(-2px); /* Slightly lift on hover */
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.6); /* Enhance shadow on hover */
        }

        .start-game, .back-button {
            margin-top: 20px;
            text-align: center; /* Center the buttons */
        }

        
    </style>
</head>
<body>
    <div class="container">
        <h1>Select Difficulty Level</h1>
        <form action="NewGameServlet" method="post">
            <div class="difficulty-level">
                <label>
                    <input type="radio" name="difficulty" value="easy" id="easy" required>
                    Easy
                </label>
                <label>
                    <input type="radio" name="difficulty" value="medium" id="medium">
                    Medium
                </label>
                <label>
                    <input type="radio" name="difficulty" value="intermediate" id="intermediate">
                    Intermediate
                </label>
                <label>
                    <input type="radio" name="difficulty" value="difficult" id="difficult">
                    Difficult
                </label>
            </div>
            <div class="start-game">
                <button type="submit" class="button">Start Game</button>
            </div>
        </form>
        <div class="back-button">
            <a href="gamerules.jsp" class="button">Back</a> <!-- Link to return to game rules -->
        </div>
    </div>
</body>
</html>
