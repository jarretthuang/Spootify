package servlets;

import Utility.DBConnection;
import model.Artist;

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

@WebServlet(name = "SearchArtists")
public class SearchArtists extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Connection connection = null;
        String artistName = request.getParameter("artist");
        int userId = Integer.parseInt(request.getParameter("userId"));
        String profilePic = request.getParameter("profilePic");
        ResultSet rs;
        ArrayList<Artist> artists = new ArrayList<>();

        String getSongs = "SELECT Artist2.name AS \"Artist Name\", Artist1.genre AS Genre "+
                "FROM Artist2 " +
                "LEFT JOIN Artist1 " +
                "ON Artist2.imageURL = Artist1.imageURL " +
                "WHERE Artist2.name LIKE ?";

        try {
            connection = DBConnection.getConnection();

            if (connection != null) {
                PreparedStatement statement = connection.prepareStatement(getSongs);
                statement.setString(1, "%" + artistName + "%");
                rs = statement.executeQuery();

                while (rs.next()) {
                    Artist artist = new Artist();
                    artist.setName(rs.getString("Artist Name"));
                    artist.setGenre(rs.getString("Genre"));
                    artists.add(artist);
                }

                request.getSession().setAttribute("artists", artists);
                request.getSession().setAttribute("userId", userId);
                request.getSession().setAttribute("profilePic", profilePic);
                request.getRequestDispatcher("/searchArtists.jsp").forward(request, response);
            }


        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
