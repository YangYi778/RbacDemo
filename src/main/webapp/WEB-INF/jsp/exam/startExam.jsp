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

    <title>在线考试界面</title>
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
                <form action="exam/paperSubmit" method="post">
                    <div class="test_title">
                        <p class="test_time">
                            <i class="icon iconfont">&#xe6fb;</i><b class="alt-1">${paper.examTime}</b>
                        </p>
                        <font><input type="button" onclick="paperSubmit()" name="test_jiaojuan" value="交卷"></font>
                    </div>

                    <div class="test_content">
                        <div class="test_content_title">
                            <h2>单选题</h2>
                            <p>
                                <span>共</span><i class="content_lit">60</i><span>题，</span><span>合计</span><i class="content_fs">${paper.paperScore}</i><span>分</span>
                            </p>
                        </div>
                    </div>
                    <div class="test_content_nr">
                        <ul>
                            <c:forEach items="${questions}" var="question" varStatus="q">
                                <li id="qu_0_0">
                                    <div class="test_content_nr_tt">
                                        <i>${q.count}</i><span>( ${question.queScore} 分)</span><font>${question.queInfo}</font><b class="icon iconfont">&#xe881;</b>
                                    </div>

                                    <div class="test_content_nr_main">
                                        <ul>
                                            <li class="option">
                                                <input type="radio" class="radioOrCheck" name="answer${q.count}"
                                                       id="0_answer_${q.count}_option_1" />
                                                <label for="0_answer_${q.count}_option_1">
                                                    A.
                                                    <p class="ue" style="display: inline;">${question.optA}</p>
                                                </label>
                                            </li>
                                            <li class="option">
                                                <input type="radio" class="radioOrCheck" name="answer${q.count}"
                                                       id="0_answer_${q.count}_option_2" />
                                                <label for="0_answer_${q.count}_option_2">
                                                    B.
                                                    <p class="ue" style="display: inline;">${question.optB}</p>
                                                </label>
                                            </li>
                                            <li class="option">
                                                <input type="radio" class="radioOrCheck" name="answer${q.count}"
                                                       id="0_answer_${q.count}_option_3" />
                                                <label for="0_answer_${q.count}_option_3">
                                                    C.
                                                    <p class="ue" style="display: inline;">${question.optC}</p>
                                                </label>
                                            </li>
                                            <li class="option">
                                                <input type="radio" class="radioOrCheck" name="answer${q.count}"
                                                       id="0_answer_${q.count}_option_4" />
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
                                <span>共</span><i class="content_lit">60</i><span>题</span>
                            </p>
                        </div>
                        <div class="rt_content_nr answerSheet">
                            <ul>
                                <li><a href="#qu_0_0">1</a></li>
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
            debugger;
            var examId = $(this).closest('.test_content_nr_main').closest('li').attr('id'); /*得到题目ID*/
            var cardLi = $('a[href=#' + examId + ']'); /*根据题目ID找到对应答题卡*/
            /*设置已答题*/
            if (!cardLi.hasClass('hasBeenAnswer')) {
                cardLi.addClass('hasBeenAnswer');
            }

        });
    });
</script>


</body>

</html>
<!--下面是无用代码-->
<a href="http://www.bootstrapmb.com" style="display:none">bootstrapmb</a>

