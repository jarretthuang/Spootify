package servlets;

import Utility.DBConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigInteger;
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
        double monthlyRate  = 15.00; // default

        if (discount.equals("Student")) {
            monthlyRate = 5.99;
        } else if (discount.equals("Military")) {
            monthlyRate = 7.99;
        } else {
            monthlyRate = 9.99;
        }

        try {
            connection = DBConnection.getConnection();

            if (connection != null) {

                query = "UPDATE Subscriber " +
                        "SET Subscriber.monthlyRate = ?" +
                        "WHERE Subscriber.userId = ?";

                try {
                    PreparedStatement statement = connection.prepareStatement(query);
                    statement.setDouble(1, monthlyRate);
                    statement.setInt(2, userId);
                    statement.executeUpdate();
                } catch (SQLException e) {
                    e.printStackTrace();
                }

            }

            request.getRequestDispatcher("/viewProfile.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
