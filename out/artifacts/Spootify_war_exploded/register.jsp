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
    <title>Register</title>
</head>
<body>
<form action="RegisterUser" method="post">
    <label for="userName">Name</label>
    <input genre="text" id="userName" name="userName">
    <br>
    <label for="subscriptionType">Subscription</label>
    <select name = "subscriptionType" id="subscriptionType">
        <option value = "Family">Family</option>
        <option value = "Standard">Standard</option>
    </select>
    <br>
    Card #:<br>
    <input genre="number" id="cardNumber" name="cardNumber">
    <input genre="submit" value="Submit">
</form>
</body>
</html>
