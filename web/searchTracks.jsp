<%@ page import="java.sql.Connection" %>
<%@ page import="Utility.DBConnection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.SQLException" %>
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

<%
    if (request.getParameter("userID") != null) {
        request.getSession().setAttribute("userId", request.getParameter("userID"));
    }

    if (request.getParameter("profilePic") == null && session.getAttribute("profilePic") == null) {
        request.getSession().setAttribute("profilePic", "https://www.georeferencer.com/static/img/person.png");
    }

    if (request.getParameter("trackName") != null) {
        request.getSession().setAttribute("trackName", request.getParameter("trackName"));
    }
%>

<body>

<div class="ui-panel">
    <div class="spootify-home">
        <a href="index.jsp"><div class="minimal-button">Spootify</div></a>
        <div class="spootify-breadcrumb">> Search > Songs</div>
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
        <form class="small-form" action="AddDiscount" method="post">
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
                            </tr>
                            </thead>
                        </table>
                    </div>
                    <div class="table100-body js-pscroll">
                        <table>
                            <tbody>
                            <c:if test="${tracks ne null}">
                                <c:forEach items="${tracks}" var="item">
                                    <tr class="row100 body">
                                        <td class="cell100 column1">${item.getTrackId()}</td>
                                        <td class="cell100 column2">${item.getAnalyticsId()}</td>
                                        <td class="cell100 column3">${item.getAlbumId()}</td>
                                        <td class="cell100 column4">${item.getName()}</td>
                                        <td class="cell100 column5">${item.getDuration()}</td>
                                        <td class="cell100 column6">${item.getPopularity()}</td>
                                    </tr>
                                </c:forEach>
                            </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        <form id="divisionExample" name="divisionExample" method="post" action="DivisionExample">
            <input type="hidden" name="userId" value="${userId}">
            <input type="hidden" name="profilePic" value="${profilePic}"/>
            <button type="submit" class="simple-button minimal-button do-not-invert">Choose Songs That</button>
            <select name = "divisor" id="divisor" class="form-select form-input invert-color no-set-size">
                <option value = "playlist">are in every playlist</option>
                <option value = "user">are stored by every user</option>
                <option value = "artist">are created by every artist</option>
            </select>
        </form>

        <form id="sortTracks" name="sortTracks" method="post" action="SortTracks">
            <input type="hidden" name="userId" value="${userId}">
            <input type="hidden" name="profilePic" value="${profilePic}"/>
            <input type="hidden" name="trackName" value="${trackName}"/>
            <button type="submit" class="simple-button minimal-button do-not-invert">Sort By</button>
            <select name = "field" id="field" class="form-select form-input invert-color no-set-size">
                <option value = "liveliness">liveliness</option>
                <option value = "speechiness">speechiness</option>
                <option value = "danceability">danceability</option>
                <option value = "instrumentalness">instrumentalness</option>
                <option value = "energy">energy</option>
                <option value = "analyticsKey">key</option>
                <option value = "loudness">loudness</option>
                <option value = "tempo">tempo</option>
            </select>
            <select name = "order" id="order" class="form-select form-input invert-color no-set-size">
                <option value = "ASC">ascending order</option>
                <option value = "DESC">descending order</option>
            </select>
        </form>

        <form id="viewAllTracks" name="viewAllTracks" method="post" action="ViewAllTracks">
            <input type="hidden" name="userId" value="${userId}">
            <input type="hidden" name="profilePic" value="${profilePic}"/>
            <button type="submit" class="simple-button minimal-button do-not-invert">Go to Browse</button>
        </form>
        <form action="ViewTracks" method="POST">
            <input type="hidden" name="userId" value="${userId}">
            <input type="hidden" name="profilePic" value="${profilePic}"/>
            <button type="submit" class="simple-button minimal-button do-not-invert">Go to My Library</button>
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


