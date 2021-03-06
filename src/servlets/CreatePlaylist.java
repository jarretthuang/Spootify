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

@WebServlet(name = "CreatePlaylist")
public class CreatePlaylist extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String[] selectedTracks = request.getParameterValues("trackPlaylist");
        int userId = Integer.parseInt(request.getParameter("userId"));
        String profilePic = request.getParameter("profilePic");


        if (selectedTracks == null) {
            request.getSession().setAttribute("failure", "No tracks selected");
            request.getSession().setAttribute("userId", userId);
            request.getSession().setAttribute("profilePic", profilePic);
            request.getRequestDispatcher("/viewProfile.jsp").forward(request, response);
        }

        String description = request.getParameter("description").trim();
        int playlistId = Math.abs(description.hashCode());
        Connection connection = null;

        String addPlaylist = "INSERT INTO Playlist VALUES (?,\'Y\',\'" + description + "\')";
        String addTrackToPlaylist = "INSERT IGNORE INTO spootify.TrackInPlaylist VALUES (?,?)";
        String followPlaylist = "INSERT IGNORE INTO spootify.FollowsPlaylist VALUES (?,?)";


        try {
            connection = DBConnection.getConnection();

            if (connection != null) {

                PreparedStatement addPlaylistStatement = connection.prepareStatement(addPlaylist);
                addPlaylistStatement.setInt(1, playlistId);

                addPlaylistStatement.executeUpdate();

                for (String track: selectedTracks) {
                    int trackId = Integer.parseInt(track);
                    PreparedStatement statement = connection.prepareStatement(addTrackToPlaylist);
                    statement.setInt(1, trackId);
                    statement.setInt(2, playlistId);

                    statement.executeUpdate();

                }

                PreparedStatement statement = connection.prepareStatement(followPlaylist);
                statement.setInt(1, playlistId);
                statement.setInt(2, userId);

                statement.executeUpdate();

            }

            request.getSession().setAttribute("successCreate", "Created new playlist!");
            request.getSession().setAttribute("playlistId", playlistId);
            request.getSession().setAttribute("userId", userId);
            request.getSession().setAttribute("profilePic", profilePic);
            request.getRequestDispatcher("/viewTracks.jsp").forward(request, response);

        } catch (SQLException e) {
            request.getSession().setAttribute("failureCreate", "Playlist with this description already exists");
        }

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
