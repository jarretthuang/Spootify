
<%@ page import="java.sql.Connection" %>
<%@ page import="Utility.DBConnection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="Utility.DBConnection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="model.TrackObj" %>
<%@ page import="java.util.ArrayList" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

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
%>

<div class="ui-panel">
    <div class="spootify-home">
        <a href="index.jsp"><div class="minimal-button">Spootify</div></a>
        <c:if test="${userPlaylists == null}">
            <div class="spootify-breadcrumb">> My Library > Tracks</div>
        </c:if>
        <c:if test="${userPlaylists ne null}">
            <div class="spootify-breadcrumb">> My Library > Playlists</div>
        </c:if>

    </div>
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
        <form id="deleteTrack" class="tracks-view-container" name="deleteTrack" method="post" action="DeleteTrack">
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
                                <c:if test="${tracksStoredByUser ne null}">
                                    <c:forEach items="${tracksStoredByUser}" var="item">
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
                <button type="submit" class="simple-button minimal-button do-not-invert" value="">Delete Selected Tracks</button>
                <c:if test="${successDelete ne null}">
                    <span class="form-sub-title">${successDelete}</span>
                </c:if>
                <c:if test="${failureDelete ne null}">
                    <span class="form-sub-title">${failureDelete}</span>
                </c:if>
            </form>
        <c:if test="${userPlaylists ne null}">
            <form id="deletePlaylist" class="playlists-view-container" name="deletePlaylist" method="post" action="DeletePlaylist">
                <input type="hidden" name="userId" value="${userId}">
                <div class="wrap-table100">
                    <div class="table100 ver5 m-b-110 playlists-table">
                        <div class="table100-head">
                            <table>
                                <thead>
                                <tr class="row100 head">
                                    <th class="cell100 column1">Playlist ID</th>
                                    <th class="cell100 column2">Playlist Description</th>
                                    <th class="cell100 column3">Public</th>
                                    <th class="cell100 column4">Number of Songs</th>
                                </tr>
                                </thead>
                            </table>
                        </div>
                        <div class="table100-body js-pscroll">
                            <table>
                                <tbody>
                                <c:if test="${userPlaylists ne null}">
                                    <c:forEach items="${userPlaylists}" var="item">
                                        <tr class="row100 body">
                                            <td class="cell100 column1">${item.getPlaylistId()}</td>
                                            <td class="cell100 column2">${item.getDescription()}</td>
                                            <td class="cell100 column3">${item.isPublic()}</td>
                                            <td class="cell100 column4">${numSongs[loop.index]}</td>
                                            <td class="cell100 column5"><div class="checkbox">
                                                <label><input type="checkbox" name="deletePlaylist" value="${item.getPlaylistId()}"></label></div></td>
                                        </tr>
                                    </c:forEach>
                                </c:if>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                <button type="submit" class="simple-button minimal-button do-not-invert" value="">Delete Selected Playlists</button>
                <c:if test="${successDeletePlaylist ne null}">
                    <span class="form-sub-title">${successDeletePlaylist}</span>
                </c:if>
                <c:if test="${failureDeletePlaylist ne null}">
                    <span class="form-sub-title">${failureDeletePlaylist}</span>
                </c:if>
            </form>
        </c:if>
        <form id="viewPlaylist" name="viewPlaylist" method="post" action="ViewPlaylists">
            <input type="hidden" name="userId" value="${userId}">
            <c:if test="${userPlaylists == null}">
                <button type="submit" class="simple-button minimal-button do-not-invert switch-to-playlists">Show Playlists</button>
            </c:if>
            <c:if test="${userPlaylists ne null}">
                <button class="simple-button minimal-button do-not-invert switch-to-tracks">Show Tracks</button>
            </c:if>
        </form>
        <form id="viewTracks" name="viewTracks" method="post" action="ViewTracks">
            <input type="hidden" name="userId" value="${userId}">
            <button type="submit" class="simple-button minimal-button do-not-invert">Browse</button>
        </form>
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
