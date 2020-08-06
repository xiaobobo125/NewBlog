<%--
  Created by IntelliJ IDEA.
  User: 12598
  Date: 2020/8/4
  Time: 11:08
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>用户注册</title>
    <link rel="shortcut icon" href="<%=request.getContextPath()%>/image/logo.png">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/layui/css/layui.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/reg_login.css">
    <link rel="icon" href="<%=request.getContextPath()%>/image/code.png">
</head>
<body>
<div class="login-main">
    <header class="layui-elip" style="width: 82%">注册页</header>
    <!-- 表单选项 -->
    <form class="layui-form">
        <!-- 邮箱 -->
        <div class="layui-input-inline">
            <div class="layui-inline" style="width: 85%">
                <input type="text" id="email" name="email" required  lay-verify="required" placeholder="请输入邮箱" autocomplete="off" class="layui-input">
            </div>
            <!-- 对号 -->
            <div class="layui-inline">
                <i class="layui-icon" id="remail" style="color: green;font-weight: bolder;" hidden></i>
            </div>
            <!-- 错号 -->
            <div class="layui-inline">
                <i class="layui-icon" id="wemail" style="color: red; font-weight: bolder;" hidden>ဆ</i>
            </div>
        </div>
        <div class="layui-input-inline">
            <!-- 用户名 -->
            <div class="layui-inline" style="width: 85%">
                <input type="text" id="user" name="username" required  lay-verify="required" placeholder="请输入用户名" autocomplete="off" class="layui-input">
            </div>
            <!-- 对号 -->
            <div class="layui-inline">
                <i class="layui-icon" id="user-ri" style="color: green;font-weight: bolder;" hidden></i>
            </div>
            <!-- 错号 -->
            <div class="layui-inline">
                <i class="layui-icon" id="user-wi" style="color: red; font-weight: bolder;" hidden>ဆ</i>
            </div>
        </div>
        <!-- 密码 -->
        <div class="layui-input-inline">
            <div class="layui-inline" style="width: 85%">
                <input type="password" id="pwd" name="password" required  lay-verify="required" placeholder="请输入密码" autocomplete="off" class="layui-input">
            </div>
            <!-- 对号 -->
            <div class="layui-inline">
                <i class="layui-icon" id="pri" style="color: green;font-weight: bolder;" hidden></i>
            </div>
            <!-- 错号 -->
            <div class="layui-inline">
                <i class="layui-icon" id="pwr" style="color: red; font-weight: bolder;" hidden>ဆ</i>
            </div>
        </div>
        <!-- 确认密码 -->
        <div class="layui-input-inline">
            <div class="layui-inline" style="width: 85%">
                <input type="password" id="rpwd" name="repassword" required  lay-verify="required" placeholder="请确认密码" autocomplete="off" class="layui-input">
            </div>
            <!-- 对号 -->
            <div class="layui-inline">
                <i class="layui-icon" id="rpri" style="color: green;font-weight: bolder;" hidden></i>
            </div>
            <!-- 错号 -->
            <div class="layui-inline">
                <i class="layui-icon" id="rpwr" style="color: red; font-weight: bolder;" hidden>ဆ</i>
            </div>
        </div>
<%--        <!-- 邮箱 -->--%>
<%--        <div class="layui-input-inline">--%>
<%--            <div class="layui-inline" style="width: 85%">--%>
<%--                <input type="text" id="verfiCode" name="veri" required  lay-verify="required" placeholder="验证码" autocomplete="off" class="layui-input">--%>
<%--                <canvas id="canvas" width="100" height="43"> </canvas>--%>
<%--            </div>--%>
<%--            <!-- 对号 -->--%>
<%--            <div class="layui-inline">--%>
<%--                <i class="layui-icon" id="reCode" style="color: green;font-weight: bolder;" hidden></i>--%>
<%--            </div>--%>
<%--            <!-- 错号 -->--%>
<%--            <div class="layui-inline">--%>
<%--                <i class="layui-icon" id="wrCode" style="color: red; font-weight: bolder;" hidden>ဆ</i>--%>
<%--            </div>--%>
<%--        </div>--%>
        <input id="userAvatar" type="hidden" name="userAvatar" value="/image/1.jpg">
        <div class="layui-input-inline login-btn" style="width: 85%">
            <button type="submit" lay-submit lay-filter="sub" class="layui-btn">注册</button>
        </div>
        <hr style="width: 85%" />
        <p style="width: 85%"><a href="<%=request.getContextPath()%>/login" class="fl">已有账号？立即登录</a></p>
    </form>
</div>

<script type="text/javascript" src="https://cdn.bootcss.com/canvas-nest.js/1.0.1/canvas-nest.min.js"></script>
<script src="<%=request.getContextPath()%>/layui/layui.js"></script>
<script src="<%=request.getContextPath()%>/js/jquery.min.js"></script>
<script src="<%=request.getContextPath()%>/js/reg_login.js"></script>
</body>
</html>

<script type="text/javascript">
    layui.use(['form','jquery','layer'], function () {
        var form   = layui.form;
        var $      = layui.jquery;
        var layer  = layui.layer;
        var flag1 = 0,flag2 = 0,flag3 = 0,flag4 = 0;
        //添加表单失焦事件
        //验证表单
        $('#user').blur(function() {
            var user = $(this).val();
            //alert(user);
            $.ajax({
                url:'<%=request.getContextPath()%>/user/username',
                type:'post',
                dataType:'text',
                data:{userName:user},
                //验证用户名是否可用
                success:function(result){
                    var d = JSON.parse(result);
                    console.log(d);
                    if (d.code == 1) {
                        $('#user-ri').removeAttr('hidden');
                        $('#user-wi').attr('hidden','hidden');
                        flag1 =1;
                    } else if(d.code == 0){
                        $('#user-wi').removeAttr('hidden');
                        $('#user-ri').attr('hidden','hidden');
                        layer.msg(d.msg);
                        flag1 = 0;
                    }
                }
            })
        });
        // you code ..
        // 为密码添加正则验证
        $('#pwd').blur(function() {
            var reg = /^[\w]{6,12}$/;
            if(!($('#pwd').val().match(reg))){
                //layer.msg('请输入合法密码');
                $('#pwr').removeAttr('hidden');
                $('#pri').attr('hidden','hidden');
                layer.msg('请输入合法密码');
                flag2 = 0;
            }else {
                $('#pri').removeAttr('hidden');
                $('#pwr').attr('hidden','hidden');
                flag2 =1;
            }
        });
        //验证两次密码是否一致
        $('#rpwd').blur(function() {
            if($('#pwd').val() != $('#rpwd').val()){
                $('#rpwr').removeAttr('hidden');
                $('#rpri').attr('hidden','hidden');
                layer.msg('两次输入密码不一致!');
                flag3 = 0;
            }else {
                $('#rpri').removeAttr('hidden');
                $('#rpwr').attr('hidden','hidden');
                flag3 = 1;
            };
        });
        $('#email').blur(function() {
            var reg = /^([a-zA-Z]|[0-9])(\w|\-)+@[a-zA-Z0-9]+\.([a-zA-Z]{2,4})$/;
            if(!($('#email').val().match(reg))){
                //layer.msg('请输入合法密码');
                $('#wemail').removeAttr('hidden');
                $('#remail').attr('hidden','hidden');
                layer.msg('请输入合法邮箱');
                flag4 = 0;
            }else {
                $.ajax({
                    url:'<%=request.getContextPath()%>/user/email',
                    type:'post',
                    dataType:'text',
                    data:{email:$('#email').val()},
                    //验证用户名是否可用
                    success:function(result){
                        var d = JSON.parse(result);
                        console.log(d);
                        if (d.code == 1) {
                            $('#remail').removeAttr('hidden');
                            $('#wemail').attr('hidden','hidden');
                            flag4 = 1;
                        } else if(d.code == 0){
                            $('#wemail').removeAttr('hidden');
                            $('#remail').attr('hidden','hidden');
                            layer.msg(d.msg)
                            flag4 = 0;
                        }
                    }
                })
            }
        });
        //添加表单监听事件,提交注册信息
        form.on('submit(sub)', function() {
            if(flag1 == 1 && flag2 == 1 && flag3 ==1 && flag4 == 1) {
                $.ajax({
                    url: '<%=request.getContextPath()%>/user/regSubmit',
                    type: 'post',
                    dataType: 'text',
                    data: {
                        userName: $('#user').val(),
                        userPass: $('#pwd').val(),
                        userEmail: $('#email').val(),
                        userAvatar: $('#userAvatar').val(),
                    },
                    success: function (data) {
                        var d = JSON.parse(data);
                        if (d.code == 1) {
                            //eg1
                            layer.confirm(d.msg, {
                                btn: ['确认'] //可以无限个按钮
                            }, function (index, layero) {
                            });
                            window.location.href = "<%=request.getContextPath()%>/login";
                        } else {
                            layer.msg(d.msg);
                        }
                    }
                })
            }else{
                layer.msg('信息不正确！');
            }
            //防止页面跳转
            return false;
        });
    });
    $(function () {
        var show_num=[];
        draw(show_num);
        console.log(show_num);
        $('#canvas').on('click',function () {
            draw(show_num);
            console.log(show_num);
        });
    });
</script>
