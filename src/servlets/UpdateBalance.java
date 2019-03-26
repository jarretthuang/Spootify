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
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet(name = "UpdateBalance", urlPatterns = {"/UpdateBalance"})
public class UpdateBalance extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Connection connection = null;
        int guestId = Integer.parseInt(request.getParameter("guestId"));
        double newBalance = Double.parseDouble(request.getParameter("newBalance"));

        String setBalance = "UPDATE spootify.Guest SET spootify.Guest.balance = ? WHERE spootify.Guest.userId = ?";

        try {
            connection = DBConnection.getConnection();

            if (connection != null) {
                PreparedStatement statement = connection.prepareStatement(setBalance);
                statement.setDouble(1, newBalance);
                statement.setInt(2, guestId);

                statement.executeUpdate();


                request.getSession().setAttribute("newBalance", newBalance);
                request.getRequestDispatcher("/guest.jsp").forward(request, response);
            }


        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
