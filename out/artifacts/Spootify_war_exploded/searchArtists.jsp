<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: ashleybarkworth
  Date: 2019-03-24
  Time: 15:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>

<body>
<table>
    <tr>
        <th>Artist Name</th>
        <th>Artist Genre</th>
    </tr>
    <c:forEach items="${artists}" var="item">
        <tr>
            <td>${item.getName()}</td>
            <td>${item.getGenre()}</td>
        </tr>
    </c:forEach>
</table>

</body>

</html>
