<%@ page import="java.sql.Connection" %>
<%@ page import="Utility.DBConnection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.ResultSet" %><%--
  Created by IntelliJ IDEA.
  User: ashleybarkworth
  Date: 2019-03-23
  Time: 19:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>ViewProfile</title>
</head>
<body>

<%
    int userId = Integer.parseInt(request.getParameter("userID"));
    Connection connection = null;
    String userName = "";

    String query = "SELECT * FROM spootify.SpootifyUser WHERE spootify.SpootifyUser.userId = ?";

    try {
        connection = DBConnection.getConnection();

        if (connection != null) {
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setInt(1, userId);
            ResultSet rs = statement.executeQuery();

            if (rs.next()) {
                userName = rs.getString("name");
            }

        }

    } catch (SQLException e) {
        e.printStackTrace();
    }

%>

<h1>Welcome back, <%= userName%></h1>
<form action="UpdateName" method="post">
    Update name:<br>
    <input type="text" id="newName" name="newName">
    <input type="hidden" name="userId" value="<%=userId%>" />
    <br>
    <input type="submit" value="Submit">
</form>
<form action="UpdateProfile" method="post">
    Add/update image:<br>
    <input type="text" id="profilePic" name="profilePic">
    <input type="hidden" name="userId" value="<%=userId%>" />
    <br>
    <input type="submit" value="Submit">
</form>
<form action="AddDiscount" method="post">
    <select name = "dropdown" id="discount" onchange="this.form.submit()">
        <option value = "Student">Student</option>
        <option value = "Military">Military</option>
        <option value = "Family">Family</option>
    </select>
    <input type="hidden" name="userId" value="<%=userId%>" />
</form>


</body>
</html>
