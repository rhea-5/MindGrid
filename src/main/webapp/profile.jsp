<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>User Profile</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Press+Start+2P&display=swap'); /* Pixel font */

        body {
     font-family: 'Press Start 2P', cursive; /* Use pixel font */
    background-image: url('images/background-profile.png'); /* Background image */
    background-repeat: repeat-y; /* Repeat the image vertically */
    background-position: center; /* Align image to the center */
    margin: 0; /* Reset margin */
    padding: 20px; /* Add padding */
    color: #ff999a; /* Set text color */
}

        header {
            background-color: #912077; /* Header background color */
            color: #ffd100; /* Header text color */
            padding: 10px;
            text-align: center;
            border-bottom: 8px solid #7a36e5;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.4);
        }

        h1, h2 {
            color: #ffd100; /* Headings color */
        }

        table {
            width: 80%;
            margin: 20px auto; /* Center the table */
            border-collapse: collapse; /* Remove double borders */
        }

        th, td {
            padding: 12px; /* Cell padding */
            border: 1px solid #7a36e5; /* Cell border color */
            text-align: center; /* Center align text */
        }

        th {
            background-color: #7a36e5; /* Header cell background color */
        }

        .profile-info {
            margin: 20px auto; /* Center profile info */
            max-width: 600px; /* Limit max width */
            padding: 20px; /* Add padding */
            background-color: rgba(145, 32, 119, 0.5); /* Translucent background */
            border-radius: 8px; /* Rounded corners */
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.3); /* Box shadow */
        }

        .profile-info p {
            font-size: 18px; /* Font size for profile info */
            line-height: 1.6; /* Line height */
            color: #ffd100; /* Profile info text color */
        }

        .back-link {
            text-decoration: none; /* Remove underline */
            color: #ffd100; /* Link color */
            font-weight: bold; /* Bold link */
            margin-top: 20px; /* Add margin */
            display: inline-block; /* Make link a block */
            background-color: #ff5f5f; /* Button background color */
            padding: 10px 20px; /* Button padding */
            border-radius: 5px; /* Rounded corners */
            transition: background-color 0.3s, transform 0.3s; /* Transition effects */
        }

        .back-link:hover {
            background-color: #ff3f3f; /* Darker red on hover */
            transform: translateY(-2px); /* Lift on hover */
        }

        footer {
            color: #ffd100; /* Footer text color */
            text-align: center; /* Center footer text */
            padding: 10px; /* Footer padding */
            position: relative; /* Position footer */
            bottom: 0; /* Align to bottom */
            width: 100%; /* Full width */
            margin-top: 150px; /* Margin from content */
        }
    </style>
</head>
<body>
    <header>
        <h3>MindGrid</h3>
    </header>

    <h1>User Profile</h1>
    <div class="profile-info">
        <h2>Welcome, <%= request.getAttribute("name") %>!</h2>
        <p><strong>Email:</strong> <%= request.getAttribute("email") %></p>
        <p><strong>Username:</strong> <%= request.getAttribute("username") %></p>
        <p><strong>Contact:</strong> <%= request.getAttribute("contact") %></p>
    </div>

    <hr>

    <h2>Your Game History</h2>
    <table>
        <tr>
            <th>Game ID</th>
            <th>Difficulty</th>
            <th>Hints Used</th>
            <th>Score</th>
            <th>Time Elapsed</th> <!-- Added new column for time_elapsed -->
        </tr>
        <%
            // Retrieve the game history HTML from the request attribute
            String gameHistoryTable = (String) request.getAttribute("gameHistoryTable");

            // Check if there is game history to display
            if (gameHistoryTable != null && !gameHistoryTable.isEmpty()) {
        %>
            <%= gameHistoryTable %>
        <%
            } else {
        %>
            <tr>
                <td colspan="5">No games played yet.</td> <!-- Updated colspan to match the new column -->
            </tr>
        <%
            }
        %>
    </table>

    <br><a href="home.jsp" class="back-link">Back to Home</a>

    <footer>
        <p>&copy; 2024 Sudoku Game</p>
    </footer>
</body>
</html>
