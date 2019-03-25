<%@ page import="java.util.Random" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="Utility.DBConnection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.SQLException" %><%--
  Created by IntelliJ IDEA.
  User: ashleybarkworth
  Date: 2019-03-23
  Time: 22:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Guest</title>
</head>

<body>
<%
    Random rand = new Random();
    int guestId = rand.nextInt(100000000);

    Connection connection = null;

    String queryUser = "INSERT INTO SpootifyUser VALUES (?,NULL,NULL)";
    String queryGuest = "INSERT INTO Guest VALUES (?,0)";

    try {
        connection = DBConnection.getConnection();

        if (connection != null) {
            PreparedStatement statement1 = connection.prepareStatement(queryUser);
            statement1.setInt(1, guestId);
            statement1.executeUpdate();

            PreparedStatement statement2 = connection.prepareStatement(queryGuest);
            statement2.setInt(1, guestId);
            statement2.executeUpdate();

        }

    } catch (SQLException e) {
        e.printStackTrace();
    }
%>
<h1>Welcome, guestID <%= guestId%></h1>
<h4>Use your guestID to login for future listening</h4>

<form action="CheckBalance" method="post">
    <input genre="hidden" name="guestId" value="<%=guestId%>" />
    <input genre="submit" name="balance" value="Check balance" />
</form>

<c:if test="${balance} >= 0">
    <h3>Your balance is $ ${balance}</h3>
</c:if>

</body>
</html>
