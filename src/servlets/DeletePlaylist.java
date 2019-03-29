package servlets;

import Utility.DBConnection;
import model.TrackObj;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;

@WebServlet(name = "DeletePlaylist")
public class DeletePlaylist extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String[] selectedPlaylists = request.getParameterValues("deletePlaylist");
        int userId = Integer.parseInt(request.getParameter("userId"));
        String imgURL = request.getParameter("profilePic");

        if (selectedPlaylists == null) {
            request.getSession().setAttribute("failureDeletePlaylist", "No playlists selected");
            request.getSession().setAttribute("userId", userId);
            request.getSession().setAttribute("profilePic", imgURL);
            request.getRequestDispatcher("/viewProfile.jsp").forward(request, response);
        }

        Connection connection = null;

        String removeFollowers = "DELETE FROM FollowsPlaylist WHERE FollowsPlaylist.playlistId = ?";
        String removeTracks = "DELETE FROM TrackInPlaylist WHERE TrackInPlaylist.playlistId = ?";

        String deletePlaylist = "DELETE FROM Playlist WHERE Playlist.playlistId = ?";


        try {
            connection = DBConnection.getConnection();

            if (connection != null) {
                Statement stmt = connection.createStatement();
                stmt.execute("SET FOREIGN_KEY_CHECKS=0");


                for (String track: selectedPlaylists) {
                    int playlistId = Integer.parseInt(track);
                    PreparedStatement statement2 = connection.prepareStatement(removeTracks);
                    PreparedStatement statement1 = connection.prepareStatement(removeFollowers);
                    PreparedStatement statement = connection.prepareStatement(deletePlaylist);
                    statement2.setInt(1, playlistId);
                    statement1.setInt(1, playlistId);
                    statement.setInt(1, playlistId);

                    statement2.executeUpdate();
                    statement1.executeUpdate();
                    statement.executeUpdate();

                }

                stmt = connection.createStatement();
                stmt.execute("SET FOREIGN_KEY_CHECKS=1");
                stmt.close();

            }

            request.getSession().setAttribute("successDeletePlaylist", "Deleted selected playlists!");
            request.getSession().setAttribute("userId", userId);
            request.getSession().setAttribute("profilePic", imgURL);
            request.getRequestDispatcher("/viewProfile.jsp").forward(request, response);

        } catch (Exception e) {
            System.out.println("UH oh");
        }

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
