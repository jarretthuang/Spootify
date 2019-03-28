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

@WebServlet(name = "DivisionExample")
public class DivisionExample extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int userId = Integer.parseInt(request.getParameter("userId"));
        String divisor = request.getParameter("divisor");
        String profilePic = request.getParameter("profilePic");
        ArrayList<TrackObj> tracks = new ArrayList<>();
        String division = "";

        if (divisor.equals("playlist")) {
            division = "SELECT * " +
                    "FROM Track t " +
                    "WHERE NOT EXISTS " +
                    "(SELECT p.playlistId " +
                    "FROM Playlist p " +
                    "WHERE NOT EXISTS " +
                    "(SELECT TrackInPlaylist.playlistId " +
                    "FROM TrackInPlaylist " +
                    "WHERE TrackInPlaylist.trackId = t.trackId " +
                    "AND TrackInPlaylist.playlistId = p.playlistId))";
        } else if (divisor.equals("artist")) {
            division = "SELECT * " +
                    "FROM Track t " +
                    "WHERE NOT EXISTS " +
                    "(SELECT Artist1.artistId " +
                    "From Artist1 a" +
                    "WHERE NOT EXISTS " +
                    "(SELECT CreatesTrack.artistId " +
                    "FROM CreatesTrack " +
                    "WHERE CreatesTrack.trackId = t.trackId AND CreatesTrack.artistId = a.artistId))";
        } else {
            division = "SELECT * " +
                    "FROM Track t " +
                    "WHERE NOT EXISTS" +
                    "(SELECT SpootifyUser.userId " +
                    "FROM SpootifyUser u" +
                    "WHERE NOT EXISTS " +
                    "(SELECT StoresTrack.userId " +
                    "FROM StoresTrack " +
                    "WHERE StoresTrack.trackId = t.trackId AND StoresTrack.userId = u.userId))";
        }

        Connection connection = null;

        try {
            connection = DBConnection.getConnection();

            if (connection != null) {

                PreparedStatement statement = connection.prepareStatement(division);

                ResultSet rs = statement.executeQuery();

                while (rs.next()) {
                    TrackObj track = new TrackObj();
                    track.setTrackId(rs.getInt("trackId"));
                    track.setName(rs.getString("name"));
                    track.setAlbumId(rs.getInt("albumId"));
                    track.setAnalyticsId(rs.getInt("analyticsId"));
                    track.setDuration(rs.getInt("duration"));
                    track.setPopularity(rs.getInt("popularity"));

                    tracks.add(track);
                }

            }

            request.getSession().setAttribute("tracks", tracks);
            request.getSession().setAttribute("userId", userId);
            request.getSession().setAttribute("profilePic", profilePic);
            request.getRequestDispatcher("/searchTracks.jsp").forward(request, response);

        } catch (SQLException e) {
            request.getSession().setAttribute("failureCreate", "Playlist with this description already exists");
        }

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
