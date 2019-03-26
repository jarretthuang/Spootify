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

@WebServlet(name = "CheckBalance", urlPatterns = {"/CheckBalance"})
public class CheckBalance extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Connection connection = null;
        int guestId = Integer.parseInt(request.getParameter("guestId"));
        int balance = -1;

        String getBalance = "SELECT * FROM Guest WHERE Guest.userId = ?";

        try {
            connection = DBConnection.getConnection();

            if (connection != null) {
                PreparedStatement statement = connection.prepareStatement(getBalance);
                statement.setInt(1, guestId);
                ResultSet rs = statement.executeQuery();
                if (rs.next()) {
                    balance = rs.getInt("balance");
                }

                request.getSession().setAttribute("balance", balance);
                request.getSession().setAttribute("guestId", guestId);
                request.getRequestDispatcher("/guest.jsp").forward(request, response);
            }


        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
