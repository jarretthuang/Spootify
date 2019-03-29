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

@WebServlet(name = "AddTrack", urlPatterns = {"/AddTrack"})
public class AddTrack extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String[] selectedTracks = request.getParameterValues("track");
        int userId = Integer.parseInt(request.getParameter("userId").trim());
        String imgURL = request.getParameter("profilePic");

        if (selectedTracks == null) {
            request.getSession().setAttribute("failure", "No tracks selected");
            request.getSession().setAttribute("userId", userId);
            request.getSession().setAttribute("profilePic", imgURL);
            request.getRequestDispatcher("/viewProfile.jsp").forward(request, response);
        }

        Connection connection = null;

        String query = "INSERT IGNORE INTO spootify.StoresTrack VALUES (?,?)";

        try {
            connection = DBConnection.getConnection();

            if (connection != null) {

                for (String track: selectedTracks) {
                    int trackId = Integer.parseInt(track);
                    PreparedStatement statement = connection.prepareStatement(query);
                    statement.setInt(1, userId);
                    statement.setInt(2, trackId);

                    statement.executeUpdate();

                }


            }

            request.getSession().setAttribute("success", "Added all selected tracks!");
            request.getSession().setAttribute("userId", userId);
            request.getSession().setAttribute("profilePic", imgURL);
            request.getRequestDispatcher("/viewTracks.jsp").forward(request, response);

        } catch (SQLException e) {

        }

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
