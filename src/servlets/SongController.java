package servlets;

import Utility.DBConnection;

import java.sql.*;

public class SongController {

    public boolean retrieveTracksForUser(int userId) {
        Connection connection = null;

        String query = "SELECT * " +
                "FROM Track, spootify.StoresTrack, SpootifyUser " +
                "WHERE Track.trackId = spootify.StoresTrack.trackId AND spootify.StoresTrack.userId = ?";

        try {
            connection  = DBConnection.getConnection();

            if (connection != null) {
                PreparedStatement statement = connection.prepareStatement(query);
                statement.setInt(1, userId);
                ResultSet rs = statement.executeQuery();

                while (rs.next()) {
                    String name = rs.getString("name");
                }
            } else {
                System.out.println("CANT");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return true;

    }
}
