<%--
  Created by IntelliJ IDEA.
  User: ashleybarkworth
  Date: 2019-03-23
  Time: 14:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html lang="en-us">
<head>
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
<div class="hoja" id="logo-homepage">
  <img id="music-note" src="${pageContext.request.contextPath}/frontend/assets/img/whiteMusicNote.png">
</div>
<div id="spootify-name">Spootify</div>
<div id="home-buttons">
  <a href='register.jsp' id="register-button" ><div class="minimal-button">SIGN UP</div></a>
  <div id="login-button" class="minimal-button">LOG IN</div>
</div>
<span id="copy-right" class="noselect">© 2019 BARELY LEGAL. ALL RIGHTS RESERVED.</span>
<div class="minimal-form popup-form">
  <form action="ViewTracks" method="POST" class="da-form">
    <span class="form-title">Your Spootify</span>
    <input id="userId" class="form-input" name="userId" type="text" placeholder="Your User ID" required>
    <div class="submit-button-wrapper">
      <button type="submit" class="submit-button"><div class="submit-text">Sign Me In</div><img class="check-submit" src="${pageContext.request.contextPath}/frontend/assets/img/whiteCheck.png"></button>
    </div>
    <a href="guest.jsp" id="guest-login" class="form-sub-title"><span>Just wanna listen? Sign in as guest!</span></a>
  </form>
</div>
</body>
</html>

