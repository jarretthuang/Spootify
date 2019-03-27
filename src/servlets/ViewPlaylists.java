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

@WebServlet(name = "ViewPlaylists", urlPatterns = {"ViewPlaylists"})
public class ViewPlaylists extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Connection connection = null;
        int userId = Integer.parseInt(request.getParameter("userId"));
        ResultSet rs;
        ArrayList<PlayList> playlists = new ArrayList<>();
        ArrayList<Integer> numSongs = new ArrayList<>();

        String getPlaylistsFromUserView = "CREATE OR REPLACE VIEW playlists_user_follows AS " +
                "SELECT Playlist.playlistId, Playlist.description, Playlist.isPublic, FollowsPlaylist.userId " +
                "FROM Playlist, FollowsPlaylist " +
                "WHERE Playlist.playlistId = FollowsPlaylist.playlistId";

        String getSongs = "SELECT playlists_user_follows.playlistId, playlists_user_follows.description, " +
                "playlists_user_follows.isPublic, COUNT(*) AS NumSongs "+
                "FROM playlists_user_follows, SpootifyUser " +
                "WHERE SpootifyUser.userId = ? AND playlists_user_follows.userId = SpootifyUser.userId " +
                "GROUP BY playlists_user_follows.playlistId, playlists_user_follows.description, playlists_user_follows.isPublic";

        try {
            connection = DBConnection.getConnection();

            if (connection != null) {
                PreparedStatement statement = connection.prepareStatement(getPlaylistsFromUserView);
                PreparedStatement statement1 = connection.prepareStatement(getSongs);
                statement1.setInt(1, userId);

                statement.executeUpdate();
                rs = statement1.executeQuery();

                while (rs.next()) {
                    PlayList playlist = new PlayList();
                    playlist.setPlaylistId(rs.getInt("playlistId"));
                    playlist.setDescription(rs.getString("description"));
                    playlist.setPublic(rs.getString("isPublic").equals("Y"));
                    playlists.add(playlist);
                    numSongs.add(rs.getInt("NumSongs"));
                }

                request.getSession().setAttribute("userPlaylists", playlists);
                request.getSession().setAttribute("numSongs", numSongs);

                request.getRequestDispatcher("/viewProfile.jsp").forward(request, response);
            }


        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
