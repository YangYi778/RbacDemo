<%@ page language="java" contentType="text/html;charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <link rel="stylesheet" href="${path}/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="${path}/css/font-awesome.min.css">
    <link rel="stylesheet" href="${path}/css/main.css">
    <style>
        .tree li {
            list-style-type: none;
            cursor:pointer;
        }
        table tbody tr:nth-child(odd){background:#F4F4F4;}
        table tbody td:nth-child(even){color:#C00;}
    </style>
</head>

<body>

<%@include file="/WEB-INF/jsp/common/head.jsp"%>

<div class="container-fluid">
    <div class="row">
        <div class="col-sm-3 col-md-2 sidebar">
            <div class="tree">
                <%@include file="/WEB-INF/jsp/common/menu.jsp" %>
            </div>
        </div>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title"><i class="glyphicon glyphicon-th"></i> 数据列表</h3>
                </div>
                <div class="panel-body">
                    <form class="form-inline" role="form" style="float:left;">
                        <div class="form-group has-feedback">
                            <div class="input-group">
                                <div class="input-group-addon">查询条件</div>
                                <input class="form-control has-success" type="text" placeholder="请输入查询条件">
                            </div>
                        </div>
                        <button type="button" class="btn btn-warning"><i class="glyphicon glyphicon-search"></i> 查询</button>
                    </form>
                    <button type="button" class="btn btn-danger" style="float:right;margin-left:10px;"><i class=" glyphicon glyphicon-remove"></i> 删除</button>
                    <button type="button" class="btn btn-primary" style="float:right;" onclick="window.location.href='add.html'"><i class="glyphicon glyphicon-plus"></i> 新增</button>
                    <br>
                    <hr style="clear:both;">
                    <div class="table-responsive">
                        <table class="table  table-bordered">
                            <thead>
                            <tr >
                                <th width="30">#</th>
                                <th width="30"><input type="checkbox"></th>
                                <th>账号</th>
                                <th>密码</th>
                                <th>真实姓名</th>
                                <th>用户状态</th>
                                <th width="100">操作</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${pageInfo.list }" var="user" varStatus="s">
                                <tr>
                                    <td>${s.count }</td>
                                    <td><input type="checkbox"></td>
                                    <td>${user.userName }</td>
                                    <td>${user.password }</td>
                                    <td>${user.userTrueName }</td>
                                    <td>${user.userState }</td>
                                    <td>
                                        <button type="button" id="assignRole" onclick="assignRole(${user.userId })" class="btn btn-success btn-xs"><i class=" glyphicon glyphicon-check"></i></button>
                                        <button type="button" class="btn btn-primary btn-xs"><i class=" glyphicon glyphicon-pencil"></i></button>
                                        <button type="button" class="btn btn-danger btn-xs"><i class=" glyphicon glyphicon-remove"></i></button>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                            <tfoot>
                            <tr >
                                <td colspan="6" align="center">
                                    <ul class="pagination">
                                        <li><a href="index?pn=1">首页</a></li>
                                        <c:if test="${pageInfo.hasPreviousPage }">
                                            <li><a href="index?pn=${pageInfo.pageNum-1 }" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li>
                                        </c:if>
                                        <c:forEach items="${pageInfo.navigatepageNums }" var="page_Num">
                                            <c:if test="${page_Num == pageInfo.pageNum }">
                                                <li class="active"><a href="#">${page_Num }</a></li>
                                            </c:if>
                                            <c:if test="${page_Num != pageInfo.pageNum }">
                                                <li><a href="index?pn=${page_Num }">${page_Num }</a></li>
                                            </c:if>
                                        </c:forEach>
                                        <c:if test="${pageInfo.hasNextPage }">
                                            <li><a href="index?pn=${pageInfo.pageNum+1 }" aria-label="Next"><span aria-hidden="true">&raquo;</span></a></li>
                                        </c:if>
                                        <li><a href="index?pn=${pageInfo.pages }">尾页</a></li>
                                    </ul>
                                </td>
                            </tr>

                            </tfoot>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="${path}/jquery/jquery-2.1.1.min.js"></script>
<script src="${path}/bootstrap/js/bootstrap.min.js"></script>
<script src="${path}/script/docs.min.js"></script>
<script type="text/javascript">
    $(function () {
        $(".list-group-item").click(function(){
            if ( $(this).find("ul") ) {
                $(this).toggleClass("tree-closed");
                if ( $(this).hasClass("tree-closed") ) {
                    $("ul", this).hide("fast");
                } else {
                    $("ul", this).show("fast");
                }
            }
        });
    });
    /* $("tbody .btn-success").click(function(){
        window.location.href = "assignRole.html";
    });
    $("tbody .btn-primary").click(function(){
        window.location.href = "edit.html";
    }); */
    function assignRole(id){
        //alert("assignRole" + id);
        location.href = "${PATH}/user/assign?id="+id;
    }
</script>
</body>
</html>
