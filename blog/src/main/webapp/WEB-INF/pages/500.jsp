<%--
  Created by IntelliJ IDEA.
  User: 12598
  Date: 2020/8/6
  Time: 10:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head>

    <meta charset="UTF-8" http-equiv="Content-Type" content="text/html; charset=utf-8" />

    <title>500-对不起！服务器出错</title>

    <style type="text/css">

        .head404{ width:580px; height:234px; margin:50px auto 0 auto; background:url(https://www.daixiaorui.com/Public/images/head404.png) no-repeat; }

        .txtbg404{ width:499px; height:169px; margin:10px auto 0 auto; background:url(https://www.daixiaorui.com/Public/images/txtbg404.png) no-repeat;}

        .txtbg404 .txtbox{ width:390px; position:relative; top:30px; left:60px;color:#eee; font-size:13px;}

        .txtbg404 .txtbox p {margin:5px 0; line-height:18px;}

        .txtbg404 .txtbox .paddingbox { padding-top:15px;}

        .txtbg404 .txtbox p a { color:#eee; text-decoration:none;}

        .txtbg404 .txtbox p a:hover { color:#FC9D1D; text-decoration:underline;}

    </style>

</head>



<body bgcolor="#494949">

<div class="head404"></div>

<div class="txtbg404">

    <div class="txtbox">

        <p>对不起，您请求的页面不存在、或已被删除、或暂时不可用</p>

        <p class="paddingbox">请点击以下链接继续浏览网页</p>

        <p>》<a href="<%=request.getContextPath()%>">返回网站首页</a></p>

    </div>

</div>

</body>

</html>
</html>>
