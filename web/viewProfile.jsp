<%@ page import="java.sql.Connection" %>
<%@ page import="Utility.DBConnection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.ResultSet" %>

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
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.css"/>
</head>
<body>

<%
    if (request.getParameter("userID") != null) {
        request.getSession().setAttribute("userId", request.getParameter("userID"));
    }
%>

<a href='index.jsp'>
    <div class="hoja small-logo-topleft">
        <img class="music-note-small" src="${pageContext.request.contextPath}/frontend/assets/img/whiteMusicNote.png">
        <div class="spootify-nametag">Spootify</div>
    </div>
</a>
<div class="ui-panel">
    <div class="welcome-back">Welcome back!</div>
    <img class="profile-pic do-not-invert" id="login-button"
         src="https://img1.ak.crunchyroll.com/i/spire3/3614810e9ada5235038e8deb4adc264c1447729591_large.jpg">
    <div class="popup-form minimal-form">
        <div class="form-title title-padding">User Settings</div>
        <form class="small-form" action="UpdateName" method="post">
            <span class="form-sub-title">Update Username</span>
            <input class="form-input" type="text" id="newName" name="newName" required>
            <input type="hidden" name="userId" value="${userId}"/>
            <button type="submit" class="minimal-button simple-button">Confirm</button>
            <div class="form-sub-title">
                <c:if test="${updateName ne null}">
                    <c:out value="${updateName}"></c:out>
                </c:if>
            </div>
        </form>
        <form class="small-form" action="UpdateProfile" method="post">
            <span class="form-sub-title">Update Profile Image</span>
            <input class="form-input" type="text" id="profilePic" name="profilePic" required>
            <input type="hidden" name="userId" value="${userId}"/>
            <button type="submit" class="minimal-button simple-button">Confirm</button>
            <div class="form-sub-title">
                <c:if test="${updateProfile ne null}">
                    <c:out value="${updateProfile}"></c:out>
                </c:if>
            </div>
        </form>
        <form class="small-form" action="AddDiscount" method="post">
            <span class="form-sub-title">Apply Discount</span>
            <select class="form-input form-select" name="discount" id="discount">
                <option value="Student">Student</option>
                <option value="Military">Military</option>
                <option value="Family">Family</option>
            </select>
            <input type="hidden" name="userId" value="${userId}"/>
            <button type="submit" class="minimal-button simple-button">Confirm</button>
            <div class="form-sub-title">
                <c:if test="${addDiscount ne null}">
                    <c:out value="${addDiscount}"></c:out>
                    <br>
                    <c:out value="Your new monthly rate is ${monthlyRate}"></c:out>
                </c:if>
            </div>
        </form>
        <div class="title-padding"></div>
    </div>
    <div class="song-browser">
        <label for="viewTracks">View Tracks:</label>
        <form id="viewTracks" name="viewTracks" method="post" action="ViewTracks">
            <input type="hidden" name="userId" value="${userId}">
            <button>View Tracks</button>
        </form>

        <c:if test="${tracks ne null}">
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
        </c:if>

        <label for="addTracks">Add Tracks:</label>
        <form id="addTracks" name="addTracks" method="post" action="ViewAllTracks">
            <input type="hidden" name="userId" value="${userId}">
            <button>Add Tracks</button>
        </form>

        <c:if test="${allTracks ne null}">
            <form id="addTrack" name="addTrack" method="post" action="AddTrack">
                <input type="hidden" name="userId" value="${userId}">
                <table>
                    <tr>
                        <th>TrackId</th>
                        <th>AnalyticsId</th>
                        <th>AlbumId</th>
                        <th>Name</th>
                        <th>Duration</th>
                        <th>Popularity</th>
                    </tr>
                    <c:forEach items="${allTracks}" var="item" varStatus="status">
                        <tr>
                            <td>${item.getTrackId()}</td>
                            <td>${item.getAnalyticsId()}</td>
                            <td>${item.getAlbumId()}</td>
                            <td>${item.getName()}</td>
                            <td>${item.getDuration()}</td>
                            <td>${item.getPopularity()}</td>
                            <td>
                                <div class="checkbox">
                                    <label><input type="checkbox" name="track" value="${item.getTrackId()}"></label>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                </table>
                <input type="submit" value="Add Selected Tracks"/>
            </form>
            <c:if test="${success ne null}">
                <td>${success}</td>
            </c:if>
            <c:if test="${failure ne null}">
                <td>${failure}</td>
            </c:if>
        </c:if>


        <label for="addTracksToPlaylist">Create Playlist:</label>
        <form id="addTracksToPlaylist" name="addTracksToPlaylist" method="post" action="ViewTracksForPlaylist">
            <input type="hidden" name="userId" value="${userId}">
            <button>Select Tracks</button>
        </form>
        <br>
        <c:if test="${allTracksForPlaylist ne null}">
            <form id="addTrack" name="addTrack" method="post" action="CreatePlaylist">
                <input type="hidden" name="userId" value="${userId}">
                <table>
                    <tr>
                        <th>TrackId</th>
                        <th>AnalyticsId</th>
                        <th>AlbumId</th>
                        <th>Name</th>
                        <th>Duration</th>
                        <th>Popularity</th>
                    </tr>
                    <c:forEach items="${allTracksForPlaylist}" var="item" varStatus="status">
                        <tr>
                            <td>${item.getTrackId()}</td>
                            <td>${item.getAnalyticsId()}</td>
                            <td>${item.getAlbumId()}</td>
                            <td>${item.getName()}</td>
                            <td>${item.getDuration()}</td>
                            <td>${item.getPopularity()}</td>
                            <td><div class="checkbox">
                                <label><input type="checkbox" name="trackPlaylist" value="${item.getTrackId()}"></label></div></td>
                        </tr>
                    </c:forEach>
                </table>
                <input type="text" name="description" value="Playlist Description">
                <input type="hidden" name="userId" value="${userId}">
                <input type="submit" value="Add Selected Tracks" />
            </form>
            <c:if test="${successCreate ne null}">
                <td>${successCreate}</td>
                <br>
                <td>Playlist ID: ${playlistId}</td>
            </c:if>
            <c:if test="${failureCreate ne null}">
                <td>${failureCreate}</td>
            </c:if>
        </c:if>




        <h3>Search Tracks, Artists, or Playlists</h3>
        <form id="searchTracks" name="searchTracks" method="post" action="SearchTracks">
            <label for="track">Title: </label><input type="text" id="track" name="track">
            <button>Search Tracks</button>
            <br>
        </form>

        <form id="searchArtists" name="searchArtists" method="post" action="SearchArtists">
            <label for="artist">Artist: </label><input type="text" id="artist" name="artist"/>
            <button>Search Artists</button>
            <br>
        </form>

        <form id="searchPlaylists" name="searchPlaylists" method="post" action="SearchPlaylists">
            <label for="playlist">Playlist Description: </label><input type="text" id="playlist" name="playlist"/>
            <button>Search Playlists</button>
        </form>

        <h3>View Tracks By Artist</h3>
        <form id="searchTracksByArtist" name="searchTracksByArtist" method="post" action="ViewTracksByArtist">
            <input type="hidden" name="userId" value="${userId}">
            <label for="artist">Artist: </label><input type="text" id="artistSong" name="artistSong">
            <button>Search Tracks by Artist</button><br>
        </form>

        <c:if test="${artistTracks ne null}">
            <table>
                <tr>
                    <th>TrackId</th>
                    <th>AnalyticsId</th>
                    <th>AlbumId</th>
                    <th>Name</th>
                    <th>Duration</th>
                    <th>Popularity</th>
                </tr>
                <c:forEach items="${artistTracks}" var="item">
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
        </c:if>

    </div>

</div>
</body>
</html>
