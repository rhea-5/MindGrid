import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie; // Added for Cookie handling
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LoginServlet extends HttpServlet {

    private final String DB_URL = "jdbc:mysql://localhost:3306/sudoku_game"; // Database URL
    private final String DB_USER = "root"; // Database username
    private final String DB_PASSWORD = "Pondy@2023"; // Database password

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        // Retrieve parameters from login form
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try (PrintWriter out = response.getWriter()) {
            // Validate user and get user ID
            int userId = validateUser(username, password);
            if (userId != -1) {
                // User exists, create a session and store user ID and username
                HttpSession session = request.getSession();
                session.setAttribute("username", username);
                session.setAttribute("userId", userId); // Store user ID in the session

                // Create a cookie to store the username (or any other data you want)
                Cookie usernameCookie = new Cookie("username", username);
                usernameCookie.setMaxAge(60 * 60 * 24); // Cookie will last 1 day
                response.addCookie(usernameCookie); // Add the cookie to the response
                
                // Debugging statements (optional)
                System.out.println("User ID retrieved from database: " + userId);
                System.out.println("User ID stored in session: " + session.getAttribute("userId"));

                // Redirect to home page on success
                response.sendRedirect("home.jsp");
            } else {
                // Invalid credentials, redirect to login page with error
                response.sendRedirect("login.jsp?error=Invalid username or password.");
            }
        }
    }

    // Method to validate user credentials and return user ID
    private int validateUser(String username, String password) {
        int userId = -1; // Initialize user ID as -1 (indicating invalid user)
        try {
            // Load the MySQL driver
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
                 PreparedStatement stmt = conn.prepareStatement("SELECT user_id FROM users WHERE username = ? AND password = ?")) {

                // Set query parameters
                stmt.setString(1, username);
                stmt.setString(2, password);

                // Execute query
                ResultSet rs = stmt.executeQuery();
                if (rs.next()) {
                    userId = rs.getInt("user_id"); // Get the user ID from the result set
                }
            }
        } catch (Exception e) {
            e.printStackTrace(); // Log the exception
        }
        return userId;
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

    @Override
    public String getServletInfo() {
        return "Login Servlet";
    }
}
