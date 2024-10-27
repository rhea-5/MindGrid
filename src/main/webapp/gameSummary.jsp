<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Sudoku Game Summary</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Press+Start+2P&display=swap'); /* Pixel font */

        body {
            font-family: 'Press Start 2P', cursive; /* Use pixel font */
            background-image: url('images/background-game.png'); /* Background image */
            background-size: cover; /* Ensure background covers the entire page */
            background-position: top right; /* Align image to the top left */
            background-repeat: no-repeat;
            min-height: 100vh; /* Ensure body is at least the height of the viewport */
            margin: 0;
            padding: 0;   
            display: flex; /* Use flexbox for centering */
            align-items: center; /* Center vertically */
            justify-content: center; /* Center horizontally */
        }

        .container {
            display: flex; /* Use flexbox for inner centering */
            flex-direction: column; /* Stack elements vertically */
            align-items: center; /* Center align items */
            padding: 20px;
            /* Removed the translucent background color */
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            border-radius: 5px;
        }

        h1 {
            color: #fc6da0; /* Set the color of the heading */
            font-size: 36px; /* Adjust font size if necessary */
        }

        .sudoku-board {
            display: grid;
            grid-template-columns: repeat(9, 50px); /* Increase the size of the cells */
            grid-template-rows: repeat(9, 50px);
            border: 4px solid #000;
            margin: 20px auto; /* Center the grid */
        }

        .sudoku-cell {
            display: flex;
            justify-content: center;
            align-items: center;
            border: 1px solid #ddd; /* Default light border */
            font-size: 24px; /* Increase font size */
        }

        .sudoku-cell.correct {
            background-color: #c8e6c9; /* Green for correct answers */
        }

        .sudoku-cell.wrong {
            background-color: #ffccbc; /* Red for wrong answers */
        }

        .sudoku-cell.hint {
            background-color: #ff9798; /* Yellow for hints used */
        }

        .sudoku-cell.original {
            background-color: white; /* White for original puzzle cells */
            font-weight: bold;
            color: black;
        }

        .sudoku-cell input {
            width: 100%;
            height: 100%;
            text-align: center;
            font-size: 24px; /* Match font size */
            border: none;
            outline: none;
            background: transparent;
        }

        .dashboard {
            margin-top: 20px;
            font-size: 20px;
            color: white; /* Set dashboard text color */
        }

        .button {
            margin: 10px;
            padding: 10px 20px;
            font-size: 16px;
            cursor: pointer;
            background-color: #ff5f5f; /* Consistent with Start Game button */
            color: #fff;
            border: none;
            border-radius: 5px;
            transition: background-color 0.3s, transform 0.3s, box-shadow 0.3s; /* Added transition */
            text-decoration: none; /* Remove underline from link */
        }

        .button:hover {
            background-color: #ff3f3f; /* Darker red on hover */
            transform: translateY(-2px); /* Slightly lift on hover */
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.6); /* Enhance shadow on hover */
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Sudoku Game Summary</h1>

        <div class="sudoku-board">
            <%
                // Retrieve user's answers, hints used, solved board, original board, and score
                String[] userAnswers = request.getParameterValues("userAnswers[]"); // Get user answers from request
                int[][] solvedBoard = (int[][]) session.getAttribute("solvedBoard"); // Get solved board from session
                String originalBoardStr = (String) session.getAttribute("originalBoard"); // Original puzzle board
                int hintsUsed = (Integer) request.getAttribute("hintsUsed");
                int score = (Integer) request.getAttribute("score");
                int timeElapsed = (Integer) request.getAttribute("timeElapsed");

                // Reconstruct the original puzzle board from the stored string
                int[][] originalBoard = new int[9][9];
                int emptyCellsCount = 0; // Count total empty cells
                if (originalBoardStr != null) {
                    String[] rows = originalBoardStr.split(";");
                    for (int row = 0; row < 9; row++) {
                        String[] cells = rows[row].split(",");
                        for (int col = 0; col < 9; col++) {
                            originalBoard[row][col] = Integer.parseInt(cells[col].trim());
                            if (originalBoard[row][col] == 0) {
                                emptyCellsCount++; // Increment count for each empty cell
                            }
                        }
                    }
                }

                // Validate and display the Sudoku grid
                for (int row = 0; row < 9; row++) {
                    for (int col = 0; col < 9; col++) {
                        String userValue = (userAnswers != null && userAnswers[row * 9 + col] != null) 
                                           ? userAnswers[row * 9 + col].trim() 
                                           : "0"; // Default to "0" if user answer is null
                        String solvedValue = String.valueOf(solvedBoard[row][col]);
                        String cellClass = "";

                        // Determine the cell class based on the original puzzle board and hints
                        if (originalBoard[row][col] != 0) {
                            // Original puzzle cell - display in white
                            cellClass = "original";
                            userValue = String.valueOf(originalBoard[row][col]);
                        } else if (userValue.equals(solvedValue) && !userValue.equals("0")) {
                            cellClass = "correct"; // Correct answer
                        } else if (!userValue.equals(solvedValue) && !userValue.equals("0")) {
                            cellClass = "wrong"; // Wrong answer
                        } else if (userValue.equals("0")) {
                            // If the user has not answered and hints were used, consider it a hint cell
                            cellClass = (hintsUsed > 0 && originalBoard[row][col] == 0) ? "hint" : ""; // Hint used for this cell, only if hints were actually used
                        }
            %>
                        <div class="sudoku-cell <%= cellClass %>">
                            <input type="text" value="<%= userValue.equals("0") ? "" : userValue %>" readonly>
                        </div>
            <%
                    }
                }
            %>
        </div>

        <div class="dashboard">
            <p>Score: <%= score %> out of <%= emptyCellsCount %></p>
            <p>Hints Used: <%= hintsUsed %></p>

            <% 
                // Calculate minutes and seconds from the timeElapsed value
                int minutes = timeElapsed / 60; 
                int seconds = timeElapsed % 60; 
            %>
            <p>Time Taken: <%= minutes %> minutes and <%= seconds %> seconds</p>
        </div>
        
        <div>
            <a class="button" href="newgame.jsp">Play Again</a> | 
            <a class="button" href="home.jsp">Back to Home</a>
        </div>
    </div>
</body>
</html>
