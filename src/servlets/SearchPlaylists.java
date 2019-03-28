package servlets;

import Utility.DBConnection;
import model.PlayList;

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

@WebServlet(name = "SearchPlaylists", urlPatterns = {"SearchPlaylists"})
public class SearchPlaylists extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Connection connection = null;
        String playlistDescription = request.getParameter("playlist");
        String profilePic = request.getParameter("profilePic");
        int userId = Integer.parseInt(request.getParameter("userId"));
        ResultSet rs;
        ArrayList<PlayList> playlists = new ArrayList<>();
        ArrayList<Integer> numSongs = new ArrayList<>();

        String getSongs = "SELECT Playlist.playlistId, Playlist.description, Playlist.isPublic, COUNT(*) AS NumSongs "+
                "FROM Playlist " +
                "LEFT JOIN spootify.TrackInPlaylist ON Playlist.playlistId = spootify.TrackInPlaylist.playlistId " +
                "WHERE Playlist.description LIKE ? " +
                "GROUP BY Playlist.playlistId, Playlist.description, Playlist.isPublic";

        try {
            connection = DBConnection.getConnection();

            if (connection != null) {
                PreparedStatement statement = connection.prepareStatement(getSongs);
                statement.setString(1, "%" + playlistDescription + "%");
                rs = statement.executeQuery();

                while (rs.next()) {
                    PlayList playlist = new PlayList();
                    playlist.setPlaylistId(rs.getInt("playlistId"));
                    playlist.setDescription(rs.getString("description"));
                    playlist.setPublic(rs.getString("isPublic").equals("Y"));
                    playlists.add(playlist);
                    numSongs.add(rs.getInt("NumSongs"));
                }

                request.getSession().setAttribute("playlists", playlists);
                request.getSession().setAttribute("numSongs", numSongs);
                request.getSession().setAttribute("userId", userId);
                request.getSession().setAttribute("profilePic", profilePic);
                request.getRequestDispatcher("/searchPlaylists.jsp").forward(request, response);
            }


        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
