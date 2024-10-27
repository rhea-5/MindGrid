import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Random;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class NewGameServlet extends HttpServlet {

    private final String DB_URL = "jdbc:mysql://localhost:3306/sudoku_game";
    private final String DB_USER = "root";
    private final String DB_PASSWORD = "Pondy@2023";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String difficulty = request.getParameter("difficulty");
        int[][] solvedBoard = generateSolvedSudokuBoard();
        solvedBoard = shuffleBoard(solvedBoard); // Shuffle the solved board
        int[][] puzzle = removeCellsFromBoard(solvedBoard, difficulty);

        // Log the original board and the puzzle
        System.out.println("Solved Board: " + convertBoardToString(solvedBoard));
        System.out.println("Puzzle Board: " + convertBoardToString(puzzle));

        // Save the game to the database
        HttpSession session = request.getSession();
        int gameId = saveGameToDatabase(puzzle, solvedBoard, difficulty, session);

        // Store game ID and solved board in session
        session.setAttribute("gameId", gameId);
        session.setAttribute("solvedBoard", solvedBoard); // Store solved board as int[][]
        session.setAttribute("originalBoard", convertBoardToString(puzzle)); // Store original puzzle as string

        // Set the original puzzle as a request attribute for JSP
        request.setAttribute("originalBoard", convertBoardToString(puzzle)); // Set puzzle board

        // Forward to game.jsp
        request.getRequestDispatcher("game.jsp").forward(request, response);
    }

    private int[][] generateSolvedSudokuBoard() {
        int[][] board = new int[9][9];
        fillSudokuBoard(board);
        return board; // Return a completed board
    }

    private void fillSudokuBoard(int[][] board) {
        fillBoard(board);
    }

    private boolean fillBoard(int[][] board) {
        // Use backtracking to fill the board
        for (int row = 0; row < 9; row++) {
            for (int col = 0; col < 9; col++) {
                if (board[row][col] == 0) {
                    for (int num = 1; num <= 9; num++) {
                        if (isValidPlacement(board, num, row, col)) {
                            board[row][col] = num;

                            if (fillBoard(board)) {
                                return true; // Solved
                            } else {
                                board[row][col] = 0; // Backtrack
                            }
                        }
                    }
                    return false; // No number fits
                }
            }
        }
        return true; // Solved
    }

    private int[][] removeCellsFromBoard(int[][] board, String difficulty) {
        int[][] puzzle = new int[9][9];
        for (int i = 0; i < 9; i++) {
            System.arraycopy(board[i], 0, puzzle[i], 0, 9); // Copy the solved board to puzzle
        }

        int cellsToRemove;
        switch (difficulty) {
            case "easy":
                cellsToRemove = 28; // Adjust based on your preference
                break;
            case "medium":
                cellsToRemove = 34;
                break;
            case "intermediate":
                cellsToRemove = 42;
                break;
            case "difficult":
                cellsToRemove = 48;
                break;
            default:
                cellsToRemove = 36;
        }

        Random rand = new Random();
        while (cellsToRemove > 0) {
            int row = rand.nextInt(9);
            int col = rand.nextInt(9);
            if (puzzle[row][col] != 0) { // Only remove filled cells
                puzzle[row][col] = 0; // Remove the cell
                cellsToRemove--;
            }
        }

        return puzzle; // Return the puzzle with cells removed
    }

    private boolean isValidPlacement(int[][] board, int number, int row, int col) {
        // Check if number is not in the same row
        for (int i = 0; i < 9; i++) {
            if (board[row][i] == number) {
                return false;
            }
        }

        // Check if number is not in the same column
        for (int i = 0; i < 9; i++) {
            if (board[i][col] == number) {
                return false;
            }
        }

        // Check if number is not in the same 3x3 box
        int localRow = row - row % 3;
        int localCol = col - col % 3;
        for (int i = localRow; i < localRow + 3; i++) {
            for (int j = localCol; j < localCol + 3; j++) {
                if (board[i][j] == number) {
                    return false;
                }
            }
        }

        return true;
    }

    private int[][] shuffleBoard(int[][] board) {
        // Shuffle rows and columns in each 3x3 box
        Random rand = new Random();

        // Shuffle rows within each box
        for (int i = 0; i < 3; i++) {
            int row1 = i * 3 + rand.nextInt(3);
            int row2 = i * 3 + rand.nextInt(3);
            for (int j = 0; j < 9; j++) {
                int temp = board[row1][j];
                board[row1][j] = board[row2][j];
                board[row2][j] = temp;
            }
        }

        // Shuffle columns within each box
        for (int i = 0; i < 3; i++) {
            int col1 = i * 3 + rand.nextInt(3);
            int col2 = i * 3 + rand.nextInt(3);
            for (int j = 0; j < 9; j++) {
                int temp = board[j][col1];
                board[j][col1] = board[j][col2];
                board[j][col2] = temp;
            }
        }

        return board; // Return the shuffled board
    }

    private int saveGameToDatabase(int[][] puzzle, int[][] solvedBoard, String difficulty, HttpSession session) {
        int gameId = 0;
        StringBuilder puzzleString = new StringBuilder();
        StringBuilder solvedBoardString = new StringBuilder();

        // Create string representations of the board
        for (int[] row : puzzle) {
            for (int num : row) {
                puzzleString.append(num).append(",");
            }
            puzzleString.append(";");
        }
        
        for (int[] row : solvedBoard) {
            for (int num : row) {
                solvedBoardString.append(num).append(",");
            }
            solvedBoardString.append(";");
        }

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
                 PreparedStatement stmt = conn.prepareStatement("INSERT INTO sudoku_games (user_id, board, original_board, difficulty, hints_used, score) VALUES (?, ?, ?, ?, ?, ?)", PreparedStatement.RETURN_GENERATED_KEYS)) {

                Integer userId = (Integer) session.getAttribute("userId"); // Retrieve user ID from session
                System.out.println("User ID from session: " + userId); // Debug output

                if (userId == null) {
                    throw new ServletException("User ID is not set in session.");
                }
                stmt.setInt(1, userId); // Set user ID in the prepared statement
                stmt.setString(2, solvedBoardString.toString().trim());
                stmt.setString(3, puzzleString.toString().trim());
                stmt.setString(4, difficulty);
                stmt.setInt(5, 0); // Hints used
                stmt.setInt(6, 0); // Score
                stmt.executeUpdate();

                try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        gameId = generatedKeys.getInt(1);
                    }
                }
            }
        } catch (ClassNotFoundException | SQLException | ServletException e) {
            e.printStackTrace();
        }

        return gameId;
    }

    private String convertBoardToString(int[][] board) {
        StringBuilder boardString = new StringBuilder();
        for (int[] row : board) {
            for (int num : row) {
                boardString.append(num).append(",");
            }
            boardString.deleteCharAt(boardString.length() - 1); // Remove the last comma
            boardString.append(";"); // Separate rows
        }
        boardString.deleteCharAt(boardString.length() - 1); // Remove the last semicolon
        return boardString.toString();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}
