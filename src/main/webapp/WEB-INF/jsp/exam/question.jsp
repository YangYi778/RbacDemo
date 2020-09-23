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
                    <form action="/exam/question" method="post" class="form-inline" role="form" style="float:left;">
<%--                        <input type="hidden" name="originPage" id = "originPage" value="paper" />--%>
                        <div class="form-group has-feedback">
                            <div class="input-group">
                                <div class="input-group-addon">试题信息</div>
                                <input class="form-control has-success" id="keyword" name="keyword" type="text" placeholder="请输入试题信息">
                            </div>
                        </div>
                        <div class="form-group has-feedback">
                            <div class="input-group">
                                <div class="input-group-addon">科目类别</div>
                                <select id="examCode" name="examCode" style="width:150px; height:30px;">
                                    <option value="">全部科目</option>
                                    <c:forEach items="${exams}" var="exam">
                                        <option value="${exam.id}">${exam.examName}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                        <button type="submit" class="btn btn-warning"><i class="glyphicon glyphicon-search"></i> 查询</button>
                    </form>
                    <button type="button" class="btn btn-danger" style="float:right;margin-left:10px;"><i class=" glyphicon glyphicon-remove"></i> 删除</button>
                    <button type="button" class="btn btn-primary" style="float:right;" onclick="addQuestion()"><i class="glyphicon glyphicon-plus"></i> 新增</button>
                    <br>
                    <hr style="clear:both;">
                    <div class="table-responsive">
                        <table class="table  table-bordered">
                            <thead>
                            <tr >
                                <th width="30">#</th>
                                <th width="30"><input type="checkbox"></th>
                                <th width="80px">科目归属</th>
                                <th>试题题干</th>
                                <th width="80px">试题类型</th>
                                <th width="80px">试题分数</th>
                                <th>选项A</th>
                                <th>选项B</th>
                                <th>选项C</th>
                                <th>选项D</th>
                                <th width="80px">正确答案</th>
                                <th>创建时间</th>
                                <th width="100">操作</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${pageInfo.list }" var="question" varStatus="q">
                                <tr>
                                    <td>${q.count }</td>
                                    <td><input type="checkbox"></td>
                                    <td>${question.examCode }</td>
                                    <td>${question.queInfo }</td>
                                    <td>${question.queType }</td>
                                    <td>${question.queScore }</td>
                                    <td>${question.optA }</td>
                                    <td>${question.optB }</td>
                                    <td>${question.optC }</td>
                                    <td>${question.optD }</td>
                                    <td>${question.answer }</td>
                                    <td>${question.createDate }</td>
                                    <td>
<%--                                        <button type="button" id="assignRole" onclick="assignRole(${user.userId })" class="btn btn-success btn-xs"><i class=" glyphicon glyphicon-check"></i></button>--%>
                                        <button type="button" id="updateQuestion" onclick="updateQuestion(${question.id},'${question.queInfo }','${question.queType }',${question.queScore },'${question.optA }','${question.optB }','${question.optC }','${question.optD }','${question.answer }' )" class="btn btn-primary btn-xs"><i class=" glyphicon glyphicon-pencil"></i></button>
                                        <button type="button" onclick="deleteQuestion(${question.id})" class="btn btn-danger btn-xs"><i class=" glyphicon glyphicon-remove"></i></button>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                            <tfoot>
                            <tr>
                                <td colspan="6" align="center">
                                    <ul class="pagination">
                                        <li><a href="question?pn=1">首页</a></li>
                                        <c:if test="${pageInfo.hasPreviousPage }">
                                            <li><a href="question?pn=${pageInfo.pageNum-1 }" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li>
                                        </c:if>
                                        <c:forEach items="${pageInfo.navigatepageNums }" var="page_Num">
                                            <c:if test="${page_Num == pageInfo.pageNum }">
                                                <li class="active"><a href="#">${page_Num }</a></li>
                                            </c:if>
                                            <c:if test="${page_Num != pageInfo.pageNum }">
                                                <li><a href="question?pn=${page_Num }">${page_Num }</a></li>
                                            </c:if>
                                        </c:forEach>
                                        <c:if test="${pageInfo.hasNextPage }">
                                            <li><a href="question?pn=${pageInfo.pageNum+1 }" aria-label="Next"><span aria-hidden="true">&raquo;</span></a></li>
                                        </c:if>
                                        <li><a href="question?pn=${pageInfo.pages }">尾页</a></li>
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

    function deleteQuestion(id) {
        //询问框
        layer.confirm('是否确认删除？', {
            btn: ['确定了','再想想'] //按钮
        }, function(){
            $.ajax({
                type : 'post',
                url : '/exam/deleteQuestion',
                data : {"id" : id},
                success : function (result) {
                    if(result){
                        layer.msg('删除成功！', {icon: 1});
                    }else{
                        layer.msg('删除失败！', {icon: 0});
                    }
                }
            });
            location.reload();
        });

    }
    function updateQuestion(id,queInfo,queType,queScore,optA,optB,optC,optD,answer) {
        layer.open({
            type: 1,
            title: '修改试题信息界面',
            skin: 'layui-layer-rim', //加上边框
            area: ['450px', '680px'], //宽高
            content: '<form action="/exam/updateQuestion" method="post">\n' +
                '    <input type="hidden" id="id" name="id" value="'+id+'"> \n' +
                '    <div style=\'width:320px;margin-left: 3%;\' class=\'form-group has-feedback\'>\n' +
                '        <lable>科目类别</lable>\n' +
                '        <select id="examCode" name="examCode" style="width:150px; height:30px;">\n' +
                '            <c:forEach items="${exams}" var="exam">\n' +
                '                <option value="${exam.id}">${exam.examName}</option>\n' +
                '            </c:forEach>\n' +
                '        </select>\n' +
                '    </div>\n' +
                '    <div style=\'width:350px;\'>\n' +
                '        <div style=\'width:320px;margin-left: 3%;\' class=\'form-group has-feedback\'>\n' +
                '            <label>试题信息</label><input id=\'queInfo\' class=\'form-control\' type=\'text\' name=\'queInfo\' value="'+queInfo+'"/>\n' +
                '        </div>\n' +
                '        <div style=\'width:320px;margin-left: 3%;\' class=\'form-group has-feedback\'>\n' +
                '            <label>试题类别</label>\n' +
                '            <select id="queType" name="queType" style="width:150px; height:30px;">\n' +
                '                <option value="单选题">单选题</option>\n' +
                '                <option value="多选题">多选题</option>\n' +
                '                <option value="简答题">简答题</option>\n' +
                '            </select>\n' +
                '        </div>\n' +
                '        <div style=\'width:320px;margin-left: 3%;\' class=\'form-group has-feedback\'>\n' +
                '            <label>试题分值</label><input id=\'queScore\' class=\'form-control\' type=\'text\' name=\'queScore\' value="'+queScore+'"/>\n' +
                '        </div>\n' +
                '        <div style=\'width:320px;margin-left: 3%;\' class=\'form-group has-feedback\'>\n' +
                '            <label>选项A</label><input id=\'optA\' class=\'form-control\' type=\'text\' name=\'optA\' value="'+optA+'" />\n' +
                '        </div>\n' +
                '        <div style=\'width:320px;margin-left: 3%;\' class=\'form-group has-feedback\'>\n' +
                '            <label>选项B</label><input id=\'optB\' class=\'form-control\' type=\'text\' name=\'optB\' value="'+optB+'" />\n' +
                '        </div>\n' +
                '        <div style=\'width:320px;margin-left: 3%;\' class=\'form-group has-feedback\'>\n' +
                '            <label>选项C</label><input id=\'optC\' class=\'form-control\' type=\'text\' name=\'optC\' value="'+optC+'" />\n' +
                '        </div>\n' +
                '        <div style=\'width:320px;margin-left: 3%;\' class=\'form-group has-feedback\'>\n' +
                '            <label>选项D</label><input id=\'optD\' class=\'form-control\' type=\'text\' name=\'optD\' value="'+optD+'"/>\n' +
                '        </div><div style=\'width:320px;margin-left: 3%;\' class=\'form-group has-feedback\'>\n' +
                '            <label>正确答案</label><input id=\'answer\' class=\'form-control\' type=\'text\' name=\'answer\' value="'+answer+'" />\n' +
                '        </div>\n' +
                '        <button type="submit" class="btn btn-block btn-success btn-lg">确认修改</button>\n' +
                '</form>'
        });

    }
    /*添加试题
     */
    function addQuestion(){
        layer.open({
            type: 1,
            title: '添加试题信息界面',
            skin: 'layui-layer-rim', //加上边框
            area: ['450px', '680px'], //宽高
            content: '<form id="updateQuestionForm" action="/exam/updateQuestion" method="post">\n' +
                '    <div style=\'width:320px;margin-left: 3%;\' class=\'form-group has-feedback\'>\n' +
                '        <lable>科目类别</lable>\n' +
                '        <select id="examCode" name="examCode" style="width:150px; height:30px;">\n' +
                '                <c:forEach items="${exams}" var="exam">\n' +
                '                        <option value="${exam.id}">${exam.examName}</option>\n' +
                '                    </c:forEach>\n' +
                '            </select>\n' +
                '    </div>\n' +
                '    <div style=\'width:350px;\'>\n' +
                '        <div style=\'width:320px;margin-left: 3%;\' class=\'form-group has-feedback\'>\n' +
                '            <label>试题信息</label><input id=\'queInfo\' class=\'form-control\' type=\'text\' name=\'queInfo\'/>\n' +
                '        </div>\n' +
                '        <div style=\'width:320px;margin-left: 3%;\' class=\'form-group has-feedback\'>\n' +
                '            <label>试题类别</label>\n' +
                '            <select id="queType" name="queType" style="width:150px; height:30px;">\n' +
                '                <option value="单选题">单选题</option>\n' +
                '                <option value="多选题">多选题</option>\n' +
                '                <option value="简答题">简答题</option>\n' +
                '            </select>\n' +
                '        </div>\n' +
                '        <div style=\'width:320px;margin-left: 3%;\' class=\'form-group has-feedback\'>\n' +
                '            <label>试题分值</label><input id=\'queScore\' class=\'form-control\' type=\'text\' name=\'queScore\'/>\n' +
                '        </div>\n' +
                '        <div style=\'width:320px;margin-left: 3%;\' class=\'form-group has-feedback\'>\n' +
                '            <label>选项A</label><input id=\'optA\' class=\'form-control\' type=\'text\' name=\'optA\' />\n' +
                '        </div>\n' +
                '        <div style=\'width:320px;margin-left: 3%;\' class=\'form-group has-feedback\'>\n' +
                '            <label>选项B</label><input id=\'optB\' class=\'form-control\' type=\'text\' name=\'optB\' />\n' +
                '        </div>\n' +
                '        <div style=\'width:320px;margin-left: 3%;\' class=\'form-group has-feedback\'>\n' +
                '            <label>选项C</label><input id=\'optC\' class=\'form-control\' type=\'text\' name=\'optC\' />\n' +
                '        </div>\n' +
                '        <div style=\'width:320px;margin-left: 3%;\' class=\'form-group has-feedback\'>\n' +
                '            <label>选项D</label><input id=\'optD\' class=\'form-control\' type=\'text\' name=\'optD\' />\n' +
                '        </div><div style=\'width:320px;margin-left: 3%;\' class=\'form-group has-feedback\'>\n' +
                '            <label>正确答案</label><input id=\'answer\' class=\'form-control\' type=\'text\' name=\'answer\' />\n' +
                '        </div>\n' +
                '        <button type="submit" class="btn btn-block btn-success btn-lg">确认</button>\n' +
                '    </div>\n' +
                '</form>'
        });
    }
    /* $("tbody .btn-success").click(function(){
        window.location.href = "assignRole.html";
    });
    $("tbody .btn-primary").click(function(){
        window.location.href = "edit.html";
    }); */
    function updateExam(id){
        //alert("assignRole" + id);
        location.href = "${PATH}/exam/updateExam?id="+id;
    }
</script>
</body>


</html>
