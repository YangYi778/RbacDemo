<%@ page language="java" contentType="text/html;charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@page isELIgnored="false" %>

<!-- 通过动态标签引入公共jsp页面 -->
<%--<%@ include file="/WEB-INF/jsp/common/header.jsp"%>--%>

<!DOCTYPE html>
<html lang="zh_CN">
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="${PATH}/css/font-awesome.min.css">
	<link rel="stylesheet" href="${PATH}/css/login.css">
	<link rel="stylesheet" href="${PATH}/bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" href="${PATH}/bootstrap/css/bootstrapValidator.min.css">


	<title>注册页面</title>
	<%--<script src="../../layer/layer.js"></script>--%>
	<script type="text/javascript">
        function validLoginName(obj){

            if(obj.value!=null && obj.value!=""){

                //开始发送异步请求校验登录名是否存在
                $.ajax({
                    type: "POST",//请求的方式
                    url: "/user/vaildationLongName",//请求的地址
                    data: "userName="+obj.value,//需要传递至后台的参数
                    success: function(msg){//如果后台正常处理数据，没有出现异常则会自动回调 success中的函数，后台会将消息赋给  msg
                        if(msg !=""){
                            //alert(msg);
                            $("#message").html(msg)
                            obj.value = "";
                        }else{
                            $("#message").html("")
                        }
                    }, error:function(){ //如果后台出现异常
                                            alert("网络出现异常！");
                                        }
                });
            }

        }


	</script>

</head>
<body>
<!-- 横幅导航条开始 -->
<%@include file="/WEB-INF/jsp/common/head.jsp"%>

<!--  横幅下方的主体开始 -->
<div class="container">
	<div class="row info-content">
		<form id="registerForm" class="form-horizontal" method="post"
			  action="${pageContext.request.contextPath}/user/register" style="margin-top: 20px;" >
			<div class="form-group">
				<label class="col-sm-2 control-label">登录名称</label>
				<div class="col-sm-3">
					<input type="text" value="" id="userName" name="userName"
						   class="form-control"  placeholder="请输入您的登陆名称"  onblur = "validLoginName(this)"
						   data-bv-notempty="true" data-bv-notempty-message="不能为空">
				</div><span id="message"></span>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label">真实姓名</label>
				<div class="col-sm-3">
					<input type="text" id="userTrueName"  name="userTrueName"
						   class="form-control"  placeholder="请输入您的真实姓名"
						   data-bv-notempty="true" data-bv-notempty-message="不能为空">
				</div>

			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label">登陆密码</label>
				<div class="col-sm-3">
					<input type="password" id="password" name="password"
						   class="form-control" placeholder="请输入您的密码"
						   data-bv-notempty="true" data-bv-notempty-message="不能为空">
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label">确认密码</label>
				<div class="col-sm-3">
					<input type="password" id="okPassword" name="okpassword"
						   class="form-control" placeholder="请输入您的确认密码"
						   data-bv-notempty="true" data-bv-notempty-message="不能为空">
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label">电子邮箱:</label>
				<div class="col-sm-3">
					<input type="text" id="email" value="" name="email"
						   class="form-control" placeholder="请输入您的邮箱"
						   data-bv-notempty="true" data-bv-notempty-message="不能为空">
				</div>
				<div class="col-sm-3">
					<span style="color: red;"></span>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label"></label>
				<div class="col-sm-3">
					<button id="submit" type="button" class="btn btn-success"  onclick="validate()">
						<span class="glyphicon glyphicon-user">注册</span>
					</button>
					<button type="reset" class="btn btn-info">
						<span class="glyphicon glyphicon-edit">重置</span>
					</button>
				</div>
			</div>
		</form>
	</div>
	<footer>
		<p>&copy; 版权所有，欢迎借鉴</p>
	</footer>

	<script src="${PATH}/jquery/jquery-3.5.1.min.js"></script>
	<script src="${PATH}/bootstrap/js/bootstrap.js"></script>
	<script src="${PATH}/bootstrap/js/bootstrapValidator.js"></script>
	<script src="${PATH}/bootstrap/js/zh_CN.js"></script>
	<script src="${PATH}/layer/layer.js"></script>
	<script>

        $('#registerForm').bootstrapValidator({
            //       live: 'disabled',
            message : 'This value is not valid',
            feedbackIcons : {
                valid : 'glyphicon glyphicon-ok',
                invalid : 'glyphicon glyphicon-remove',
                validating : 'glyphicon glyphicon-refresh'
            },
            fields : {
                userTrueName: {
                    validators : {
                        notEmpty : {
                            message : '真实姓名不能为空'
                        }
                    }
                },
                userName: {
                    message : '用户名验证失败',
                    validators : {
                        notEmpty : {
                            message : '用户名不能为空'
                        },
                        stringLength : {
                            min : 2,
                            max : 15,
                            message : '用户名长度2到15位'
                        }
                    }
                },
                email: {
                    validators : {
                        notEmpty : {
                            message : '邮箱不能为空'
                        },
                        emailAddress : {
                            message : '邮箱格式不正确'
                        }
                    }
                },
                password : {
                    validators : {
                        notEmpty : {
                            message : '密码不能为空'
                        },
                        different : {
                            field : 'loginName',
                            message : '用户名和密码不能相同'
                        },
                        stringLength : {
                            min : 6,
                            max : 15,
                            message : '密码长度6到15位'
                        }
                    }
                },
                okpassword : {
                    validators : {
                        notEmpty : {
                            message : '确认密码不能为空'
                        },
                        identical : {
                            field : 'password',
                            message : '两次密码不相同'
                        },
                        different : {
                            field : 'loginName',
                            message : '用户名和密码不能相同'
                        }
                    }
                }
            }
        });
        function validate() {
            var flag = $("#registerForm").data("bootstrapValidator").isValid();
            if (flag){
                $('#submit').attr("disabled",true);
                var userName = $("#userName").val();
                var password = $("#password").val();
                var userTrueName = $("#userTrueName").val();
                var email = $("#email").val();
                var loadingIndex = null;
                $.ajax({
                    type: "POST",
                    url: "${pageContext.request.contextPath}/user/doregister",
                    data:{"userName":userName,
                        "password":password,
                        "userTrueName":userTrueName,
                        "email":email
                    },
                    beforeSend:function(){
                        loadingIndex = layer.msg("数据正在处理中，请稍后",{icon:16});
                    },
                    success: function (result) {
                        //关闭处理loading
                        layer.close(loadingIndex);
                        //接收返回数据
                        if(result.success){
                            layer.msg("注册成功！已发送激活邮件，请激活账号",{timer:100,icon:6,shift:6},function(){});
                        }else{
                            layer.msg("注册失败！",{timer:100,icon:5,shift:6},function(){});
                        }
                    }
                });
			}else {
                layer.msg("请根据提示，将信息填写完整！",{timer:100,icon:0,shift:6},function(){});
			}
        };
	</script>
</div>
<!--  横幅下方的主体结束 -->
</body>
</html>