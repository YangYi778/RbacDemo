<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>Gentelella Alela! | </title>

    <!-- Bootstrap -->
    <link href="${path}/vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="${path}/vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <!-- NProgress -->
    <link href="${path}/vendors/nprogress/nprogress.css" rel="stylesheet">
    <!-- Animate.css -->
    <link href="${path}/vendors/animate.css/animate.min.css" rel="stylesheet">

    <!-- Custom Theme Style -->
    <link href="${path}/build/css/custom.min.css" rel="stylesheet">
</head>

<body class="login">
<div>
    <a class="hiddenanchor" id="signup"></a>
    <a class="hiddenanchor" id="signin"></a>

    <div class="login_wrapper">
        <div class="animate form login_form">
            <section class="login_content">
                <form id="loginform"  method="post" action="${path}/user/doAjaxLogin">
                    <h1>欢迎登录</h1>
                    <div class="field item form-group">
                        <label class="col-form-label col-md-3 col-sm-3  label-align">用户名<span class="required">*</span></label>
                        <div class="col-md-8 col-sm-8">
                            <input id="userName" name="userName"  class="form-control"
                                   type="text" data-validate-length-range="2"  required="" />
                        </div>
                    </div>
                    <%--<div class="form-group">
                        <input type="text" class="form-control" placeholder="用户名" required=""
                               id="userName" name="userName"/>
                    </div>--%>
                    <div class="field item form-group">
                        <label class="col-form-label col-md-3 col-sm-3  label-align">密&nbsp&nbsp码<span class="required">*</span></label>
                        <div class="col-md-8 col-sm-8">
                            <input class="form-control" type="password" id="password" name="password"
                                   pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%^&*]).{8,}"
                                   title="Minimum 8 Characters Including An Upper And Lower Case Letter, A Number And A Unique Character" required />
                            <span style="position: absolute;right:15px;top:7px;" onclick="hideshow()" >
													<i id="slash" class="fa fa-eye-slash"></i>
													<i id="eye" class="fa fa-eye"></i>
                            </span>
                        </div>
                    </div>
                    <%--<div class="form-group">
                        <input type="password" class="form-control" placeholder="密  码" required=""
                               name="password" id="password"
                               data-bv-notempty="true" data-bv-notempty-message="密码不能为空"/>
                    </div>--%>
                    <div>
                        <a class="btn btn-default submit" onclick="document:loginform.submit()">登录</a>
                        <a class="reset_pass" onclick="document:loginform.reset()">重置</a>
                    </div>

                    <div class="clearfix"></div>

                    <div class="separator">
                        <p class="change_link">还没有账号？
                            <a href="#signup" class="to_register"> 创建你的账号 </a>
                        </p>

                        <div class="clearfix"></div>
                        <br />

                        <div>
                            <h1><i class="fa fa-paw"></i> Gentelella Alela!</h1>
                            <p>©2016 All Rights Reserved. Gentelella Alela! is a Bootstrap 3 template. Privacy and Terms</p>
                        </div>
                    </div>
                </form>
            </section>
        </div>

        <div id="register" class="animate form registration_form">
            <section class="login_content">
                <form>
                    <h1>注册账号</h1>

                    <div>
                        <input type="text" class="form-control" placeholder="用户名" required="" />
                    </div>
                    <div>
                        <input type="email" class="form-control" placeholder="邮 箱" required="" />
                    </div>
                    <div>
                        <input type="password" class="form-control" placeholder="密 码" required="" />
                    </div>
                    <div>
                        <a class="btn btn-default submit" href="index.html">Submit</a>
                    </div>

                    <div class="clearfix"></div>

                    <div class="separator">
                        <p class="change_link">Already a member ?
                            <a href="#signin" class="to_register"> Log in </a>
                        </p>

                        <div class="clearfix"></div>
                        <br />

                        <div>
                            <h1><i class="fa fa-paw"></i> Gentelella Alela!</h1>
                            <p>©2016 All Rights Reserved. Gentelella Alela! is a Bootstrap 3 template. Privacy and Terms</p>
                        </div>
                    </div>
                </form>
            </section>
        </div>
    </div>
</div>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
<script src="../vendors/validator/multifield.js"></script>
<script src="../vendors/validator/validator.js"></script>

<!-- Javascript functions	-->
<script>
    function hideshow(){
        var password = document.getElementById("password");
        var slash = document.getElementById("slash");
        var eye = document.getElementById("eye");

        if(password.type === 'password'){
            password.type = "text";
            slash.style.display = "block";
            eye.style.display = "none";
        }
        else{
            password.type = "password";
            slash.style.display = "none";
            eye.style.display = "block";
        }

    }
</script>

<script>
    // initialize a validator instance from the "FormValidator" constructor.
    // A "<form>" element is optionally passed as an argument, but is not a must
    var validator = new FormValidator({
        "events": ['blur', 'input', 'change']
    }, document.forms[0]);
    // on form "submit" event
    document.forms[0].onsubmit = function(e) {
        var submit = true,
            validatorResult = validator.checkAll(this);
        console.log(validatorResult);
        return validatorResult.valid;
    };
    // on form "reset" event
    document.forms[0].onreset = function(e) {
        validator.reset();
    };
    // stuff related ONLY for this demo page:
    $('.toggleValidationTooltips').change(function() {
        validator.settings.alerts = !this.checked;
        if (this.checked)
            $('form .alert').remove();
    }).prop('checked', false);

</script>

<!-- jQuery -->
<script src="../vendors/jquery/dist/jquery.min.js"></script>
<!-- Bootstrap -->
<script src="../vendors/bootstrap/dist/js/bootstrap.bundle.min.js"></script>
<!-- FastClick -->
<script src="../vendors/fastclick/lib/fastclick.js"></script>
<!-- NProgress -->
<script src="../vendors/nprogress/nprogress.js"></script>
<!-- validator -->
<!-- <script src="../vendors/validator/validator.js"></script> -->

<!-- Custom Theme Scripts -->
<script src="../build/js/custom.min.js"></script>
</body>
</html>
