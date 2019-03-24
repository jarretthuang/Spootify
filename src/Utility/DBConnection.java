package Utility;

import java.sql.Connection;
import java.sql.DriverManager;


public class DBConnection {

    public static Connection getConnection() {
        Connection connection =  null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/spootify?" +
                            "useUnicode=true&useJDBCCompliantTimezoneShift=true&" +
                            "useLegacyDatetimeCode=false&serverTimezone=UTC","root",
            "Chocolate1@b");


        } catch (Exception e) {
            e.printStackTrace();
        }

        return connection;
    }

}

