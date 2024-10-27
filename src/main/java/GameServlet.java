import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class GameServlet extends HttpServlet {

    private final String DB_URL = "jdbc:mysql://localhost:3306/sudoku_game";
    private final String DB_USER = "root";
    private final String DB_PASSWORD = "Pondy@2023";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        HttpSession session = request.getSession();
        Integer gameId = (Integer) session.getAttribute("gameId");
        int[][] solvedBoard = (int[][]) session.getAttribute("solvedBoard");
        String difficulty = (String) session.getAttribute("difficulty");

        int hintsUsed = Integer.parseInt(request.getParameter("hintsUsed"));
        int timeElapsed = Integer.parseInt(request.getParameter("timeElapsed"));
        int score = 0;
        int totalEmptyCells = 0;

        String[] userAnswers = request.getParameterValues("userAnswers[]");
        boolean[] hintsUsedForCells = new boolean[81]; // Track hints used for each cell

        if (userAnswers != null && solvedBoard != null) {
            for (int i = 0; i < userAnswers.length; i++) {
                int row = i / 9;
                int col = i % 9;
                int userInput = userAnswers[i].isEmpty() ? 0 : Integer.parseInt(userAnswers[i]);

                if (session.getAttribute("originalBoard") != null) {
                    String originalValue = ((String) session.getAttribute("originalBoard"))
                                            .split(";")[row]
                                            .split(",")[col]
                                            .trim();

                    if (originalValue.equals("0")) {
                        totalEmptyCells++;

                        if (userInput == solvedBoard[row][col]) {
                            score++;
                        }

                        // Check if this cell was a hint
                        if (userInput == 0 && hintsUsed > 0) {
                            hintsUsedForCells[i] = true; // Mark as hint used for this cell
                        }
                    }
                }
            }
        }

        // Subtract points for hints used
        score -= hintsUsed; // Deduct hints from the score
        if (score < 0) {
            score = 0; // Ensure score does not go below zero
        }

        // Save the calculated score, hints used, and time to the database
        saveGameStateToDatabase(gameId, hintsUsed, score, timeElapsed);

        // Set attributes for displaying on the game summary page
        request.setAttribute("score", score);
        request.setAttribute("totalEmptyCells", totalEmptyCells);
        request.setAttribute("hintsUsed", hintsUsed);
        request.setAttribute("timeElapsed", timeElapsed);
        request.setAttribute("difficulty", difficulty);
        request.setAttribute("hintsUsedForCells", hintsUsedForCells); // Pass hints usage to JSP

        // Forward to the game summary JSP page
        request.getRequestDispatcher("gameSummary.jsp").forward(request, response);
    }

    private void saveGameStateToDatabase(Integer gameId, int hintsUsed, int score, int timeElapsed) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
                 PreparedStatement stmt = conn.prepareStatement("UPDATE sudoku_games SET hints_used = ?, score = ?, time_elapsed = ? WHERE id = ?")) {

                stmt.setInt(1, hintsUsed);
                stmt.setInt(2, score);
                stmt.setInt(3, timeElapsed);
                stmt.setInt(4, gameId);
                stmt.executeUpdate();
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
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
