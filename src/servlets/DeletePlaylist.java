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

@WebServlet(name = "DeletePlaylist")
public class DeletePlaylist extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String[] selectedTracks = request.getParameterValues("deletePlaylist");
        int userId = Integer.parseInt(request.getParameter("userId"));
        String imgURL = request.getParameter("profilePic");

        if (selectedTracks == null) {
            request.getSession().setAttribute("failureDeletePlaylist", "No playlists selected");
            request.getSession().setAttribute("userId", userId);
            request.getRequestDispatcher("/viewProfile.jsp").forward(request, response);
        }

        Connection connection = null;

        String deletePlaylist = "DELETE FROM Playlist WHERE Playlist.playlistId = ?";


        try {
            connection = DBConnection.getConnection();

            if (connection != null) {

                for (String track: selectedTracks) {
                    int playlistId = Integer.parseInt(track);
                    PreparedStatement statement = connection.prepareStatement(deletePlaylist);
                    statement.setInt(1, playlistId);

                    statement.executeUpdate();

                }

            }

            request.getSession().setAttribute("successDeletePlaylist", "Deleted selected playlists!");
            request.getSession().setAttribute("userId", userId);
            request.getSession().setAttribute("profilePic", imgURL);
            request.getRequestDispatcher("/viewProfile.jsp").forward(request, response);

        } catch (SQLException e) {

        }

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
