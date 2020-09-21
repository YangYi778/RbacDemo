<%--
  Created by IntelliJ IDEA.
  User: 万恶de亚撒西
  Date: 2020/9/14
  Time: 22:52
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
    <meta name="keys" content="">
    <meta name="author" content="">
    <link rel="stylesheet" href="../../bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="../../bootstrap/css/bootstrapValidator.min.css">
    <link rel="stylesheet" href="../../css/font-awesome.min.css">
    <link rel="stylesheet" href="../../css/login.css">
    <style>

    </style>
</head>
<body>
<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
    <div class="container">
        <div class="navbar-header">
            <div><a class="navbar-brand" href="index.html" style="font-size:32px;">RBAC 考试系统平台</a></div>
        </div>
    </div>
</nav>

<div class="container">
    <!-- 入门-->
    <!-- 登录界面 -->
    <div class="page-header">
        <h1>用户登录</h1>&nbsp; <font color="red">${error_message}</font><font color="red">${message}</font>
    </div>
    <form id="loginform" class="form-horizontal" method="post"
          action="${pageContext.request.contextPath}/user/doAjaxLogin">
        <div class="form-group">
            <div class="col-sm-4">
                <input  class="form-control" placeholder="用户名" type="text"
                        id="userName" name="userName"
                       data-bv-notempty="true" data-bv-notempty-message="用户名不能为空"/>
            </div>
        </div>

        <div class="form-group">
            <div class="col-sm-4">
                <input  class="form-control"  placeholder="密码" type="password"
                        name="password" id="password"
                        data-bv-notempty="true" data-bv-notempty-message="密码不能为空"/>
            </div>
        </div>
        <div class="form-group">
            <div class="col-sm-4">
                <span style="color: red;"></span>
            </div>
        </div>

        <div class="form-group">
            <div class="col-sm-4">
                <div class="btn-group btn-group-justified" role="group"
                     aria-label="...">
                    <div class="btn-group" role="group">
                        <button type="submit" id="loginBtn" class="btn btn-success" onclick="dologin()">
                        <span class="glyphicon glyphicon-log-in"></span>&nbsp;登录
                    </button>
                    </div>
                    <div class="btn-group" role="group">
                        <button type="button" class="btn btn-danger" onclick="window.location = '${pageContext.request.contextPath}/register'">
                            <span class="glyphicon glyphicon-edit"></span>注册
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </form>
    <hr>

    <script src="/jquery/jquery-3.5.1.min.js"></script>
    <script src="/bootstrap/js/bootstrap.min.js"></script>
    <script src="/bootstrap/js/bootstrapValidator.min.js"></script>
    <script src="/bootstrap/js/zh_CN.js"></script>
    <script src="/layer/layer.js"></script>
    <script>
        $('#loginform').bootstrapValidator({
            message : 'This value is not valid',
                feedbackIcons : {
                valid : 'glyphicon glyphicon-ok',
                    invalid : 'glyphicon glyphicon-remove',
                    validating : 'glyphicon glyphicon-refresh'
            },fields:{
                userName:{
                    validators:{
                        notEmpty:{
                            message:'用户名不为空'
                        },
                        stringLength: {
                            min : 2,
                            max : 15,
                            message : '用户名长度2到15位'
                        }
                    }
                },
                password:{
                  validators:{
                      notEmpty:{
                          message:'密码不为空'
                      },
                      stringLength : {
                          min : 6,
                          max : 15,
                          message : '密码长度6到15位'
                      }
                  }
                }
            }
        });
    </script>
    <footer>
        <p>&copy; 版权所有，欢迎借鉴</p>
    </footer>

</div>
</body>
</html>