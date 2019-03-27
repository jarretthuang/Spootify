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

<label for="divisor">Choose tracks that: </label>
<form action="DivisionExample" method="post">
    <select name = "divisor" id="divisor">
        <option value = "playlist">are in every playlist</option>
        <option value = "user">are stored by every user</option>
        <option value = "artist">are created by every artist</option>
    </select>
    <input type="hidden" name="userId" value="${userId}" />
    <input type="submit" name="btnsbmt" id="btnsbmt" />
</form>

</body>
</html>
