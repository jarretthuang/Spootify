<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: ashleybarkworth
  Date: 2019-03-24
  Time: 13:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>Spootify - Browse</title>
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

<%
    if (request.getParameter("userID") != null) {
        request.getSession().setAttribute("userId", request.getParameter("userID"));
    }

    if (request.getParameter("profilePic") == null && session.getAttribute("profilePic") == null) {
        request.getSession().setAttribute("profilePic", "https://www.georeferencer.com/static/img/person.png");
    }
%>

<div class="ui-panel">
    <div class="spootify-home">
        <a href="index.jsp"><div class="minimal-button">Spootify</div></a>
        <c:if test="${allTracksToAddToPlaylist == null}">
            <div class="spootify-breadcrumb">> Browse > Add Tracks to Your Library</div>
        </c:if>
        <c:if test="${allTracksToAddToPlaylist ne null}">
            <div class="spootify-breadcrumb">> Browse > Create Playlist</div>
        </c:if>
        <div class="spootify-breadcrumb-static">> Browse > Add Tracks to Your Library</div>
    </div>
    <img class="search-icon"
         src="${pageContext.request.contextPath}/frontend/assets/img/search-icon-white.png">
    <div class="search-menu minimal-form">
        <span class="form-title">Search</span>
        <form class="small-form" id="searchTracks" name="searchTracks" method="post" action="SearchTracks">
            <input type="hidden" name="profilePic" value="${profilePic}"/>
            <input type="hidden" name="userId" value="${userId}">
            <input class="form-input" type="text" id="track" name="track" required placeholder="Song Title">
            <button type="submit" class="minimal-button simple-button">Search Songs</button>
        </form>
        <form class="small-form" id="searchArtists" name="searchArtists" method="post" action="SearchArtists">
            <input type="hidden" name="profilePic" value="${profilePic}"/>
            <input type="hidden" name="userId" value="${userId}">
            <input class="form-input" type="text" id="artist" name="artist" required placeholder="Artist Name">
            <button type="submit" class="minimal-button simple-button">Search Artists</button>
        </form>
        <form class="small-form" id="searchPlaylists" name="searchPlaylists" method="post" action="SearchPlaylists">
            <input type="hidden" name="profilePic" value="${profilePic}"/>
            <input type="hidden" name="userId" value="${userId}">
            <input class="form-input" type="text" id="playlist" name="playlist" required placeholder="Playlist Description">
            <button type="submit" class="minimal-button simple-button">Search Playlists</button>
        </form>
        <span class="title-padding"></span>
    </div>
    <img class="profile-pic do-not-invert" id="login-button"
         src="${profilePic}">
    <div class="popup-form minimal-form">
        <div class="form-title title-padding">User Settings</div>
        <form class="small-form" action="UpdateName" method="post">
            <span class="form-sub-title">Update Username</span>
            <input class="form-input" type="text" id="newName" name="newName" required>
            <input type="hidden" name="userId" value="${userId}"/>
            <input type="hidden" name="profilePic" value="${profilePic}"/>
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
        <form class="small-form" id="addDiscount" action="AddDiscount" method="post">
            <span class="form-sub-title">Apply Discount</span>
            <select class="form-input form-select" name="discount" id="discount">
                <option value="Student">Student</option>
                <option value="Military">Military</option>
                <option value="Family">Family</option>
            </select>
            <input type="hidden" name="userId" value="${userId}"/>
            <input type="hidden" name="profilePic" value="${profilePic}"/>
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
        <form id="addTracks" class="tracks-view-container" name="addTracks" method="post" action="ViewAllTracks">
            <input type="hidden" name="profilePic" value="${profilePic}"/>
            <input type="hidden" name="userId" value="${userId}">
            <div class="wrap-table100">
                <div class="table100 ver5 m-b-110 tracks-table">
                    <div class="table100-head">
                        <table>
                            <thead>
                            <tr class="row100 head">
                                <th class="cell100 column1">TrackId</th>
                                <th class="cell100 column2">AnalyticsId</th>
                                <th class="cell100 column3">AlbumId</th>
                                <th class="cell100 column4">Name</th>
                                <th class="cell100 column5">Duration</th>
                                <th class="cell100 column6">Popularity</th>
                                <th class="cell100 column7">(Select)</th>
                            </tr>
                            </thead>
                        </table>
                    </div>
                    <div class="table100-body js-pscroll">
                        <table>
                            <tbody>
                            <c:if test="${allTracks ne null}">
                                <c:forEach items="${allTracks}" var="item">
                                    <tr class="row100 body">
                                        <td class="cell100 column1">${item.getTrackId()}</td>
                                        <td class="cell100 column2">${item.getAnalyticsId()}</td>
                                        <td class="cell100 column3">${item.getAlbumId()}</td>
                                        <td class="cell100 column4">${item.getName()}</td>
                                        <td class="cell100 column5">${item.getDuration()}</td>
                                        <td class="cell100 column6">${item.getPopularity()}</td>
                                        <td class="cell100 column7"><div class="checkbox">
                                            <label><input type="checkbox" name="track" value="${item.getTrackId()}"></label></div></td>
                                    </tr>
                                </c:forEach>
                            </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <button type="submit" class="simple-button minimal-button do-not-invert" value="">Add Selected Tracks to My Library</button>
            <c:if test="${success ne null}">
                <span class="form-sub-title">${success}</span>
            </c:if>
            <c:if test="${failure ne null}">
                <span class="form-sub-title">${failure}</span>
            </c:if>
        </form>
        <c:if test="${allTracksToAddToPlaylist ne null}">
            <form id="addTrack" class="playlists-view-container" name="addTrack" method="post" action="CreatePlaylist">
                <input type="hidden" name="userId" value="${userId}">
                <input type="hidden" name="profilePic" value="${profilePic}"/>
                <div class="wrap-table100">
                    <div class="table100 ver5 m-b-110 playlists-table">
                        <div class="table100-head">
                            <table>
                                <thead>
                                <tr class="row100 head">
                                    <th class="cell100 column1">TrackId</th>
                                    <th class="cell100 column2">AnalyticsId</th>
                                    <th class="cell100 column3">AlbumId</th>
                                    <th class="cell100 column4">Name</th>
                                    <th class="cell100 column5">Duration</th>
                                    <th class="cell100 column6">Popularity</th>
                                    <th class="cell100 column7">(Select)</th>
                                </tr>
                                </thead>
                            </table>
                        </div>
                        <div class="table100-body js-pscroll">
                            <table>
                                <tbody>
                                <c:if test="${allTracksToAddToPlaylist ne null}">
                                    <c:forEach items="${allTracksToAddToPlaylist}" var="item">
                                        <tr class="row100 body">
                                            <td class="cell100 column1">${item.getTrackId()}</td>
                                            <td class="cell100 column2">${item.getAnalyticsId()}</td>
                                            <td class="cell100 column3">${item.getAlbumId()}</td>
                                            <td class="cell100 column4">${item.getName()}</td>
                                            <td class="cell100 column5">${item.getDuration()}</td>
                                            <td class="cell100 column6">${item.getPopularity()}</td>
                                            <td class="cell100 column7"><div class="checkbox">
                                                <label><input type="checkbox" name="trackPlaylist" value="${item.getTrackId()}"></label></div></td>
                                        </tr>
                                    </c:forEach>
                                </c:if>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                <div class="minimal-form create-playlist-form">
                    <input class="simple-button minimal-button do-not-invert" type="text" name="description" placeholder="Playlist Description" required>
                    <input type="hidden" name="userId" value="${userId}">
                    <button type="submit" class="simple-button minimal-button do-not-invert" value="">Create Playlist</button>
                    <c:if test="${successCreate ne null}">
                        <span class="form-sub-title">${successCreate} Playlist ID is ${playlistId}</span>
                    </c:if>
                    <c:if test="${failureCreate ne null}">
                        <span class="form-sub-title">${failureCreate}</span>
                    </c:if>
                </div>
            </form>
        </c:if>
        <form id="addTracksToPlaylist" name="addTracksToPlaylist" method="post" action="ViewTracksForPlaylist">
            <input type="hidden" name="userId" value="${userId}">
            <input type="hidden" name="profilePic" value="${profilePic}"/>
            <button type="submit" class="simple-button minimal-button do-not-invert switch-to-playlists">Go to Playlist Creation</button>
        </form>
        <button class="simple-button minimal-button do-not-invert switch-to-tracks">Go to Adding Tracks</button>
        <form action="ViewTracks" method="POST">
            <input type="hidden" name="userId" value="${userId}">
            <input type="hidden" name="profilePic" value="${profilePic}"/>
            <button type="submit" class="simple-button minimal-button do-not-invert">Go to My Library</button>
        </form>
        <form id="mostSavedTrack" name="mostSavedTrack" method="post" action="MostSavedTrack">
            <input type="hidden" name="userId" value="${userId}">
            <input type="hidden" name="profilePic" value="${profilePic}"/>
            <button type="submit" class="simple-button minimal-button do-not-invert">What's Hot?</button>
        </form>

    <%--<form id="viewTracks" name="viewTracks" method="post" action="ViewTracks">--%>
            <%--<input type="hidden" name="userId" value="${userId}">--%>
            <%--<button type="submit" class="simple-button minimal-button do-not-invert">Browse</button>--%>
        <%--</form>--%>
    </div>


    <script src="${pageContext.request.contextPath}/frontend/assets/select2/select2.min.js"></script>
    <script src="${pageContext.request.contextPath}/frontend/assets/perfect-scrollbar/perfect-scrollbar.min.js"></script>
    <script>
        $('.js-pscroll').each(function(){
            var ps = new PerfectScrollbar(this);

            $(window).on('resize', function(){
                ps.update();
            })
        });
    </script>
    <script src="${pageContext.request.contextPath}/frontend/assets/javascript/table.js"></script>

</div>

</body>
</html>
