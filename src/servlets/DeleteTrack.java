package servlets;

import Utility.DBConnection;
import model.TrackObj;

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
import java.util.ArrayList;

@WebServlet(name = "DeleteTrack")
public class DeleteTrack extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String[] selectedTracks = request.getParameterValues("track");
        int userId = Integer.parseInt(request.getParameter("userId").trim());
        String imgURL = request.getParameter("profilePic");

        if (selectedTracks == null) {
            request.getSession().setAttribute("failureDelete", "No tracks selected");
            request.getSession().setAttribute("userId", userId);
            request.getRequestDispatcher("/viewProfile.jsp").forward(request, response);
        }

        Connection connection = null;

        String query = "DELETE FROM StoresTrack WHERE StoresTrack.trackId = ? AND StoresTrack.userId = ?";

        try {
            connection = DBConnection.getConnection();

            if (connection != null) {

                for (String track: selectedTracks) {
                    int trackId = Integer.parseInt(track);
                    PreparedStatement statement = connection.prepareStatement(query);
                    statement.setInt(1, trackId);
                    statement.setInt(2, userId);

                    statement.executeUpdate();

                }


            }

            request.getSession().setAttribute("successDelete", "Deleted all selected tracks!");
            request.getSession().setAttribute("userId", userId);
            request.getSession().setAttribute("profilePic", imgURL);
            request.getRequestDispatcher("/viewProfile.jsp").forward(request, response);

        } catch (SQLException e) {

        }

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
