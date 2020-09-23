<%--
  Created by IntelliJ IDEA.
  User: 万恶de亚撒西
  Date: 2020/9/17
  Time: 20:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="content-type" content="text/html;charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

    <title>jQuery在线考试倒计时界面</title>
    <link href="/css/time.css" rel="stylesheet" type="text/css" />

    <link href="/css/test.css" rel="stylesheet" type="text/css" />

    <style>
        .hasBeenAnswer {
            background: #5d9cec;
            color: #fff;
        }

        .reading h2 {
            width: 100%;
            margin: 20px 0 70px;
            text-align: center;
            line-height: 2;
            font-size: 20px;
            color: #59595b;
        }

        .reading h2 a {
            text-decoration: none;
            color: #59595b;
            font-size: 20px;
        }

        .reading h2 a:hover {
            color: #2183f1;
        }
    </style>
</head>

<body>
<div class="main">
    <!--nr start-->
    <div class="test_main">
        <div class="nr_left">
            <div class="test">
                <form action="" method="post">
                    <div class="test_title">
                        <p class="test_time">
                            <i class="icon iconfont">&#xe6fb;</i><b class="alt-1">${paper.examTime}</b>
                        </p>
                        <font><input type="button" name="test_jiaojuan" onclick="paperSubmit()" value="交卷"></font>
                    </div>

                    <div class="test_content">
                        <div class="test_content_title">
                            <h2>单选题</h2>
                            <p>
                                <span>共</span><i class="content_lit">${questions.size()}</i><span>题，</span><span>合计</span><i class="content_fs">${paper.paperScore}</i><span>分</span>
                            </p>
                        </div>
                    </div>
                    <div class="test_content_nr">
                        <ul>
                            <c:forEach items="${questions}" var="question" varStatus="q">
                                <li id="qu_0_${q.count - 1}">
                                    <div class="test_content_nr_tt">
                                        <i>${q.count}</i><span>( ${question.queScore} 分)</span><font>${question.queInfo}</font><b class="icon iconfont">&#xe881;</b>
                                    </div>

                                    <div class="test_content_nr_main">
                                        <ul>
                                            <li class="option">
                                                <input type="radio" class="radioOrCheck" name="answer${q.count}"
                                                       id="0_answer_${q.count}_option_1" value="A" />
                                                <label for="0_answer_${q.count}_option_1">
                                                    A.
                                                    <p class="ue" style="display: inline;">${question.optA}</p>
                                                </label>
                                            </li>
                                            <li class="option">
                                                <input type="radio" class="radioOrCheck" name="answer${q.count}"
                                                       id="0_answer_${q.count}_option_2" value="B"/>
                                                <label for="0_answer_${q.count}_option_2">
                                                    B.
                                                    <p class="ue" style="display: inline;">${question.optB}</p>
                                                </label>
                                            </li>
                                            <li class="option">
                                                <input type="radio" class="radioOrCheck" name="answer${q.count}"
                                                       id="0_answer_${q.count}_option_3" value="C"/>
                                                <label for="0_answer_${q.count}_option_3">
                                                    C.
                                                    <p class="ue" style="display: inline;">${question.optC}</p>
                                                </label>
                                            </li>
                                            <li class="option">
                                                <input type="radio" class="radioOrCheck" name="answer${q.count}"
                                                       id="0_answer_${q.count}_option_4" value="D"/>
                                                <label for="0_answer_${q.count}_option_4">
                                                    D.
                                                    <p class="ue" style="display: inline;">${question.optD}</p>
                                                </label>
                                            </li>
                                        </ul>
                                    </div>
                                </li>
                            </c:forEach>
                        </ul>
                    </div>
                </form>
            </div>
        </div>
        <div class="nr_right">
            <div class="nr_rt_main">
                <div class="rt_nr1">
                    <div class="rt_nr1_title">
                        <h1>
                            <i class="icon iconfont">&#xe692;</i>答题卡
                        </h1>
                        <p class="test_time">
                            <i class="icon iconfont">&#xe6fb;</i><b class="alt-1">${paper.examTime}</b>
                        </p>
                    </div>

                    <div class="rt_content">
                        <div class="rt_content_tt">
                            <h2>单选题</h2>
                            <p>
                                <span>共</span><i class="content_lit">${questions.size()}</i><span>题</span>
                            </p>
                        </div>
                        <div class="rt_content_nr answerSheet">
                            <ul>
                                <c:forEach items="${questions}" varStatus="que">
                                    <li><a href="#qu_0_${que.count - 1}">${que.count}</a></li>
                                </c:forEach>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--nr end-->

    <div class="foot"></div>

</div>

<script src="http://cdn.bootstrapmb.com/jquery/jquery-1.11.1.min.js" type="text/javascript"></script>
<script src="/jquery/jquery.easy-pie-chart.js" type="text/javascript"></script>
<!--时间js-->
<script src="/time/jquery.countdown.js" type="text/javascript"></script>
<script src="/layer/layer.js" type="text/javascript" ></script>
<script>
    window.jQuery(function ($) {
        "use strict";

        $('time').countDown({
            with_separators: false
        });
        $('.alt-1').countDown({
            css_class: 'countdown-alt-1'
        });
        $('.alt-2').countDown({
            css_class: 'countdown-alt-2'
        });

    });
    //第一次点击选中，第二次点击取消
    // $('input:radio').click(function(){
    //     //alert(this.checked);
    //     //
    //     var $radio = $(this);
    //     // if this was previously checked
    //     if ($radio.data('waschecked') == true){
    //         $radio.prop('checked', false);
    //         $radio.data('waschecked', false);
    //     } else {
    //         $radio.prop('checked', true);
    //         $radio.data('waschecked', true);
    //     }
    // });
    $(function () {
        $('li.option label').click(function () {
            //debugger;
            var examId = $(this).closest('.test_content_nr_main').closest('li').attr('id'); /*得到题目ID*/
            //alert("examId" + examId);
            var cardLi = $('a[href=#' + examId + ']'); /*根据题目ID找到对应答题卡*/
            //alert("cardLi"+cardLi);
            /*设置已答题*/
            if (!cardLi.hasClass('hasBeenAnswer')) {
                cardLi.addClass('hasBeenAnswer');
            }

        });

    });


    function paperSubmit() {
        //1.获取每个题目的选项（radio）
        //2.遍历题目的正确答案并累计得分
        var answers = new Array();      //正确答案数组
        var score = new Array();        //试题分数数组
        var queId = new Array();        //试题id数组
        <c:forEach items="${questions}" var="question">
            answers.push("${question.answer}");
            score.push("${question.queScore}");
            queId.push("${question.id}");
        </c:forEach>
        var totalScore = 0;                 //总分数组
        var radioName = new Array();        //获取所有radio的name
        var radioValue = new Array();       //根据name获取所有题目的选项
        var errorQue = new Array();         //错误答案数组
        $(":radio").each(function () {
            var temp = $(this).attr("name");
            console.info("temp = " + temp);
            radioName.push(temp);
            // debugger;
            // var item = $("input:radio[name="+$(this).attr("name")+"]:checked").val();
            // //alert(item);
            // console.info("item" + item);
            // console.info("answers[i]" + answers[i]);
            // if(item == answers[i]){
            //     totalScore += Number(score[i]);
            // }
            // i++;
        });
        var radio = newArr(radioName);              //去重
        $.each(radio,function (index,value) {
            var item = $("input[name="+value+"]:checked").val();
            console.info("item==" + item);
            radioValue.push(item);
        });
        for(i = 0, len = answers.length; i < len; i++){
            if(radioValue[i] == answers[i]){
                totalScore += Number(score[i]);
            }else{
                errorQue.push(queId[i]);
            }
        }
        $.ajax({
            type : "POST",
            url : "${PATH}/exam/paperSubmit",
            contentType : "application/x-www-form-urlencoded",
            data : {
                "errorQue" : errorQue,
                "totalScore" : totalScore,
                "paperId" : ${paper.id}
            },
            success : function (result) {
                if(result.success){
                    layer.msg("交卷成功！",{timer:1500,icon:1,shift:3},function () {});
                    location.href = "${PATH}/exam/close?paperId=${paper.id}&userId=${user.userId}&userScore="+totalScore;
                }else{
                    layer.msg("网络异常，请稍后重试！",{timer:1500,icon:0,shift:3},function () {});
                }
            }

        });
        alert("totalScore===" + totalScore);
        // $.each(radioName, function (i, val) {
        //     if (!checkRadio(val)) {
        //         layer.msg("您还有未做题目，请确认后交卷！",{timer:1000,icon:5,shift:0},function () {});
        //         return false;
        //     }
        // });
        // $.each(radioName,function(index,data){
        //     //判断标签的name值是否满足要求，满足则 取它的check值
        //     alert($("input[name="+radioName+"]:checked").val());
        // });


    }

    function newArr(arr) {
        for (var i = 0; i < arr.length; i++) {
            for (var j = i + 1; j < arr.length; j++) {
                if (arr[i] == arr[j]) {
                    //如果第一个等于第二个，splice方法删除第二个
                    arr.splice(j, 1);
                    j--;
                }
            }
        }
        return arr;
    }
    // function checkRadio(radioName){
    //     return $("input[name="+radioName+"]:checked").val() == null ? false : true;
    // }
</script>


</body>

</html>
<!--下面是无用代码-->
<a href="http://www.bootstrapmb.com" style="display:none">bootstrapmb</a>

