package servlets;

import Utility.DBConnection;
import model.TrackObj;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class MostSavedTrack extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


        Connection connection = null;

        String query = "SELECT t.trackId, t.name, t.duration, t.popularity" +
                "FROM Track t, StoresTrack st, SpootifyUser u " +
                "WHERE t.trackId = st.trackId " +
                "AND u.userId = st.userId\n" +
                "GROUP BY t.trackId " +
                "HAVING COUNT(*) > ALL (SELECT COUNT(*) FROM StoresTrack WHERE t.trackId != trackId GROUP BY trackId);";

        TrackObj track = new TrackObj();

        try {
            connection = DBConnection.getConnection();

            if (connection != null) {

                PreparedStatement statement = connection.prepareStatement(query);

                ResultSet rs = statement.executeQuery();


                track.setTrackId(rs.getInt("trackId"));
                track.setName(rs.getString("name"));
                track.setDuration(rs.getInt("duration"));
                track.setPopularity(rs.getInt("popularity"));




            }

            request.getSession().setAttribute("track", track);
            request.getRequestDispatcher("/viewProfile.jsp").forward(request, response);

        } catch (SQLException e) {

        }

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

}