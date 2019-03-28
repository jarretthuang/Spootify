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

@WebServlet(name = "SortTracks", urlPatterns = {"SortTracks"})
public class SortTracks extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Connection connection = null;
        String field = request.getParameter("field");
        String order = request.getParameter("order");
        String trackName = request.getParameter("trackName");
        String profilePic = request.getParameter("profilePic");
        int userId = Integer.parseInt(request.getParameter("userId"));
        ResultSet rs;
        ArrayList<TrackObj> tracks = new ArrayList<>();

        String getSongs = "SELECT * " +
                "FROM Track, Analytics " +
                "WHERE Track.trackId = Analytics.trackId " +
                "AND Track.name LIKE ? " +
                "ORDER BY " + "Analytics." + field + " " + order;

        try {
            connection = DBConnection.getConnection();

            if (connection != null) {
                PreparedStatement statement = connection.prepareStatement(getSongs);
                statement.setString(1, "%" + trackName + "%");
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

                request.getSession().setAttribute("tracks", tracks);
                request.getSession().setAttribute("trackName", trackName);
                request.getSession().setAttribute("userId", userId);
                request.getSession().setAttribute("profilePic", profilePic);
                request.getRequestDispatcher("/searchTracks.jsp").forward(request, response);
            }


        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
