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

@WebServlet(name = "FilterTracks")
public class FilterTracks extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Connection connection = null;
        int userId = Integer.parseInt(request.getParameter("userId"));
        ResultSet rs;
        ArrayList<TrackObj> tracks = new ArrayList<>();

        String filterTracks = "SELECT Track.name AS Track, Track.duration AS Duration, Track.popularity AS Popularity " +
                "FROM Track, StoresTrack, spootify.SpootifyUser, Artist2, Album2, Album1 " +
                "WHERE Track.trackId = StoresTrack.trackId AND StoresTrack.userId = spootify.SpootifyUser.userId " +
                "AND spootify.SpootifyUser.userId = ? " +
                "AND Track.trackId NOT IN (" +
                "(SELECT Track.trackId " +
                "FROM Track, StoresTrack, Album1, Album2 " +
                "WHERE Track.trackId = StoresTrack.trackId " +
                "AND StoresTrack.albumId = Album2.albumId AND Album2.imageURL = Album1.imageURL " +
                "AND Album1.label = ?)" +
                "UNION " +
                "(SELECT Track.trackId " +
                "FROM Track, CreatesTrack, Artist2 " +
                "WHERE Track.trackId = CreatesTrack.trackId AND CreatesTrack.artistId = Artist2.artistId " +
                "AND Artist2.name = ?))";

        try {
            connection = DBConnection.getConnection();

            if (connection != null) {
                PreparedStatement statement = connection.prepareStatement(filterTracks);
                statement.setInt(1, userId);
                rs = statement.executeQuery();

                while (rs.next()) {
                    TrackObj track = new TrackObj();
                    track.setName(rs.getString("Track"));
                    track.setDuration(rs.getInt("Duration"));
                    track.setPopularity(rs.getInt("Popularity"));

                    tracks.add(track);
                }

                request.getSession().setAttribute("tracks", tracks);
                request.getSession().setAttribute("userId", userId);
                request.getRequestDispatcher("/viewTracks.jsp").forward(request, response);
            }


        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
