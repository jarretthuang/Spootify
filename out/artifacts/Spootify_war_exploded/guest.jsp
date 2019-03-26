<%@ page import="java.util.Random" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="Utility.DBConnection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.SQLException" %>
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
</head>

<body>

<h1>Welcome! Register below to obtain a guest ID: </h1>
<h4>Use your guest ID to login for future listening</h4>

<form action="RegisterGuest" method="post">
    <label for="guestName">Name (Optional): </label>
    <input type="text" id="guestName" name="guestName">
    <input type="submit" name="register" value="Register" />
    <br>
</form>

<c:if test="${guestId ne null}">
    <c:out value="Your guestId is ${guestId}"></c:out>
</c:if>

<form action="CheckBalance" method="post">
    <input type="hidden" name="guestId" value="${guestId}" />
    <input type="submit" name="balance" value="Check balance" />
</form>


<c:if test="${balance ne null}">
    <c:out value="Your balance is $${balance}"></c:out>
</c:if>

<form action="CheckBalance" method="post">
    <input type="hidden" name="guestId" value="${guestId}" />
    <input type="submit" name="balance" value="Check balance" />
</form>

</body>
</html>
