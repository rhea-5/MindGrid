import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class ProfileServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Set response content type
        response.setContentType("text/html;charset=UTF-8");

        // Get the current user's ID from the session
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        // Redirect to login if user is not logged in
        if (userId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Database connection details
        String url = "jdbc:mysql://localhost:3306/sudoku_game";
        String dbUsername = "root";
        String dbPassword = "Pondy@2023"; // Change this to your actual password

        // Variables to store user and game information
        String name = "", email = "", username = "", contact = "";
        StringBuilder gameHistoryTable = new StringBuilder();

        try (Connection conn = DriverManager.getConnection(url, dbUsername, dbPassword)) {
            // Retrieve user profile details
            String userQuery = "SELECT name, email, username, contact FROM users WHERE user_id = ?";
            try (PreparedStatement userStmt = conn.prepareStatement(userQuery)) {
                userStmt.setInt(1, userId);
                ResultSet userRs = userStmt.executeQuery();

                if (userRs.next()) {
                    name = userRs.getString("name");
                    email = userRs.getString("email");
                    username = userRs.getString("username");
                    contact = userRs.getString("contact");
                }
            }

            // Retrieve all games played by the user
            String gameQuery = "SELECT id, difficulty, hints_used, score, time_elapsed FROM sudoku_games WHERE user_id = ?";
            try (PreparedStatement gameStmt = conn.prepareStatement(gameQuery)) {
                gameStmt.setInt(1, userId);
                ResultSet gameRs = gameStmt.executeQuery();

                // Build the game history table HTML as a string
                while (gameRs.next()) {
                    gameHistoryTable.append("<tr>");
                    gameHistoryTable.append("<td>").append(gameRs.getInt("id")).append("</td>");
                    gameHistoryTable.append("<td>").append(gameRs.getString("difficulty")).append("</td>");
                    gameHistoryTable.append("<td>").append(gameRs.getInt("hints_used")).append("</td>");
                    gameHistoryTable.append("<td>").append(gameRs.getInt("score")).append("</td>");
                    gameHistoryTable.append("<td>").append(gameRs.getString("time_elapsed")).append("</td>"); // Fetch time_elapsed
                    gameHistoryTable.append("</tr>");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace(); // You can keep this for logging purposes if needed
        }

        // Set user attributes for the JSP page
        request.setAttribute("name", name);
        request.setAttribute("email", email);
        request.setAttribute("username", username);
        request.setAttribute("contact", contact);
        request.setAttribute("gameHistoryTable", gameHistoryTable.toString());

        // Forward to the profile JSP page
        ServletContext context = getServletContext();
        context.getRequestDispatcher("/profile.jsp").forward(request, response);
    }
}
