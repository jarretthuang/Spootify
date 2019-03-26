<%@ page import="java.sql.Connection" %>
<%@ page import="Utility.DBConnection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.ResultSet" %>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>

<%--
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
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.css" />
</head>
<body>


<a href='index.jsp'>
    <div class="hoja small-logo-topleft">
        <img class="music-note-small" src="${pageContext.request.contextPath}/frontend/assets/img/whiteMusicNote.png">
        <div class="spootify-nametag">Spootify</div>
    </div>
</a>
<div class="ui-panel">
    <h1>Welcome back!</h1>
    <form action="UpdateName" method="post">
        Update name:<br>
        <input type="text" id="newName" name="newName">
        <input type="hidden" name="userId" value="<%=request.getParameter("userID")%>" />
        <br>
        <input type="submit" value="Submit">
    </form>

    <c:if test="${updateName ne null}">
        <c:out value="${updateName}"></c:out>
    </c:if>

    <form action="UpdateProfile" method="post">
        Add/update image:<br>
        <input type="text" id="profilePic" name="profilePic">
        <input type="hidden" name="userId" value="<%=request.getParameter("userID")%>" />
        <br>
        <input type="submit" value="Submit">
    </form>

    <c:if test="${updateProfile ne null}">
        <c:out value="${updateProfile}"></c:out>
    </c:if>

    <label for="discount">Add a discount:</label>
    <form action="AddDiscount" method="post">
        <select name = "discount" id="discount" onchange="this.form.submit()">
            <option value = "Student">Student</option>
            <option value = "Military">Military</option>
            <option value = "Family">Family</option>
        </select>
        <input type="hidden" name="userId" value="<%=request.getParameter("userID")%>" />
    </form>

    <label for="viewTracks">View Tracks:</label>
    <form id="viewTracks" name="viewTracks" method="post" action="ViewTracks">
        <input type="hidden" name="userId" value="<%=request.getParameter("userID")%>">
        <button>View Tracks</button>
    </form>

    <label for="addTracks">View Tracks:</label>
    <form id="addTracks" name="addTracks" method="post" action="AddTracks">
        <button>Add Tracks</button>
    </form>

    <h3>Search Tracks, Artists, or Playlists</h3>
    <form id="searchTracks" name="searchTracks" method="post" action="SearchTracks">
        <label for="track">Title: </label><input type="text" id="track" name="track" />
        <button>Search Tracks</button><br>
    </form>

    <form id="searchArtists" name="searchArtists" method="post" action="SearchArtists">
        <label for="artist">Artist: </label><input type="text" id="artist" name="artist" />
        <button>Search Artists</button><br>
    </form>

    <form id="searchPlaylists" name="searchPlaylists" method="post" action="SearchPlaylists">
        <label for="playlist">Playlist Description: </label><input type="text" id="playlist" name="playlist" />
        <button>Search Playlists</button>
    </form>
</div>
</body>
</html>
