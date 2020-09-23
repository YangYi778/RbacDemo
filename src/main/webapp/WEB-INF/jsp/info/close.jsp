<%--
  Created by IntelliJ IDEA.
  User: 万恶de亚撒西
  Date: 2020/9/20
  Time: 22:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page isELIgnored="false" %>
<html>
<head>
    <title>Title</title>
    <meta http-equiv="refresh" content="5;url=examRecord?userId=${user.userId}" />
</head>
<body>
<p>${user.userId}---交卷成功！5秒后将返回考试中心界面，如果界面未跳转请<a href="examRecord?userId=${user.userId}">点击此处</a>。。。</p>
</body>
</html>