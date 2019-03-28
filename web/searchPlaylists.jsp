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
    <title>Spootify - Search Playlists</title>
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

    if (request.getParameter("profilePic") == null) {
        request.getSession().setAttribute("profilePic", "https://www.georeferencer.com/static/img/person.png");
    }
%>
<body>

<div class="ui-panel">
    <div class="spootify-home">
        <a href="index.jsp"><div class="minimal-button">Spootify</div></a>
        <div class="spootify-breadcrumb">> Search > Playlists</div>
    </div>
    <img class="profile-pic do-not-invert" id="login-button"
         src="https://img1.ak.crunchyroll.com/i/spire3/3614810e9ada5235038e8deb4adc264c1447729591_large.jpg">
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
        <form id="followPlaylist" name="followPlaylist" method="post" action="FollowPlaylist">
            <input type="hidden" name="userId" value="${userId}">
            <input type="hidden" name="profilePic" value="${profilePic}"/>
            <div class="wrap-table100">
                <div class="table100 ver5 m-b-110 tracks-table">
                    <div class="table100-head">
                        <table>
                            <thead>
                            <tr class="row100 head">
                                <th class="cell100 column1">Playlist ID</th>
                                <th class="cell100 column2">Playlist Description</th>
                                <th class="cell100 column3">Public</th>
                                <th class="cell100 column4">Number of Songs</th>
                                <th class="cell100 column5">(Select)</th>
                            </tr>
                            </thead>
                        </table>
                    </div>
                    <div class="table100-body js-pscroll">
                        <table>
                            <tbody>
                            <c:if test="${playlists ne null}">
                                <c:forEach items="${playlists}" var="item">
                                    <tr class="row100 body">
                                        <td class="cell100 column1">${item.getPlaylistId()}</td>
                                        <td class="cell100 column2">${item.getDescription()}</td>
                                        <td class="cell100 column3">${item.isPublic()}</td>
                                        <td class="cell100 column4">${numSongs[loop.index]}</td>
                                        <td class="cell100 column5"><div class="checkbox">
                                            <label><input type="checkbox" name="followPlaylist" value="${item.getPlaylistId()}"></label></div></td>
                                    </tr>
                                </c:forEach>
                            </c:if>
                            </tbody>
                        </table>
                    </div>
                    <button type="submit" class="simple-button minimal-button do-not-invert" value="">Follow Selected Playlists</button>
                    <c:if test="${successFollow ne null}">
                        <span class="form-sub-title">${successFollow}</span>
                    </c:if>
                    <c:if test="${failureFollow ne null}">
                        <span class="form-sub-title">${failureFollow}</span>
                    </c:if>

                </div>
            </div>
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
