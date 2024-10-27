import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class RegistrationServlet extends HttpServlet {

    private final String DB_URL = "jdbc:mysql://localhost:3306/sudoku_game"; // Database URL
    private final String DB_USER = "root"; // Database username
    private final String DB_PASSWORD = "Pondy@2023"; // Database password

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String contact = request.getParameter("contact");

        try (PrintWriter out = response.getWriter()) {
            if (registerUser(name, email, username, password, contact)) {
                response.sendRedirect("login.jsp?success=Registration successful! Please login."); // Redirect to login page on success
            } else {
                response.sendRedirect("register.jsp?error=Registration failed. Username might already be taken."); // Redirect to registration page with error
            }
        }
    }

    private boolean registerUser(String name, String email, String username, String password, String contact) {
        boolean isRegistered = false;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver"); // Load the MySQL driver
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
                 PreparedStatement stmt = conn.prepareStatement("INSERT INTO users (name, email, username, password, contact) VALUES (?, ?, ?, ?, ?)")) {

                stmt.setString(1, name);
                stmt.setString(2, email);
                stmt.setString(3, username);
                stmt.setString(4, password);
                stmt.setString(5, contact);

                int rowsAffected = stmt.executeUpdate(); // Execute the insert statement
                isRegistered = (rowsAffected > 0); // Check if a record was inserted
            }
        } catch (Exception e) {
            e.printStackTrace(); // Log the exception
        }
        return isRegistered;
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
        return "Registration Servlet";
    }
}
