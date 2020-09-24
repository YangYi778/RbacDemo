<%--
  Created by IntelliJ IDEA.
  User: 万恶de亚撒西
  Date: 2020/9/15
  Time: 14:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <link rel="stylesheet" href="../../bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="../../css/font-awesome.min.css">
    <link rel="stylesheet" href="../../css/main.css">
    <link rel="stylesheet" href="../../css/doc.min.css">
    <style>
        .tree li {
            list-style-type: none;
            cursor:pointer;
        }
    </style>
</head>

<body>

<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
    <div class="container-fluid">
        <div class="navbar-header">
            <div><a class="navbar-brand" style="font-size:32px;" href="user.html">RBAC - 用户维护</a></div>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
            <ul class="nav navbar-nav navbar-right">
                <li style="padding-top:8px;">
                    <div class="btn-group">
                        <button type="button" class="btn btn-default btn-success dropdown-toggle" data-toggle="dropdown">
                            <i class="glyphicon glyphicon-user"></i> 张四 <span class="caret"></span>
                        </button>
                        <ul class="dropdown-menu" role="menu">
                            <li><a href="#"><i class="glyphicon glyphicon-cog"></i> 个人设置</a></li>
                            <li><a href="#"><i class="glyphicon glyphicon-comment"></i> 消息</a></li>
                            <li class="divider"></li>
                            <li><a href="login.html"><i class="glyphicon glyphicon-off"></i> 退出系统</a></li>
                        </ul>
                    </div>
                </li>
                <li style="margin-left:10px;padding-top:8px;">
                    <button type="button" class="btn btn-default btn-danger">
                        <span class="glyphicon glyphicon-question-sign"></span> 帮助
                    </button>
                </li>
            </ul>
            <form class="navbar-form navbar-right">
                <input type="text" class="form-control" placeholder="Search...">
            </form>
        </div>
    </div>
</nav>

<div class="container-fluid">
    <div class="row">
        <div class="col-sm-3 col-md-2 sidebar">
            <div class="tree">
                <%@include file="/WEB-INF/jsp/common/menu.jsp" %>
            </div>
        </div>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
            <ol class="breadcrumb">
                <li><a href="#">首页</a></li>
                <li><a href="#">数据列表</a></li>
                <li class="active">分配权限</li>
            </ol>
            <div class="panel panel-default">
                <div class="panel-body">
                    <form id="permissionForm" role="form" class="form-inline">
                        <input type="hidden" id="roleId" name="roleId" value="${role.roleId }" />
                        <!--<input type="hidden" id="userId" name="userId" value="${user.userId }" />-->
                        <div class="form-group">
                            <label for="leftList">未分配权限列表</label><br>

                            <select class="form-control" id="leftList" name="unassignedPermission" multiple size="10" style="width:100px;overflow-y:auto;">
                                <c:forEach items="${unassignedPermission }" var="auth">
                                    <option value="${auth.id }">${auth.name }</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="form-group">
                            <ul>
                                <li id="left2RightBtn" class="btn btn-default glyphicon glyphicon-chevron-right"></li>
                                <br>
                                <li id="right2LeftBtn" class="btn btn-default glyphicon glyphicon-chevron-left" style="margin-top:20px;"></li>
                            </ul>
                        </div>
                        <div class="form-group" style="margin-left:40px;">
                            <label for="rightList">已分配权限列表</label><br>
                            <select class="form-control" id="rightList" name="assignedPermission" multiple size="10" style="width:100px;overflow-y:auto;">
                                <c:forEach items="${assignedPermission }" var="auth">
                                    <option value="${auth.id }">${auth.name }</option>
                                </c:forEach>
                            </select>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                <h4 class="modal-title" id="myModalLabel">帮助</h4>
            </div>
            <div class="modal-body">
                <div class="bs-callout bs-callout-info">
                    <h4>测试标题1</h4>
                    <p>测试内容1，测试内容1，测试内容1，测试内容1，测试内容1，测试内容1</p>
                </div>
                <div class="bs-callout bs-callout-info">
                    <h4>测试标题2</h4>
                    <p>测试内容2，测试内容2，测试内容2，测试内容2，测试内容2，测试内容2</p>
                </div>
            </div>
            <!--
            <div class="modal-footer">
              <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
              <button type="button" class="btn btn-primary">Save changes</button>
            </div>
            -->
        </div>
    </div>
</div>
<script src="${PATH }/jquery/jquery-2.1.1.min.js"></script>
<script src="${PATH }/bootstrap/js/bootstrap.min.js"></script>
<script src="${PATH }/script/docs.min.js"></script>
<script type="text/javascript" src="${PATH }/layer/layer.js" ></script>
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

        $("#left2RightBtn").click(function(){
            var opts=$('#leftList :selected');
            alert(opts.length+"*********");
            if(opts.length==0){
                layer.msg("请选择需要分配的权限！",{timer:1000,icon:0,shift:6},function(){});
            }else{
                alert($("#permissionForm").serialize());
                alert("${PATH}/user/doAssignPermission");
                //$("#permissionForm").serialize()：  permissionForm--表单名 将表单数据标准序列化——param=value&param=value
                $.ajax({
                    type : "POST",
                    url : "${PATH}/user/doAssignPermission",
                    data : $("#permissionForm").serialize(),
                    success :function(result){
                        if(result.success){
                            $("#rightList").append(opts);
                            layer.msg("分配权限 数据成功",{timer:2000,icon:6},function(){
                                location.reload();
                            });
                        }else{
                            layer.msg("分配权限 数据失败",{timer:2000,icon:5,shift:6},function(){
                                location.reload();
                            });
                        }
                    }
                });
            }
        })
        $("#right2LeftBtn").click(function(){
            var opts=$('#rightList :selected');
            if(opts.length==0){
                layer.msg("请选择需要取消分配的权限！",{timer:1000,icon:0,shift:6},function(){});
            }else{
                alert($("#permissionForm").serialize());
                alert("${PATH}/user/dounAssignPermission");
                //$("#permissionForm").serialize()：将表单数据标准序列化——param=value&param=value
                $.ajax({
                    type : "POST",
                    url : "${PATH}/user/dounAssignPermission",
                    data : $("#permissionForm").serialize(),
                    success :function(result){
                        console.info("test"+result.success);
                        if(result.success){
                            $("#leftList").append(opts);
                            layer.msg("取消分配权限数据成功",{timer:2000,icon:6},function(){
                                location.reload();
                            });
                        }else{
                            layer.msg("取消分配权限数据失败",{timer:2000,icon:5,shift:6},function(){
                                location.reload();
                            });
                        }
                    }
                });
            }
        })
    });
</script>
</body>
</html>