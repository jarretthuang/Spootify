<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: ashleybarkworth
  Date: 2019-03-24
  Time: 15:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<table>
    <tr>
        <th>Playlist Description</th>
        <th>Public</th>
        <th>Number of Songs</th>
    </tr>
    <c:forEach items="${playlists}" var="item" varStatus="loop">
        <tr>
            <td>${item.getDescription()}</td>
            <td>${item.isPublic()}</td>
            <td>${numSongs[loop.index]}</td>
        </tr>
    </c:forEach>
</table>
</body>
</html>
