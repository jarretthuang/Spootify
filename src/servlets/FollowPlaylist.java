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

@WebServlet(name = "FollowPlaylist")
public class FollowPlaylist extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String[] selectedPlaylists = request.getParameterValues("followPlaylist");
        int userId = Integer.parseInt(request.getParameter("userId"));
        String profilePic = request.getParameter("profilePic");
        if (selectedPlaylists == null) {
            request.getSession().setAttribute("failureFollow", "No playlists selected");
            request.getSession().setAttribute("profilePic", profilePic);
            request.getSession().setAttribute("userId", userId);
            request.getRequestDispatcher("/searchPlaylists.jsp").forward(request, response);
        }

        Connection connection = null;

        String addTrackToPlaylist = "INSERT IGNORE INTO spootify.FollowsPlaylist VALUES (?,?)";

        try {
            connection = DBConnection.getConnection();

            if (connection != null) {

                for (String track: selectedPlaylists) {
                    int playlistId = Integer.parseInt(track);
                    PreparedStatement statement = connection.prepareStatement(addTrackToPlaylist);
                    statement.setInt(1, playlistId);
                    statement.setInt(2, userId);

                    statement.executeUpdate();

                }

            }

            request.getSession().setAttribute("successFollow", "You're now following the selected playlists!");
            request.getSession().setAttribute("userId", userId);
            request.getSession().setAttribute("profilePic", profilePic);
            request.getRequestDispatcher("/searchPlaylists.jsp").forward(request, response);

        } catch (SQLException e) {
            request.getSession().setAttribute("failureCreate", "Playlist with this description already exists");
        }

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
