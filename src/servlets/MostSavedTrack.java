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

@WebServlet(name = "MostSavedTrack", urlPatterns = {"MostSavedTrack"})
public class MostSavedTrack extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


        Connection connection = null;
        int userId = Integer.parseInt(request.getParameter("userId"));
        String profilePic = request.getParameter("profilePic");

        String query = "SELECT t.trackId, t.name, t.duration, t.popularity " +
                "FROM Track t, StoresTrack st, SpootifyUser u " +
                "WHERE t.trackId = st.trackId " +
                "AND u.userId = st.userId " +
                "GROUP BY t.trackId " +
                "HAVING COUNT(*) > ALL (SELECT COUNT(*) FROM StoresTrack WHERE t.trackId != trackId GROUP BY trackId);";

        ArrayList<TrackObj> tracks = new ArrayList<>();

        try {
            connection = DBConnection.getConnection();

            if (connection != null) {

                PreparedStatement statement = connection.prepareStatement(query);

                ResultSet rs = statement.executeQuery();

                while (rs.next()) {
                    TrackObj track = new TrackObj();

                    track.setTrackId(rs.getInt("trackId"));
                    track.setName(rs.getString("name"));
                    track.setDuration(rs.getInt("duration"));
                    track.setPopularity(rs.getInt("popularity"));

                    tracks.add(track);

                }

            }

            request.getSession().setAttribute("mostSavedTrack", tracks);
            request.getSession().setAttribute("userId", userId);
            request.getSession().setAttribute("profilePic", profilePic);
            request.getRequestDispatcher("/mostSavedTrack.jsp").forward(request, response);

        } catch (SQLException e) {

        }

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

}