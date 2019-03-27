<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: ashleybarkworth
  Date: 2019-03-23
  Time: 22:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Guest</title>
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
<a href='index.jsp'>
    <div class="hoja small-logo-topleft">
        <img class="music-note-small" src="${pageContext.request.contextPath}/frontend/assets/img/whiteMusicNote.png">
        <div class="spootify-nametag">Spootify</div>
    </div>
</a>
<div class="register-success guest-container">
    <div class="title-padding">Welcome! Register Below to Obtain a Guest ID:</div>
    <form action="RegisterGuest" method="POST" class="small-form">
        <span class="form-sub-title">Register your guest ID</span>
        <input class="form-input" type="text" id="guestName" name="guestName" placeholder="Name(Optional)">
        <button type="submit" name="register" class="minimal-button simple-button">Confirm</button>
        <div class="form-sub-title">
            <c:if test="${guestId ne null}">
                <c:out value="Your guestId is ${guestId}"></c:out>
            </c:if>
        </div>
    </form>

    <form action="CheckBalance" method="post" class="small-form">
        <span class="form-sub-title">Check your balance</span>
        <input class="form-input" type="hidden" name="guestId" value="${guestId}">
        <div class="form-input" type="text" disabled placeholder="Your Balance Is">
            <c:if test="${balance ne null}">
                <c:out value="Your balance is $${balance}"></c:out>
            </c:if>
        </div>
        <button class="minimal-button simple-button" type="submit" name="balance">Check Balance</button>
    </form>

<div>Testing</div>
    <form action="UpdateBalance" method="post" class="small-form">
        <span class="form-sub-title">Update your balance</span>
        <input class="form-input" type="number" id="newBalance" name="newBalance" placeholder="Digits Only">
        <input type="hidden" name="guestId" value="${guestId}">
        <button class="minimal-button simple-button" type="submit" name="register">Update Balance</button>
        <div class="form-sub-title">
            <c:if test="${newBalance ne null}">
                <fmt:setLocale value="en_CA"/>
                <fmt:formatNumber value="${newBalance}" type="currency" var="formattedNewBalance"/>
                <c:out value="Your balance is ${formattedNewBalance}"></c:out>
            </c:if>
        </div>
    </form>

</div>
</body>
</html>
