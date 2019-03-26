<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: ashleybarkworth
  Date: 2019-03-24
  Time: 14:45
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
        <th>TrackId</th>
        <th>AnalyticsId</th>
        <th>AlbumId</th>
        <th>Name</th>
        <th>Duration</th>
        <th>Popularity</th>
    </tr>
    <c:forEach items="${tracks}" var="item">
        <tr>
            <td>${item.getTrackId()}</td>
            <td>${item.getAnalyticsId()}</td>
            <td>${item.getAlbumId()}</td>
            <td>${item.getName()}</td>
            <td>${item.getDuration()}</td>
            <td>${item.getPopularity()}</td>
        </tr>
    </c:forEach>
</table>

<h3>Filter Tracks</h3>
<form id="filterTracks" name="filterTracks" method="post" action="FilterTracks">
    <label for="track">Filter by Title: </label><input type="text" id="track" name="track" />
    <label for="track">Filter by Artist: </label><input type="text" id="artist" name="artist" />
    <label for="track">Filter by Album: </label><input type="text" id="album" name="album" />
    <button>Filter</button><br>
</form>

</body>
</html>
