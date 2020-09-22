<%--
  Created by IntelliJ IDEA.
  User: 万恶de亚撒西
  Date: 2020/9/15
  Time: 15:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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

    <link rel="stylesheet" href="../../../bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="../../../css/font-awesome.min.css">
    <link rel="stylesheet" href="../../../css/main.css">
    <link rel="stylesheet" href="../../../css/doc.min.css">
    <link rel="stylesheet" href="../../../ztree/zTreeStyle.css">
    <link rel="stylesheet" href="../../../layer/skin/default/layer.css">
    <style>
        .tree li {
            list-style-type: none;
            cursor:pointer;
        }
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
            <div class="panel panel-info">
                <div class="panel-heading">
                    <i class="glyphicon glyphicon-th-list"></i> 权限菜单列表
                    <div style="float:right;cursor:pointer;"><button class="btn btn-success " onclick="addAuth()">新增</button>
                    </div>
                </div>
                <%--<div>
                    <form action="/permission/addAuth" method="post">
                        <div style="width: 350px">
                            <div class="form-group has-feedback" style="width: 320px;margin-left: 3%;margin-top: 5px">
                                <p>权限名称</p>
                                <input class="form-control" type="text" name="name" placeholder="请输入权限名称">
                            </div>
                            <div style="width: 320px;margin-left: 3%;margin-top: 5px">
                                <p>选中父节点</p>
                                <select name="authParentRoot" style="width: 150px;height: 30px">
                                    <c:forEach items="${auths }" var = "auth" >
                                        <option value="${auth.id}">${auth.name}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div style="width: 320px;margin-left: 3%;margin-top: 5px">
                                <p>权限访问路径</p>
                                <input class="form-control" type="text" name="authUrl" placeholder="请输入路径名">
                            </div>
                            <button style="margin-left:3%;margin-top: 5%" type="submit" class="btn btn-block btn-success btn-lg">添加权限节点</button>
                        </div>
                    </form>
                </div>--%>
                <div class="panel-body">
                    <ul id="treeDemo" class="ztree"></ul>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="../../../jquery/jquery-2.1.1.min.js"></script>
<script src="../../../bootstrap/js/bootstrap.min.js"></script>
<script src="../../../script/docs.min.js"></script>
<script src="../../../ztree/jquery.ztree.all-3.5.min.js"></script>
<script src="../../../layer/layer.js"></script>
<script type="text/javascript">
    function addAuth() {
        layer.open({
            type: 1 //Page层类型
            ,area: ['450px', '520px']
            ,title: '添加权限'
            ,shade: 0.6 //遮罩透明度
            ,maxmin: true //允许全屏最小化
            ,anim: 1 //0-6的动画形式，-1不开启
            ,content: '<form action="/permission/addAuth" method="post">\n' +
            '                        <div style="width: 350px">\n' +
            '                            <div class="form-group has-feedback" style="width: 320px;margin-left: 3%;margin-top: 5px">\n' +
            '                                <p>权限名称</p>\n' +
            '                                <input class="form-control" type="text" id="name" name="name" placeholder="请输入权限名称">\n' +
            '                            </div>\n' +
            '                            <div style="width: 320px;margin-left: 3%;margin-top: 5px">\n' +
            '                                <p>选中父节点</p>\n' +
            '                                <select id="authParentRoot" name="authParentRoot" style="width: 150px;height: 30px">\n' +
            '                                    <c:forEach items="${auths }" var = "auth" >\n' +
            '                                        <option value="${auth.id}">${auth.name}</option>\n' +
            '                                    </c:forEach>\n' +
            '                                </select>\n' +
            '                            </div>\n' +
            '                            <div style="width: 320px;margin-left: 3%;margin-top: 5px">\n' +
            '                                <p>权限访问路径</p>\n' +
            '                                <input class="form-control" type="text" id="authUrl" name="authUrl" placeholder="请输入路径名">\n' +
            '                            </div>\n' +
            '                            <button style="margin-left:3%;margin-top: 5%" type="button" class="btn btn-block btn-success btn-lg" onclick="doaddAuth()">添加权限节点</button>\n' +
            '                        </div>\n' +
            '                    </form>'
            ,end:function () {
                console.info("不错的")
                location.reload();
            }
        });
    }
    function doaddAuth() {
        var name = $("#name").val();
        var authUrl = $("#authUrl").val();
        var authParentRoot = $("#authParentRoot").val();
        var loadingIndex = null;
        $.ajax({
            type: "post",
            url: "${PATH}/permission/addAuth",
            data:{
                "name":name,
                "authUrl":authUrl,
                "authParentRoot":authParentRoot,
            },
            beforeSend:function(){
                loadingIndex = layer.msg("添加权限中，请稍后",{icon:16});
            },
            success: function (result) {
                //关闭处理loading
                layer.close(loadingIndex);
                //接收返回数据
                if(result.success){
                    layer.msg("添加成功",{timer:100,icon:6,shift:6},function(){});
                }else{
                    layer.msg("添加失败！",{timer:100,icon:5,shift:6},function(){});
                }
            }
        });
    }
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
/**********************************************************************************/
        var setting = {

            view : {
                selectedMulti : true,
                showLine : false
            },
            data : {
                simpleData : {
                    enable : true,
                    idKey : "id",
                    pIdKey : "pid",
                }
            },
            edit : {
                enable : true,
                renameTitle : "重命名",
                removeTitle : "删除节点以及子节点",
                showRemoveBtn : setRemoveBtn,
                showRenameBtn : setRenameBtn
            },
            callback : {
                // 单击事件
                onCheck : zTreeOnCheck,
                beforeRemove : zTreeBeforeRemove,
                //onRemove : zTreeOnRemove,
                onRename : zTreeOnRename
            }
        };
        $(document).ready(function() {
            initZTree();
        });

        //ids是一个数组 返回结果数组     treeNode是选中的节点
        function getChildren(ids,treeNode){
            ids.push(treeNode.id);
            if (treeNode.isParent){
                for(var obj in treeNode.children){
                    getChildren(ids,treeNode.children[obj]);
                }
            }
            console.log("ids:"+ids);
            return ids;
        }

        // 单击事件，向后台发起请求
        function zTreeOnClick(event, treeId, treeNode) {
            if (treeNode.id == "1") {
                return;
            }
            //alert(treeNode.tId + ", " + treeNode.name);
        }


        function setRemoveBtn(treeId, treeNode) {
            if(treeNode.id == 1){
                return false;
            }
            return true;
        }

        function setRenameBtn(treeId, treeNode) {
            if(treeNode.id == 1){
                return false;
            }
            return true;
        }

        /*function zTreeBeforeRemove(treeId, treeNode) {
            console.info("进来了");
            if (confirm("是否确认删除"))
                return true;
            return false;
        }*/
        function zTreeBeforeRemove(treeId, treeNode){//删除节点之前
            var zTree = $.fn.zTree.getZTreeObj("treeDemo");
            zTree.selectNode(treeNode);
            if(treeNode.id==1){
                layer.open({
                    content : "请勿删除顶级指标！",
                    btn : [ "确定" ],
                    shadeClose : false,
                    yes : function(index) {
                        layer.close(index);
                    }
                }); return false;
            }
            var flag=false;//此处必须定义一个变量，不然还没确定就把节点从树上删除
            layer.confirm("确认要删除当前指标及其下级指标吗？", {
                    btn: ['确定','取消']
                },
                function(){
                    var ids=[];
                    ids=getChildren(ids,treeNode);//获取当前节点的子节点字符串数组
                    $.ajax({
                        type : "POST",
                        url : "${pageContext.request.contextPath}/permission/deleteAuth",
                        data: {"ids":ids},//格式化参数
                        success : function(result){
                            if(result.success){
                                console.log("成功了吗"+result.success);
                                layer.open({
                                    content : "删除成功！",
                                    btn : [ "确定" ],
                                    shadeClose : false,
                                    yes : function(index) {
                                        layer.close(index);
                                        location.reload();
                                        zTree.removeChildNodes(treeNode);//删除当前节点子节点
                                        zTree.removeNode(treeNode);//删除当前节点
                                    }
                                });
                            }
                        }
                    });
                },
                function(index){
                    layer.close(index);
                    flag=false;
                })
            return flag;}

        function zTreeOnRemove(event, treeId, treeNode) {
            $.ajax({
                url :"${path}/permission/deleteAuth",
                data : {
                    id : treeNode.id,
                },
                type : "post",
                success : function(data) {
                    deleteDetain(treeNode.id);
                }
            });

        }

        function zTreeOnRename(event, treeId, treeNode) {
            $.ajax({
                url : "${PATH}/permission/updateAuthName",
                data : {
                    id : treeNode.id,
                    name : treeNode.name
                },
                type : "POST",
                success : function(data) {
                    location.reload()
                }
            });
        }
        // 异步加载数据过滤器
        function ajaxDataFilter(treeId, parentNode, responseData) {
            var data = responseData.returnData.treeList;
            return data;
        }

        // 节点勾选事件
        function zTreeOnCheck(event, treeId, treeNode) {
            // 显示围栏
            if (beforeNodeID != treeNode.id) {
                electronicLayerOff = true;
                beforeNodeID = treeNode.id;
            }
            showDetain([ treeNode.id ]);
        }

        // 获取项目路径
        function getContextPath() {
            var currentPath = window.document.location.href;
            var pathName = window.document.location.pathname;
            var pos = currentPath.indexOf(pathName);
            var localhostPath = currentPath.substring(0, pos);
            var projectName = pathName.substring(0,
                pathName.substr(1).indexOf('/') + 1);
            return (localhostPath + projectName);
        }

        return {
            init : function() {
                basePath = getContextPath();
                initTree();
            }
        };
        /*******************************************************************/
        function initZTree() {
            $.ajax({
                url : "${path}/permission/loadData",
                type : "post",
                dataType : "json",
                success : function(data) {
                    $.fn.zTree.init($("#treeDemo"), setting, data);
                },
                error : function() {
                }
            });
        }
    });
</script>
<%--<form action="/permission/addAuth" method="post">
    <div style="width: 350px">
        <div class="form-group has-feedback" style="width: 320px;margin-left: 3%;margin-top: 5px">
            <p>权限名称</p>
            <input class="form-control" type="text" name="name" placeholder="请输入权限名称">
        </div>
        <div style="width: 320px;margin-left: 3%;margin-top: 5px">
            <p>选中父节点</p>
            <select name="authParentRoot" style="width: 150px;height: 30px">
                <option value="${rootAuth.id}">${rootAuth.name}</option>
                <c:forEach items="${rootAuth.children }" var = "auth" >
                    <option value="${auth.id}">${auth.name}</option>
                    <c:forEach items="${auth.children }" var = "child">
                        <option value="${child.id}">${child.name}</option>
                    </c:forEach>
                </c:forEach>
            </select>
        </div>
        <div style="width: 320px;margin-left: 3%;margin-top: 5px">
            <p>权限访问路径</p>
            <input class="form-control" type="text" name="authUrl" placeholder="请输入路径名">
        </div>
        <button style="margin-left:3%;margin-top: 5%" type="button" class="btn btn-block btn-success btn-lg" onclick="addAuth()">添加权限节点</button>
    </div>
</form>--%>
</body>
</html>

