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
<%

    if (request.getParameter("userID") != null) {
        request.getSession().setAttribute("userId", request.getParameter("userID"));
    }

%>
<body>
<form id="followPlaylist" name="followPlaylist" method="post" action="FollowPlaylist">
    <input type="hidden" name="userId" value="${userId}">
<table>
    <tr>
        <th>Playlist ID</th>
        <th>Playlist Description</th>
        <th>Public</th>
        <th>Number of Songs</th>
    </tr>
    <c:forEach items="${playlists}" var="item" varStatus="loop">
        <tr>
            <td>${item.getPlaylistId()}</td>
            <td>${item.getDescription()}</td>
            <td>${item.isPublic()}</td>
            <td>${numSongs[loop.index]}</td>
            <td><div class="checkbox">
                <label><input type="checkbox" name="followPlaylist" value="${item.getPlaylistId()}"></label></div></td>
        </tr>
    </c:forEach>
</table>
    <input type="hidden" name="userId" value="${userId}">
    <input type="submit" value="Follow Playlists" />
</form>
<c:if test="${successFollow ne null}">
    <td>${successFollow}</td>
</c:if>
<c:if test="${failureFollow ne null}">
    <td>${failureFollow}</td>
</c:if>
</body>
</html>
