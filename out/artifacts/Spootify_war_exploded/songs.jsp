<%@ page import="servlets.SongController" %><%--
  Created by IntelliJ IDEA.
  User: ashleybarkworth
  Date: 2019-03-23
  Time: 15:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Songs</title>
</head>
<body>
    <%
        int userID = Integer.parseInt(request.getParameter("userID"));
        SongController sc = new SongController();
        sc.retrieveTracksForUser(userID);
    %>

    <h2>The text entered was : </h2><%=userID%>

</body>
</html>
