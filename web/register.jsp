<%--
  Created by IntelliJ IDEA.
  User: ashleybarkworth
  Date: 2019-03-23
  Time: 17:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Register Spootify</title>
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
    </div>
</a>
<form action="RegisterUser" method="post" id="register-form" class="da-form">
    <span id="form-title">Sign Up for Spootify</span>
    <span class="form-sub-title">What should we call you?</span>
    <input type="text" class="form-input" id="userName" name="userName" required placeholder="Your username">
    <span class="form-sub-title">Choose your subscription:</span>
    <select name = "subscriptionType" id="subscriptionType" class="form-input form-select" >
        <option value = "Family">Family</option>
        <option value = "Standard">Standard</option>
    </select>
    <span class="form-sub-title">Provide your card number:</span>
    <input type="number" class="form-input" id="cardNumber" name="cardNumber" required placeholder="Digits only">
    <div class="submit-button-wrapper">
        <button type="submit" class="submit-button"><div class="submit-text">Submit</div><img class="check-submit" src="img/whiteCheck.png"></button>
    </div>
</form>
</body>
</html>
