<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Sudoku Game</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Press+Start+2P&display=swap'); /* Pixel font */

        body {
            font-family: 'Press Start 2P', cursive; 
            background-image: url('images/background-game.png'); 
            background-size: cover; 
            background-position: top right; 
            background-repeat: no-repeat;
            min-height: 100vh; 
            margin: 0;
            padding: 0;   
            text-align: center; 
        }

        .container {
            display: inline-block;
            padding: 20px;
            background-color: rgba(147, 81, 242, 0.5); 
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            border-radius: 5px;
            margin-top: 100px; 
        }

        .sudoku-board {
            display: grid;
            grid-template-columns: repeat(9, 50px); 
            grid-template-rows: repeat(9, 50px);
            border: 4px solid #000;
            margin: 20px auto;
        }

        .sudoku-cell {
            display: flex;
            justify-content: center;
            align-items: center;
            font-size: 24px;
            border: 1px solid #ddd; 
        }

        input[type="number"] {
            width: 100%;
            height: 100%;
            font-size: 24px;
            text-align: center;
            border: none;
        }
	.sudoku-cell.hint {
            background-color: #ff9798;
        }

        /* Add thicker borders between 3x3 blocks */
        .sudoku-cell:nth-child(3n+1) {
            border-left: 4px solid #000;
        }

        .sudoku-cell:nth-child(3n) {
            border-right: 4px solid #000;
        }

        .sudoku-cell:nth-child(n+1):nth-child(-n+9),
        .sudoku-cell:nth-child(n+28):nth-child(-n+36),
        .sudoku-cell:nth-child(n+55):nth-child(-n+63) {
            border-top: 4px solid #000;
        }

        .sudoku-cell:nth-child(n+73) {
            border-bottom: 4px solid #000;
        }

        #timer {
            font-size: 20px;
            margin-top: 20px;
            color: white; /* Set timer text color */
        }

        .button {
            margin: 10px;
            padding: 10px 20px;
            font-size: 16px;
            cursor: pointer;
            background-color: #ff5f5f; 
            color: #fff;
            border: none;
            border-radius: 5px;
            transition: background-color 0.3s, transform 0.3s, box-shadow 0.3s; 
            text-decoration: none;
        }

        .button:hover {
            background-color: #ff3f3f; 
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.6); 
        }
        h1 {
            color: #fc6da0; 
            font-size: 36px; 
        }
        
    </style>
</head>
<body onload="startTimer()">
    <div class="container">
        <h1>Sudoku Game</h1>
        <div id="timer">Time: 0 seconds</div>

        <form id="scoreForm" action="GameServlet" method="post">
            <input type="hidden" id="userId" name="userId" value="<%= session.getAttribute("userId") %>">
            <input type="hidden" id="hintsUsed" name="hintsUsed" value="0">
            <input type="hidden" id="timeElapsed" name="timeElapsed" value="0">

            <div class="sudoku-board">
                <%
                    // Retrieve `originalBoard` and `solvedBoard` from the servlet
                    String originalBoard = (String) request.getAttribute("originalBoard");
                    int[][] solvedBoard = (int[][]) session.getAttribute("solvedBoard"); // Get solved board from session

                    // Split the original board into rows
                    String[] originalRows = originalBoard.split(";");

                    for (int row = 0; row < 9; row++) {
                        String[] originalCells = originalRows[row].split(",");
                        for (int col = 0; col < 9; col++) {
                            String originalValue = originalCells[col].trim();
                            String displayValue = originalValue.equals("0") ? "" : originalValue; // Display original puzzle
                            String solvedValue = String.valueOf(solvedBoard[row][col]); // Get solved value as String
                            // Determine if the cell should have a hint class
                            String cellClass = originalValue.equals("0") ? "user" : "given";
                %>
                            <div class="sudoku-cell <%= originalValue.equals("0") ? "user" : "" %>">
                                <input type="number" min="1" max="9" value="<%= displayValue %>" maxlength="1" data-solved-value="<%= solvedValue %>" <%= originalValue.equals("0") ? "" : "readonly" %> name="userAnswers[]" data-cell-type="<%= cellClass %>" oninput="removeHintClass(this)">
                            </div>
                <%
                        }
                    }
                %>
            </div>

            
            <button type="button" class="button" onclick="provideHint()">Provide Hint</button>
            <button type="button" class="button" onclick="endGame()">End Game</button>
        </form>
    </div>

    <script>
        let timer; 
        let timeElapsed = 0; 

        
        function startTimer() {
            timer = setInterval(function() {
                timeElapsed++; 
                document.getElementById('timer').innerText = "Time: " + timeElapsed + " seconds"; 
            }, 1000); 
        }

        
        function provideHint() {
            let hintsUsedField = document.getElementById("hintsUsed");
            hintsUsedField.value = parseInt(hintsUsedField.value) + 1; 

            
            let inputs = document.querySelectorAll('.sudoku-cell input[data-cell-type="user"]');
            for (let input of inputs) {
                if (input.value === "") {
                    input.value = input.getAttribute("data-solved-value"); 
                    input.parentElement.classList.add('hint'); // Add the hint class to the cell
                    break; // Show only one hint
                }
            }

            alert("Hint provided!"); // Alert the user that a hint has been provided
        }

        // Function to remove the hint class when the user inputs a value
        function removeHintClass(input) {
            if (input.value !== "") {
                input.parentElement.classList.remove('hint'); // Remove the hint class if the user inputs a value
            }
        }

        // Function to end the game
        function endGame() {
            clearInterval(timer); // Stop the timer
            document.getElementById("timeElapsed").value = timeElapsed; // Set the time taken to the hidden field
            document.getElementById("scoreForm").submit(); // Submit the form to save the game data
        }
    </script>
</body>
</html>
