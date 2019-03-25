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
import java.sql.Statement;

@WebServlet(name = "RegisterUser", urlPatterns = {"/RegisterUser"})
public class RegisterUser extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("userName");
        String subscription = request.getParameter("subscriptionType");
        double monthlyRate = subscription.equals("Family") ? 12.00 : 15.00;
        int cardNumber = Integer.parseInt(request.getParameter("cardNumber"));
        int userId = Math.abs(name.hashCode() + cardNumber + subscription.hashCode() % 10000000);
        String imgURL = "http";
        Connection connection = null;

        String query = "INSERT INTO spootify.SpootifyUser VALUES (?,?,?)";
        String querySubscriber = "INSERT INTO Subscriber VALUES (?,?,?)";
        String queryBillingInfo = "INSERT INTO BillingInfo VALUES (?,?)";

        try {
            connection = DBConnection.getConnection();

            if (connection != null) {

                Statement stmt = connection.createStatement();
                stmt.execute("SET FOREIGN_KEY_CHECKS=0");

                PreparedStatement statement = connection.prepareStatement(query);
                statement.setInt(1, userId);
                statement.setString(2, name);
                statement.setString(3, imgURL);

                PreparedStatement statement1 = connection.prepareStatement(querySubscriber);
                statement1.setInt(1, userId);
                statement1.setString(2, subscription);
                statement1.setInt(3, cardNumber);

                PreparedStatement statement2 = connection.prepareStatement(queryBillingInfo);
                statement2.setInt(1, cardNumber);
                statement2.setDouble(2, monthlyRate);

                statement.executeUpdate();
                statement1.executeUpdate();
                statement2.executeUpdate();


                stmt = connection.createStatement();
                stmt.execute("SET FOREIGN_KEY_CHECKS=1");
                stmt.close();

            } else {
                System.out.println("CANT");
            }

            request.setAttribute("userId", userId);
            request.getRequestDispatcher("/successRegister.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
