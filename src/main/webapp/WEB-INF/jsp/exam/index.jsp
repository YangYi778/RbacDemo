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
                    <form action="/exam/queryExamsByName" method="post" class="form-inline" role="form" style="float:left;">
                        <div class="form-group has-feedback">
                            <div class="input-group">
                                <div class="input-group-addon">考试科目</div>
                                <input class="form-control has-success" type="text" id="examName" name="examName" placeholder="请输入查询条件">
                            </div>
                        </div>
                        <button type="submit" class="btn btn-warning"><i class="glyphicon glyphicon-search"></i> 查询</button>
                    </form>
                    <button type="button" class="btn btn-danger" style="float:right;margin-left:10px;" onclick="deleteExam() "><i class=" glyphicon glyphicon-remove"></i> 删除</button>
                    <button type="button" class="btn btn-primary" style="float:right;" onclick="addExam()"><i class="glyphicon glyphicon-plus"></i> 新增</button>
                    <br>
                    <hr style="clear:both;">
                    <div class="table-responsive">
                        <table class="table  table-bordered">
                            <thead>
                            <tr >
                                <th width="30">#</th>
                                <th width="30"><input type="checkbox"></th>
                                <th>科目代码</th>
                                <th>科目名称</th>
                                <th>科目说明</th>
                                <th width="100">操作</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${pageInfo.list }" var="exam" varStatus="e">
                                <tr>
                                    <td>${e.count }</td>
                                    <td><input type="checkbox"></td>
                                    <td>${exam.id }</td>
                                    <td>${exam.examName }</td>
                                    <td>${exam.examInfo }</td>
                                    <td>
<%--                                        <button type="button" id="assignRole" onclick="assignRole(${user.userId })" class="btn btn-success btn-xs"><i class=" glyphicon glyphicon-check"></i></button>--%>
                                        <button type="button" id="updateExam" onclick="updateExam(${exam.id },'${exam.examName}','${exam.examInfo}')" class="btn btn-primary btn-xs"><i class=" glyphicon glyphicon-pencil"></i></button>
                                        <button type="button" onclick="deleteExam(${exam.id})" class="btn btn-danger btn-xs"><i class=" glyphicon glyphicon-remove"></i></button>
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


</body>


<script src="../../jquery/jquery-2.1.1.min.js"></script>
<script src="../../bootstrap/js/bootstrap.min.js"></script>
<script src="../../script/docs.min.js"></script>
<script src="/layer/layer.js"></script>
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
    function addExam() {
        layer.open({
            type: 1,
            title: '新增科目界面',
            skin: 'layui-layer-rim', //加上边框
            area: ['400px', '340px'], //宽高
            content: '<form id="updateExam" action="/exam/updateExam" method="post">\n' +
                '    <div style=\'width:320px;margin-left: 3%;\' class=\'form-group has-feedback\'>\n' +
                '        <label>科目代码</label><input id=\'id\' class=\'form-control\' type=\'text\' name=\'id\'/>\n' +
                '    </div>\n' +
                '    <div style=\'width:320px;margin-left: 3%;\' class=\'form-group has-feedback\'>\n' +
                '        <label>科目名称</label><input id=\'examName\' class=\'form-control\' type=\'text\' name=\'examName\'/>\n' +
                '    </div>\n' +
                '    <div style=\'width:320px;margin-left: 3%;\' class=\'form-group has-feedback\'>\n' +
                '        <label>科目备注</label><input id=\'examInfo\' class=\'form-control\' type=\'text\' name=\'examInfo\'/>\n' +
                '    </div>\n' +
                '    <button type="submit" class="btn btn-block btn-success btn-lg" style="width: 320px;margin-left: 3%;">确认添加</button>\n' +
                '</form>'
        });
    }
    /* $("tbody .btn-success").click(function(){
        window.location.href = "assignRole.html";
    });
    $("tbody .btn-primary").click(function(){
        window.location.href = "edit.html";
    }); */
    function deleteExam(id) {
        //询问框
        layer.confirm('是否确认删除？', {
            btn: ['确定了','再想想'] //按钮
        }, function(){
            $.ajax({
                type : 'post',
                url : '/exam/deleteExam',
                data : {"id" : id},
                success : function (result) {
                    if(result){
                        layer.msg('删除成功！', {icon: 1});
                    }else{
                        layer.msg('删除失败！', {icon: 0});
                    }
                }
            });
            window.location.reload();
        });

    }
    function updateExam(id,examName,examInfo){
        //alert("assignRole" + id);
        layer.open({
            type: 1,
            title: '修改科目界面',
            skin: 'layui-layer-rim', //加上边框
            area: ['400px', '280px'], //宽高
            content: '<form id="updateExam" action="/exam/updateExam" method="post">\n' +
                '    <input id=\'id\' class=\'form-control\' type=\'hidden\' name=\'id\' value="'+id+'"/>\n' +
                '    <div style=\'width:320px;margin-left: 3%;\' class=\'form-group has-feedback\'>\n' +
                '        <label>科目名称</label><input id=\'examName\' class=\'form-control\' type=\'text\' name=\'examName\' value="'+examName+'"/>\n' +
                '    </div>\n' +
                '    <div style=\'width:320px;margin-left: 3%;\' class=\'form-group has-feedback\'>\n' +
                '        <label>科目备注</label><input id=\'examInfo\' class=\'form-control\' type=\'text\' name=\'examInfo\' value="'+examInfo+'"/>\n' +
                '    </div>\n' +
                '    <button type="submit" class="btn btn-block btn-success btn-lg" style="width: 320px;margin-left: 3%;">确认修改</button>\n' +
                '</form>'
        });
    }
</script>
</html>
