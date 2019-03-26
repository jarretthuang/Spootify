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

@WebServlet(name = "ViewTracksByArtist")
public class ViewTracksByArtist extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Connection connection = null;
        String artist = request.getParameter("artistSong");
        int userId = Integer.parseInt(request.getParameter("userId").trim());
        ResultSet rs;
        ArrayList<TrackObj> tracks = new ArrayList<>();

        String getSongs = "SELECT * " +
                "FROM Track, CreatesTrack, Artist2 " +
                "WHERE Track.trackId = CreatesTrack.trackId AND CreatesTrack.artistId = Artist2.artistId " +
                "AND Artist2.name LIKE ?";

        try {
            connection = DBConnection.getConnection();

            if (connection != null) {
                PreparedStatement statement = connection.prepareStatement(getSongs);
                statement.setString(1, "%" + artist + "%");
                rs = statement.executeQuery();

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

                request.getSession().setAttribute("artistTracks", tracks);
                request.getSession().setAttribute("userId", userId);
                request.getRequestDispatcher("/viewProfile.jsp").forward(request, response);
            }


        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
