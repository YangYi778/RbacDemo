<%--
  Created by IntelliJ IDEA.
  User: 万恶de亚撒西
  Date: 2020/9/15
  Time: 14:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
    <link rel="stylesheet" href="../../ztree/zTreeStyle.css">
    <style>
        .tree li {
            list-style-type: none;
            cursor:pointer;
        }
        .tree-closed {
            height : 40px;
        }
        .tree-expanded {
            height : auto;
        }
    </style>
</head>

<body>

<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
    <div class="container-fluid">
        <div class="navbar-header">
            <div><a class="navbar-brand" style="font-size:32px;" href="#">众筹平台 - 控制面板</a></div>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
            <ul class="nav navbar-nav navbar-right">
                <li style="padding-top:8px;">
                    <div class="btn-group">
                        <button type="button" class="btn btn-default btn-success dropdown-toggle" data-toggle="dropdown">
                            <i class="glyphicon glyphicon-user"></i> ${user.userName } <span class="caret"></span>
                        </button>
                        <ul class="dropdown-menu" role="menu">
                            <li><a href="#"><i class="glyphicon glyphicon-cog"></i> 个人设置</a></li>
                            <li><a href="#"><i class="glyphicon glyphicon-comment"></i> 消息</a></li>
                            <li class="divider"></li>
                            <li><a href="index.html"><i class="glyphicon glyphicon-off"></i> 退出系统</a></li>
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
                <input type="text" class="form-control" placeholder="查询">
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
            <h1 class="page-header">控制面板</h1>

            <div class="row placeholders">
                <ul id="permissionTree" class="ztree"></ul>
            </div>
        </div>
    </div>
</div>
<script src="../../jquery/jquery-2.1.1.min.js"></script>
<script src="../../bootstrap/js/bootstrap.min.js"></script>
<script src="../../script/docs.min.js"></script>
<script src="../../ztree/jquery.ztree.all-3.5.min.js"></script>
<script type="text/javascript">
    $(function () {
        $(".list-group-item").click(function(){
            // jquery对象的回调方法中的this关键字为DOM对象
            // $(DOM) ==> JQuery
            if ( $(this).find("ul") ) { // 3 li
                $(this).toggleClass("tree-closed");
                if ( $(this).hasClass("tree-closed") ) {
                    $("ul", this).hide("fast");
                } else {
                    $("ul", this).show("fast");
                }
            }
        });

        var setting={
            async: {
                enable: true,
                url:"${PATH}/permission/loadData",
                autoParam:["id","name=n","level=lv"],
            },

        }

        /*模拟数据
        var setting = {	};

        var zNodes =[
            { name:"父节点1 - 展开", open:true,
                children: [
                    { name:"父节点11 - 折叠",
                        children: [
                            { name:"叶子节点111"},
                            { name:"叶子节点112"},
                            { name:"叶子节点113"},
                            { name:"叶子节点114"}
                        ]},
                    { name:"父节点12 - 折叠",
                        children: [
                            { name:"叶子节点121"},
                            { name:"叶子节点122"},
                            { name:"叶子节点123"},
                            { name:"叶子节点124"}
                        ]},
                    { name:"父节点13 - 没有子节点", isParent:true}
                ]},
            { name:"父节点2 - 折叠",
                children: [
                    { name:"父节点21 - 展开", open:true,
                        children: [
                            { name:"叶子节点211"},
                            { name:"叶子节点212"},
                            { name:"叶子节点213"},
                            { name:"叶子节点214"}
                        ]},
                    { name:"父节点22 - 折叠",
                        children: [
                            { name:"叶子节点221"},
                            { name:"叶子节点222"},
                            { name:"叶子节点223"},
                            { name:"叶子节点224"}
                        ]},
                    { name:"父节点23 - 折叠",
                        children: [
                            { name:"叶子节点231"},
                            { name:"叶子节点232"},
                            { name:"叶子节点233"},
                            { name:"叶子节点234"}
                        ]}
                ]},
            { name:"父节点3 - 没有子节点", isParent:true}

        ];
        */

        $.fn.zTree.init($("#permissionTree"), setting);
    });
</script>
</body>
</html>
