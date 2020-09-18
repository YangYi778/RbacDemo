<%--
  Created by IntelliJ IDEA.
  User: 万恶de亚撒西
  Date: 2020/9/16
  Time: 15:03
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
                    <form action="/exam/queryExam" method="post" class="form-inline" role="form" style="float:left;">
                        <div class="form-group has-feedback">
                            <div class="input-group">
                                <div class="input-group-addon">考试名称</div>
                                <input class="form-control has-success" id="paperName" name="paperName" type="text" placeholder="请输入考试名称">
                            </div>
                        </div>
                        <div class="form-group has-feedback">
                            <div class="input-group">
                                <div class="input-group-addon">考试科目</div>
                                <select id="paperType" name="paperType" style="width:150px; height:30px;">
                                    <option value="">全部科目</option>
                                    <c:forEach items="${exams}" var="exam">
                                        <option value="${exam.id}">${exam.examName}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
<%--                        <div class="form-group">--%>
<%--                            <label for="examType">考试科目</label>--%>
<%--                            <select id="examType" name="examType" style="width:150px; height:30px;">--%>
<%--                                <c:forEach items="${exams}" var="exam">--%>
<%--                                    <option value="${exam.id}">${exam.examName}</option>--%>
<%--                                </c:forEach>--%>
<%--                            </select>--%>
<%--                        </div>--%>
                        <button type="submit" class="btn btn-warning"><i class="glyphicon glyphicon-search"></i> 查询</button>
                    </form>
                    <br>
                    <hr style="clear:both;">
                    <div class="table-responsive">
                        <table class="table  table-bordered">
                            <thead>
                            <tr >
                                <th width="30">#</th>
                                <th width="30"><input type="checkbox"></th>
                                <th>科目代码</th>
                                <th>考试名称</th>
                                <th>考试难度</th>
                                <th>考试分数</th>
                                <th>考试时长</th>
                                <th width="100">操作</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${pageInfo.list }" var="paper" varStatus="p">
                                <tr>
                                    <td>${p.count }</td>
                                    <td><input type="checkbox"></td>
                                    <td>${paper.paperName }</td>
                                    <td>${paper.paperType }</td>
                                    <td>${paper.paperDegree }</td>
                                    <td>${paper.paperScore }</td>
                                    <td>${paper.examTime }</td>
                                    <td>
                                        <button type="button" id="startExam" onclick="startExam(${paper.id })" class="btn btn-success btn-xs"><i class=" glyphicon glyphicon-check">进入考试</i></button>
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

<script src="../../jquery/jquery-2.1.1.min.js"></script>
<script src="../../bootstrap/js/bootstrap.min.js"></script>
<script src="../../script/docs.min.js"></script>
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
    function startExam(id){
        //alert("assignRole" + id);
        alert("paperId = " + id);
        location.href = "${PATH}/exam/startExam?id="+id;
    }
</script>
</body>
</html>
