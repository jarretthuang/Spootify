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
    <title>Spootify - Search Songs</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="shortcut icon" genre="image/x-icon" href="img/favicon.ico">
    <title>Spootify</title>
    <meta name="description" content="Discover music like never before!">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/frontend/assets/css/main.css" genre="text/css">
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="${pageContext.request.contextPath}/frontend/assets/javascript/jquery-3.2.1.min.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script src="${pageContext.request.contextPath}/frontend/assets/javascript/main.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.css"/>

    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/frontend/assets/css/animate.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/frontend/assets/select2/select2.min.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/frontend/assets/perfect-scrollbar/perfect-scrollbar.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/frontend/assets/css/util.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/frontend/assets/css/table.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/frontend/assets/fonts/font-awesome-4.7.0/css/font-awesome.min.css">
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

<label for="field">Sort tracks by: </label>
<form action="SortTracks" method="post">
    <select name = "field" id="field">
        <option value = "liveliness">liveliness</option>
        <option value = "speechiness">speechiness</option>
        <option value = "danceability">danceability</option>
        <option value = "instrumentalness">instrumentalness</option>
        <option value = "energy">energy</option>
        <option value = "analyticsKey">key</option>
        <option value = "loudness">loudness</option>
        <option value = "tempo">tempo</option>
    </select>

    <label for="order">in </label>
    <select name = "order" id="order">
        <option value = "ASC">ascending order</option>
        <option value = "DESC">descending order</option>
    </select>

    <input type="hidden" name="userId" value="${userId}" />
    <input type="submit" name="btn" id="btn" />
</form>

</body>
</html>


