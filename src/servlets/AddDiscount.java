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

@WebServlet(name = "AddDiscount", urlPatterns = {"/AddDiscount"})
public class AddDiscount extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Connection connection = null;
        int userId = Integer.parseInt(request.getParameter("userId"));
        String discount = request.getParameter("discount");
        String query = "";

        try {
            connection = DBConnection.getConnection();

            if (connection != null) {

                if (discount.equals("Student")) {
                    query = "UPDATE Subscriber, spootify.SpootifyUser " +
                            "SET Subscriber.monthlyRate = 5.99 " +
                            "WHERE Subscriber.userId = spootify.SpootifyUser.userId " +
                            "AND spootify.SpootifyUser.userId = ?";
                } else if (discount.equals("Military")) {
                    query = "UPDATE Subscriber, spootify.SpootifyUser " +
                            "SET Subscriber.monthlyRate = 7.99 " +
                            "WHERE Subscriber.userId = spootify.SpootifyUser.userId " +
                            "AND spootify.SpootifyUser.userId = ?";
                } else {
                    query = "UPDATE Subscriber, spootify.SpootifyUser " +
                            "SET Subscriber.monthlyRate = 9.99 " +
                            "WHERE Subscriber.userId = spootify.SpootifyUser.userId " +
                            "AND spootify.SpootifyUser.userId = ?";
                }

                try {
                    PreparedStatement statement = connection.prepareStatement(query);
                    statement.setInt(1, userId);
                    statement.executeUpdate();
                } catch (SQLException e) {
                    e.printStackTrace();
                }

            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
