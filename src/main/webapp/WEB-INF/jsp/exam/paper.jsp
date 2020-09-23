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
                    <form action="/exam/queryExam" method="post" class="form-inline" role="form" style="float:left;">
                        <input type="hidden" name="originPage" id = "originPage" value="paper" />
                        <div class="form-group has-feedback">
                            <div class="input-group">
                                <div class="input-group-addon">试卷名称</div>
                                <input class="form-control has-success" id="paperName" name="paperName" type="text" placeholder="请输入试卷名称">
                            </div>
                        </div>
                        <div class="form-group has-feedback">
                            <div class="input-group">
                                <div class="input-group-addon">科目类别</div>
                                <select id="paperType" name="paperType" style="width:150px; height:30px;">
                                    <option value="">全部科目</option>
                                    <c:forEach items="${exams}" var="exam">
                                        <option value="${exam.id}">${exam.examName}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                        <button type="submit" class="btn btn-warning"><i class="glyphicon glyphicon-search"></i> 查询</button>
                    </form>

                    <button type="button" class="btn btn-primary " style="float:right;" onclick="uploadFile()"><i class="glyphicon glyphicon-plus"></i>导入试卷</button>
<%--                <button type="button" class="btn btn-danger" style="float:right;margin-left:10px;"><i class=" glyphicon glyphicon-remove"></i> 删除</button>--%>
                    <button type="button" class="btn btn-primary" style="float:right;" onclick="addPaper()"><i class="glyphicon glyphicon-plus"></i>生成试卷</button>
                    <br>
                    <hr style="clear:both;">
                    <div class="table-responsive">
                        <table class="table  table-bordered">
                            <thead>
                            <tr >
                                <th width="30">#</th>
                                <th width="30"><input type="checkbox"></th>
                                <th>试卷类别</th>
                                <th>试卷名称</th>
                                <th>试卷等级</th>
                                <th>试卷分值</th>
                                <th>考试时长</th>
                                <th>创建时间</th>
                                <th>试卷状态</th>
                                <th width="100">操作</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${pageInfo.list }" var="paper" varStatus="p">
                                <tr>
                                    <td>${p.count }</td>
                                    <td><input type="checkbox"></td>
                                    <td>${paper.paperType }</td>
                                    <td>${paper.paperName }</td>
                                    <td>${paper.paperDegree }</td>
                                    <td>${paper.paperScore }</td>
                                    <td>${paper.examTime }</td>
                                    <td>${paper.createDate }</td>
                                    <td>${paper.paperStatus }</td>
                                    <td>
                                        <button type="button" id="releasePaper" onclick="assignRole(${paper.id })" class="btn btn-success btn-xs"><i class="glyphicon glyphicon-circle-arrow-up"></i></button>
                                        <button type="button" id="updatePaper" onclick="updatePaper(${paper.id })" class="btn btn-primary btn-xs"><i class=" glyphicon glyphicon-pencil"></i></button>
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
                                            <li><a href="paper?pn=${pageInfo.pageNum-1 }" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li>
                                        </c:if>
                                        <c:forEach items="${pageInfo.navigatepageNums }" var="page_Num">
                                            <c:if test="${page_Num == pageInfo.pageNum }">
                                                <li class="active"><a href="#">${page_Num }</a></li>
                                            </c:if>
                                            <c:if test="${page_Num != pageInfo.pageNum }">
                                                <li><a href="paper?pn=${page_Num }">${page_Num }</a></li>
                                            </c:if>
                                        </c:forEach>
                                        <c:if test="${pageInfo.hasNextPage }">
                                            <li><a href="paper?pn=${pageInfo.pageNum+1 }" aria-label="Next"><span aria-hidden="true">&raquo;</span></a></li>
                                        </c:if>
                                        <li><a href="paper?pn=${pageInfo.pages }">尾页</a></li>
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
    function addPaper() {
        //在这里面输入任何合法的js语句
        layer.open({
            type: 1 //Page层类型
            ,area: ['420px', '670px']
            ,title: '试卷生成界面'
            ,shade: 0.6 //遮罩透明度
            ,maxmin: false //允许全屏最小化
            ,anim: 1 //0-6的动画形式，-1不开启
            ,content: '<form action="/exam/addPaper" method="post">\n' +
                '    <div style=\'width:350px;\'>\n' +
                '        <div style=\'width:320px;margin-left: 3%;\' class=\'form-group has-feedback\'>\n' +
                '            <p>试卷名称</p><input id=\'paperName\' class=\'form-control\' type=\'text\' name=\'paperName\' placeholder="请输入考试名称"/>\n' +
                '        </div>\n' +
                '        <div style=\'width:320px;margin-left: 3%;\' class=\'form-group has-feedback\'>\n' +
                '            <p>考试类别</p>\n' +
                '            <select id="paperType" name="paperType" style="width:150px; height:30px;">\n' +
                '                <option value="">全部科目</option>\n' +
                '                <c:forEach items="${exams}" var="exam">\n' +
                '                    <option value="${exam.id}">${exam.examName}</option>\n' +
                '                </c:forEach>\n' +
                '            </select>\n' +
                '        </div>\n' +
                '        <div style=\'width:320px;margin-left: 3%;\' class=\'form-group has-feedback\'>\n' +
                '            <p>试卷难度</p>\n' +
                '            <select id="paperDegree" name="paperDegree" style="width:150px; height:30px;">\n' +
                '                <option value="困难">困难</option>\n' +
                '                <option value="中等">中等</option>\n' +
                '                <option value="简单">简单</option>\n' +
                '            </select>\n' +
                '        </div>\n' +
                '        <div style=\'width:320px;margin-left: 3%;\' class=\'form-group has-feedback\'>\n' +
                '            <p>单选题数量</p><input id=\'singleQuestion\' class=\'form-control\' type=\'number\' name=\'singleQuestion\' />\n' +
                '        </div>\n' +
                '        <div style=\'width:320px;margin-left: 3%;\' class=\'form-group has-feedback\'>\n' +
                '            <p>试卷分数</p><input id=\'paperScore\' class=\'form-control\' type=\'number\' minlength="1" maxlength="3" name=\'paperScore\' />\n' +
                '        </div>\n' +
                '        <div style=\'width:320px;margin-left: 3%;\' class=\'form-group has-feedback\'>\n' +
                '            <p>考试时间</p><input id=\'examTime\' class=\'form-control\' type=\'text\' name=\'examTime\' οnchange="javascript:if(!/^(20|21|22|23|[0-1]?\\d):[0-5]?\\d:[0-5]?\\d$/.test(this.value)){alert(\'时间格式不正确!\');};">\n' +
                '            <button style=\'margin-top:5%;\' type=\'submit\' class=\'btn btn-block btn-success btn-lg\'>生成试卷</button>\n' +
                '        </div>\n' +
                '</form>'
        });
    }
    //上传文件
    function uploadFile(){
        layer.open({
            type: 1,
            skin: 'layui-layer-rim', //加上边框
            area: ['420px', '240px'], //宽高
            content: '<form class="form-inline" method="post" action="/exam/fileUpload" enctype="multipart/form-data">\n' +
                '    <div class="form-group">\n' +
                '        <label for="name" style="margin-top: 5px;">上传文件</label>\n' +
                '    </div><br>\n' +
                '    <div style=\'width:100px;margin-left: 3%;\' class=\'form-group has-feedback\'>\n' +
                '        <input type="file" class="form-control input-sm" id="fileName" name="fileName" placeholder="文件名称" style="width:202px; height:32px; padding-left:5px; padding-top:4px;">\n' +
                '        <button type="button" id="upload" name="upload" onclick="uploadFile()" class="btn btn-block btn-success btn-lg" >上传</button>\n' +
                '    </div>\n' +
                '</form>'
        });
    }
    // layui.use('upload', function(){
    //     var upload = layui.upload;
    //     //执行实例
    //     var uploadInst = upload.render({
    //         elem: '#fileUpload' //绑定元素
    //         ,url: 'fileUpload' //上传接口
    //         ,done: function(res){
    //             //上传完毕回调
    //             alert("success");
    //         }
    //         ,error: function(){
    //             //请求异常回调
    //         }
    //     });
    // });
    /* $("tbody .btn-success").click(function(){
        window.location.href = "assignRole.html";
    });
    $("tbody .btn-primary").click(function(){
        window.location.href = "edit.html";
    }); */
    function updatePaper(id){
        //alert("assignRole" + id);
        location.href = "${PATH}/exam/paperUpdate?id="+id;
    }
    function uploadFile(){
        $("#fileName").val($("#fileName").val());
        if($("#fileName").val() == '')
            return;
        var formData = new FormData();
        formData.append('excelFile', $('#fileName')[0].files[0]);
        $.ajax({
            url : '${PATH}/exam/uploadFile',
            type : 'post',
            data : formData,
            contentType: false,
            processData: false,
            success:function (data) {

            },
            error:function (data) {

                $.messager.alert("消息提醒","上传失败！","waring");
            }
        });
    }
</script>
</body>
</html>
