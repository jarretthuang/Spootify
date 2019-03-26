package servlets;

import Utility.DBConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Random;

@WebServlet(name = "RegisterGuest", urlPatterns = {"/RegisterGuest"})
public class RegisterGuest extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Random rand = new Random();
        int guestId = rand.nextInt(100000000);
        String name = request.getParameter("userName");

        Connection connection = null;

        String queryUser = "INSERT INTO SpootifyUser VALUES (?,?,NULL)";
        String queryGuest = "INSERT INTO Guest VALUES (?,0)";

        try {
            connection = DBConnection.getConnection();

            if (connection != null) {
                PreparedStatement statement1 = connection.prepareStatement(queryUser);
                statement1.setInt(1, guestId);
                statement1.setString(2, name);
                statement1.executeUpdate();

                PreparedStatement statement2 = connection.prepareStatement(queryGuest);
                statement2.setInt(1, guestId);
                statement2.executeUpdate();

            }

            request.getSession().setAttribute("guestId", guestId);
            request.getRequestDispatcher("/guest.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
