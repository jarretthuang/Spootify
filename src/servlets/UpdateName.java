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

@WebServlet(name = "UpdateName", urlPatterns = {"/UpdateName"})
public class UpdateName extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String newName = request.getParameter("newName");
        int userId = Integer.parseInt(request.getParameter("userId"));
        Connection connection = null;

        String query = "UPDATE spootify.SpootifyUser SET spootify.SpootifyUser.name = ? WHERE spootify.SpootifyUser.userId = ?";

        try {
            connection = DBConnection.getConnection();

            if (connection != null) {
                PreparedStatement statement = connection.prepareStatement(query);
                statement.setString(1, newName);
                statement.setInt(2, userId);

                statement.executeUpdate();

            } else {
                System.out.println("CANT");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        request.getSession().setAttribute("updateName", "Name updated!");
        request.getSession().setAttribute("userID", userId);
        request.getRequestDispatcher("/viewProfile.jsp").forward(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
