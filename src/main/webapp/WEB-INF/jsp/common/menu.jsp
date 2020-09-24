<%--
  Created by IntelliJ IDEA.
  User: 万恶de亚撒西
  Date: 2020/9/15
  Time: 14:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>

<ul style="padding-left:0px;" class="list-group">
    <c:forEach items="${rootAuth.children }" var = "auth" >
        <c:if test="${empty rootAuth.children }">
            <li class="list-group-item tree-closed" >
                <a href="${PATH }${rootauth.authUrl}"><i class="${rootauth.icon }"></i> ${rootauth.name }</a>
            </li>
        </c:if>
        <c:if test="${not empty auth.children }">
            <li class="list-group-item tree-closed">
                <span><i class="${auth.icon }"></i> ${auth.name } <span class="badge" style="float:right">${auth.children.size() }</span></span>
                <ul style="margin-top:10px;display:none;">
                    <c:forEach items="${auth.children }" var = "child">
                        <li style="height:30px;">
                            <a href="${PATH }${child.authUrl }"><i class="${child.icon }"></i> ${child.name }</a>
                        </li>
                    </c:forEach>
                </ul>
            </li>
        </c:if>
    </c:forEach>
</ul>
