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

    <link rel="stylesheet" href="../../bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="../../css/font-awesome.min.css">
    <link rel="stylesheet" href="../../css/main.css">
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
                    <form action="/user/index" method="post" class="form-inline" role="form" style="float:left;">
                        <div class="form-group has-feedback">
                            <div class="input-group">
                                <div class="input-group-addon">账号名</div>
                                <input class="form-control has-success" id="userName" name="userName" type="text" placeholder="请输入账号名">
                            </div>
                        </div>
                        <button type="submit" class="btn btn-warning"><i class="glyphicon glyphicon-search"></i> 查询</button>
                    </form>
                </div>
                <button type="button" class="btn btn-danger" style="float:right;margin-left:10px;"><i class=" glyphicon glyphicon-remove"></i> 删除</button>
                <button type="button" class="btn btn-primary" style="float:right;" onclick="addUser()"><i class="glyphicon glyphicon-plus"></i> 新增</button><br>
                <span style="float: left;color: red" id="errormessage"></span>
                <hr style="clear:both;">
                <div class="table-responsive">
                    <table class="table  table-bordered">
                        <thead>
                        <tr >
                            <th width="30">#</th>
                            <%--<th>选择</th>--%>
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
                                <td>${user.userName }</td>
                                <td>${user.password }</td>
                                <td>${user.userTrueName }</td>
                                <td>${user.userState }</td>
                                <td>
                                    <button type="button" id="assignRole" onclick="assignRole(${user.userId })" class="btn btn-success btn-xs"><i class=" glyphicon glyphicon-check"></i></button>
                                    <button type="button" id="updateUser" onclick="updateUser('${user.userId }','${user.userName}','${user.password}','${user.userTrueName}')" class="btn btn-primary btn-xs"><i class=" glyphicon glyphicon-pencil"></i></button>
                                    <button type="button" onclick="deleteUser(${user.userId})" class="btn btn-danger btn-xs"><i class=" glyphicon glyphicon-remove"></i></button>
                                </td>
                            </tr>

                        </c:forEach>
                        </tbody>
                        <tfoot>
                        <tr >
                            <td colspan="6" align="center">
                                <ul class="pagination">
                                    <%--
                                    分页
                                    --%>
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

<script src="${PATH}/jquery/jquery-2.1.1.min.js"></script>
<script src="${PATH}/bootstrap/js/bootstrap.min.js"></script>
<script src="${PATH}/script/docs.min.js"></script>
<script src="${PATH}/layer/layer.js"></script>
<script type="text/javascript">
   /* /!*
    * 全选
    * *!/
    function clickon() {
        // 获取到body中所有checkbox
        var checkbox = document.querySelectorAll("input[type='checkbox']");
        for (var i = 0; i < checkbox.length; i++) {
            checkbox[i].checked = true;
        }
    }
    /!*
    * 全不选
    * *!/
    function unclick() {
        var checkbox = document.querySelectorAll("input[type='checkbox']");

        for (var i = 0; i < checkbox.length; i++) {
            checkbox[i].checked = false;
        }
    }

    /!*
    * 删除选定的
    * *!/
    function delete1() {
        var str = "";
        var sel = document.getElementsByName("checkbox");//获取checkbox的值

        for (var i = 0; i < sel.length; i++)
            if (sel[i].checked == true)
                str += sel[i].value + ",";
        if (str == "") {
            alert("请至少选择一条记录");
            return false;
        }
        if (str != "") {
            alert("确定删除吗？");
            return false;
        }
        if (window.confirm("确定删除吗？")) {
            window.location = "";
            // 后台删除处

        }
    }*/

    /*
    * 添加用户
    * */
    function addUser() {
        layer.open({
            type: 1,
            title: '添加用户界面',
            skin: 'layui-layer-rim', //加上边框
            area: ['400px', '410px'], //宽高
            content: '<form id="updateUser" action="${PATH}/user/addUser" method="post">\n' +
            '    <div style=\'width:320px;margin-left: 3%;\' class=\'form-group has-feedback\'>\n' +
            '        <label>账号名</label><input id=\'userName\' class=\'form-control\' type=\'text\' name=\'userName\'/>\n' +
            '    </div>\n' +
            '    <div style=\'width:320px;margin-left: 3%;\' class=\'form-group has-feedback\'>\n' +
            '        <label>密码</label><input id=\'password\' class=\'form-control\' type=\'text\' name=\'password\'/>\n' +
            '    </div>\n' +
            '    <div style=\'width:320px;margin-left: 3%;\' class=\'form-group has-feedback\'>\n' +
            '        <label>真实姓名</label><input id=\'userTrueName\' class=\'form-control\' type=\'text\' name=\'userTrueName\'/>\n' +
            '    </div>\n' +
            '    <div style=\'width:320px;margin-left: 3%;\' class=\'form-group has-feedback\'>\n' +
            '        <label>邮件</label><input id=\'email\' class=\'form-control\' type=\'text\' name=\'email\'/>\n' +
            '    </div>\n' +
            '    <button type="submit" class="btn btn-block btn-success btn-lg" style="width: 320px;margin-left: 3%;">确认添加</button>\n' +
            '</form>'
        });
    }

    /*
    * 删除单个用户
    * */
    function deleteUser(userId) {
        console.info("刪除")
        //询问框
        layer.confirm('是否确认删除？', {
            btn: ['确定了','再想想'] //按钮
        }, function(){
            $.ajax({
                type : 'post',
                url : '${PATH}/user/deleteUser',
                data : {"userId" : userId},
                success : function (result) {
                    if(result.success){
                        console.info("成功");
                        layer.msg('删除成功！', {icon: 1,time:2000},function () {
                            location.reload();

                        });
                    }else{
                        console.info("失败");
                        layer.msg('删除失败！', {icon: 0,time:2000},function () {
                            location.reload();
                        });
                    }
                }
            });
        });
    }

    /*
    * 更新用户
    * */
    function updateUser(userId,userName,password,userTrueName){
        // alert("assignRole" + userId+);
        layer.open({
            type: 1,
            title: '修改用户界面',
            skin: 'layui-layer-rim', //加上边框
            area: ['400px', '340px'], //宽高
            content: '<form id="updateUser" action="${PATH}/user/updateUser" method="post">\n' +
            '    <input id=\'userId\' class=\'form-control\' type=\'hidden\' name=\'userId\' value="'+userId+'"/>\n' +
            '    <div style=\'width:320px;margin-left: 3%;\' class=\'form-group has-feedback\'>\n' +
            '        <label>账号名</label><input id=\'userName\' class=\'form-control\' type=\'text\' name=\'userName\' value="'+userName+'"/>\n' +
            '    </div>\n' +
            '    <div style=\'width:320px;margin-left: 3%;\' class=\'form-group has-feedback\'>\n' +
            '        <label>密码</label><input id=\'password\' class=\'form-control\' type=\'text\' name=\'password\' value="'+password+'"/>\n' +
            '    </div>\n' +
            '    <div style=\'width:320px;margin-left: 3%;\' class=\'form-group has-feedback\'>\n' +
            '        <label>真实姓名</label><input id=\'userTrueName\' class=\'form-control\' type=\'text\' name=\'userTrueName\' value="'+userTrueName+'"/>\n' +
            '    </div>\n' +
            '    <button type="submit" class="btn btn-block btn-success btn-lg" style="width: 320px;margin-left: 3%;">确认修改</button>\n' +
            '</form>'
        });
    }

    function assignRole(id){
        //alert("assignRole" + id);
        location.href = "${PATH}/user/assign?id="+id;
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
    });
</script>
</body>
</html>
