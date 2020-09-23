<%--
  Created by IntelliJ IDEA.
  User: 万恶de亚撒西
  Date: 2020/9/21
  Time: 13:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
9月23日的工作：完善科目功能的基础增删改
<body>
<form action="/exam/addPaper" method="post">
    <div style='width:350px;'>
        <div style='width:320px;margin-left: 3%;' class='form-group has-feedback'>
            <p>试卷名称</p><input id='paperName' class='form-control' type='text' name='paperName' placeholder="请输入考试名称"/>
        </div>
        <div style='width:320px;margin-left: 3%;' class='form-group has-feedback'>
            <p>考试类别</p>
            <select id="paperType" name="paperType" style="width:150px; height:30px;">
                <option value="">全部科目</option>
                <c:forEach items="${exams}" var="exam">
                    <option value="${exam.id}">${exam.examName}</option>
                </c:forEach>
            </select>
        </div>
        <div style='width:320px;margin-left: 3%;' class='form-group has-feedback'>
            <p>试卷难度</p>
            <select id="paperDegree" name="paperDegree" style="width:150px; height:30px;">
                <option value="困难">困难</option>
                <option value="中等">中等</option>
                <option value="简单">简单</option>
            </select>
        </div>
        <div style='width:320px;margin-left: 3%;' class='form-group has-feedback'>
            <p>单选题数量</p><input id='singleQuestion' class='form-control' type='number' name='singleQuestion' />
        </div>
        <div style='width:320px;margin-left: 3%;' class='form-group has-feedback'>
            <p>试卷分数</p><input id='paperScore' class='form-control' type='number' minlength="1" maxlength="3" name='paperScore' />
        </div>
        <div style='width:320px;margin-left: 3%;' class='form-group has-feedback'>
            <p>考试时间</p><input id='examTime' class='form-control' type='text' name='examTime' οnchange="javascript:if(!/^(20|21|22|23|[0-1]?\d):[0-5]?\d:[0-5]?\d$/.test(this.value)){alert('时间格式不正确!');};">
            <button style='margin-top:5%;' type='submit' class='btn btn-block btn-success btn-lg'>生成试卷</button>
        </div>
</form>

<form class="form-inline" method="post" action="fileUpload" enctype="multipart/form-data">
    <div class="form-group">
        <label for="name" style="margin-top: 5px;">上传文件:</label>
    </div><br>
    <div style='width:320px;margin-left: 3%;' class='form-group has-feedback'>
        <lable>试卷类别</lable>
        <select id="paperType" name="paperType" style="width:150px; height:30px;">
            <option value="">全部科目</option>
            <c:forEach items="${exams}" var="exam">
                <option value="${exam.id}">${exam.examName}</option>
            </c:forEach>
        </select>
    </div>
    <div style='width:100px;margin-left: 3%;' class='form-group has-feedback'>
        <input type="file" class="form-control input-sm" id="fileName" name="fileName" placeholder="文件名称" style="width:202px; height:32px; padding-left:5px; padding-top:4px;">
        <button type="submit" class="btn btn-block btn-success btn-lg" >上传</button>
    </div>
</form>

<form action="/exam/addQuestion" method="post">
    <div style='width:320px;margin-left: 3%;' class='form-group has-feedback'>
        <lable for="paperType">科目类别</lable>
        <select id="paperType" name="paperType" style="width:150px; height:30px;">
            <c:forEach items="${exams}" var="exam">
                <option value="${exam.id}">${exam.examName}</option>
            </c:forEach>
        </select>
    </div>
    <div style='width:350px;'>
        <div style='width:320px;margin-left: 3%;' class='form-group has-feedback'>
            <label>试题信息</label><input id='queInfo' class='form-control' type='text' name='queInfo'/>
        </div>
        <div style='width:320px;margin-left: 3%;' class='form-group has-feedback'>
            <label>试题类别</label>
            <select id="queType" name="queType" style="width:150px; height:30px;">
                <option value="单选题">单选题</option>
                <option value="多选题">多选题</option>
                <option value="简答题">简答题</option>
            </select>
        </div>
        <div style='width:320px;margin-left: 3%;' class='form-group has-feedback'>
            <label>选项A</label><input id='optA' class='form-control' type='text' name='optA' />
        </div>
        <div style='width:320px;margin-left: 3%;' class='form-group has-feedback'>
            <label>选项B</label><input id='optB' class='form-control' type='text' name='optB' />
        </div>
        <div style='width:320px;margin-left: 3%;' class='form-group has-feedback'>
            <label>选项C</label><input id='optC' class='form-control' type='text' name='optC' />
        </div>
        <div style='width:320px;margin-left: 3%;' class='form-group has-feedback'>
            <label>选项D</label><input id='optD' class='form-control' type='text' name='optD' />
        </div><div style='width:320px;margin-left: 3%;' class='form-group has-feedback'>
            <label>正确答案</label><input id='answer' class='form-control' type='text' name='answer' />
        </div>
        <button type="submit" class="btn btn-block btn-success btn-lg">确认添加</button>
</form>


<form class="layui-form" action="/exam/addQuestion" method="post">
    <input type="hidden" id="queId" value="${id}">
    <div class="layui-form-item">
        <label class="layui-form-label">科目类别</label>
        <div class="layui-input-block">
            <select id="paperType" name="paperType" lay-verify="required">
                <c:forEach items="${exams}" var="exam">
                    <option value="${exam.id}">${exam.examName}</option>
                </c:forEach>
            </select>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">试题信息</label>
        <div class="layui-input-block">
            <input type="text" id="queInfo" name="queInfo" required  lay-verify="required"  autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">试题难度</label>
        <div class="layui-input-block">
            <select id="queDegree" name="queDegree" lay-verify="required">
                <option value="简单">简单</option>
                <option value="一般">一般</option>
                <option value="困难">困难</option>
            </select>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">试题分数</label>
        <div class="layui-input-block">
            <input type="text" id="queScore" name="queScore" required  lay-verify="required"  autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">选项A</label>
        <div class="layui-input-block">
            <input type="text" id="optA" name="optA" required  lay-verify="required"  autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">选项B</label>
        <div class="layui-input-block">
            <input type="text" id="optB" name="optB" required  lay-verify="required"  autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">选项C</label>
        <div class="layui-input-block">
            <input type="text" id="optC" name="optC" required  lay-verify="required"  autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">选项D</label>
        <div class="layui-input-block">
            <input type="text" id="optD" name="optD" required  lay-verify="required"  autocomplete="off" class="layui-input">
        </div>
    </div>
    </div><div class="layui-form-item">
        <label class="layui-form-label">正确答案</label>
        <div class="layui-input-block">
            <input type="text" id="answer" name="answer" required  lay-verify="required"  autocomplete="off" class="layui-input">
        </div>
    </div>

</form>

<form action="/exam/updateExam" method="post">
    <div style='width:320px;margin-left: 3%;' class='form-group has-feedback'>
        <label>科目代码</label><input id='id' class='form-control' type='text' name='id'/>
    </div>
    <div style='width:320px;margin-left: 3%;' class='form-group has-feedback'>
        <label>科目名称</label><input id='examName' class='form-control' type='text' name='examName'/>
    </div>
    <div style='width:320px;margin-left: 3%;' class='form-group has-feedback'>
        <label>科目备注</label><input id='examInfo' class='form-control' type='text' name='examInfo'/>
    </div>
    <button type="submit" class="btn btn-block btn-success btn-lg">确认添加</button>
</form>

</body>
</html>
