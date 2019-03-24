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
  <link rel="shortcut icon" type="image/x-icon" href="img/favicon.ico">
  <title>Spootify</title>
  <meta name="description" content="Discover music like never before!">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/frontend/assets/css/main.css" type="text/css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <script src="frontend/assets/javascript/jquery-3.2.1.min.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
  <script src="frontend/assets/javascript/main.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.js"></script>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.css" />
</head>

<body>
<div class="hoja">
  <img id="music-note" src="${pageContext.request.contextPath}/frontend/assets/img/whiteMusicNote.png">
</div>
<div id="clan-name">Spootify</div>
<span id="copy-right" class="noselect">© 2019 BARELY LEGAL. ALL RIGHTS RESERVED.</span>

<div class="container">

  <a href='register.jsp'>Click here to register</a>
  <br>
  <label for="userID">Already a user? Enter your user ID:</label>
  <form action="viewProfile.jsp" method="POST">
    <input type="number" id="userID" name="userID" />
    <button type="submit">Login </button>
  </form>

  <label for="userID">Already a user? Enter your user ID:</label>
  <a href="guest.jsp">Just wanna listen? Guest access</a>
  </form>
</div>


</body>
</html>

