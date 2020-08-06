<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="rapid" uri="http://www.rapid-framework.org.cn/rapid" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <link rel="shortcut icon" href="<%=request.getContextPath()%>/image/logo.png">
    <title>
        ${options.optionSiteTitle}后台
            <rapid:block name="title"></rapid:block>
    </title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/plugin/layui/css/layui.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/back.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/plugin/font-awesome/css/font-awesome.min.css">
    <rapid:block name="header-style"></rapid:block>
    <rapid:block name="header-script"></rapid:block>
</head>
<body>
<div class="layui-layout layui-layout-admin">
    <div class="layui-header">
        <div class="layui-logo"><a href="<%=request.getContextPath()%>/admin" style="color:#009688;">
        ${options.optionSiteTitle}-后台
        </a>
        </div>
        <!-- 头部区域（可配合layui已有的水平导航） -->
        <ul class="layui-nav layui-layout-left">
            <li class="layui-nav-item"><a href="<%=request.getContextPath()%>" target="_blank">前台</a></li>
            <li class="layui-nav-item">
                <a href="javascript:;">新建</a>
                <dl class="layui-nav-child">
                    <dd><a href="<%=request.getContextPath()%>/admin/article/insert">文章</a></dd>
                    <dd><a href="<%=request.getContextPath()%>/admin/page">页面</a></dd>
                    <dd><a href="<%=request.getContextPath()%>/admin/category">分类</a></dd>
                    <dd><a href="<%=request.getContextPath()%>/admin/notice">公告</a></dd>
                    <dd><a href="<%=request.getContextPath()%>/admin/link">链接</a></dd>
                </dl>
            </li>
        </ul>
        <ul class="layui-nav layui-layout-right">
            <li class="layui-nav-item">
                <a href="javascript:;">
                    <img src="<%=request.getContextPath()%>${sessionScope.user.userAvatar}" class="layui-nav-img">
                    ${sessionScope.user.userName}
                </a>
                <dl class="layui-nav-child">
                    <dd><a href="<%=request.getContextPath()%>/user/profile/${sessionScope.user.userId}">基本资料</a></dd>
                </dl>
            </li>
            <li class="layui-nav-item">
                <a href="<%=request.getContextPath()%>/admin/logout">退出</a>
            </li>
        </ul>
    </div>

    <div class="layui-side layui-bg-black">
        <div class="layui-side-scroll">
            <!-- 左侧导航区域（可配合layui已有的垂直导航） -->
            <ul class="layui-nav layui-nav-tree"  lay-filter="test">
                <li class="layui-nav-item <c:if test='${listStatus == 1}'>layui-nav-itemed</c:if> ">
                    <a class="" href="javascript:;">文章</a>
                    <dl class="layui-nav-child">
                        <dd><a href="<%=request.getContextPath()%>/admin/article">全部文章</a></dd>
                        <dd><a href="<%=request.getContextPath()%>/article/insert">写文章</a></dd>
<%--                        <dd><a href="<%=request.getContextPath()%>/admin/category">全部分类</a></dd>--%>
                        <dd><a href="<%=request.getContextPath()%>/admin/tag">全部标签</a></dd>
                    </dl>
                </li>
                <li class="layui-nav-item <c:if test='${listStatus == 3}'>layui-nav-itemed</c:if>">
                    <a class="" href="javascript:;">
                        链接
                    </a>
                    <dl class="layui-nav-child">
                        <dd><a href="<%=request.getContextPath()%>/admin/link">全部链接</a></dd>
                        <dd><a href="<%=request.getContextPath()%>/link/insert">添加链接</a></dd>
                    </dl>
                </li>
                <li class="layui-nav-item <c:if test='${listStatus == 4}'>layui-nav-itemed</c:if>">
                    <a href="javascript:;">公告</a>
                    <dl class="layui-nav-child">
                        <dd><a href="<%=request.getContextPath()%>/admin/notice">全部公告</a></dd>
                        <dd><a href="<%=request.getContextPath()%>/notice/insert">添加公告</a></dd>
                    </dl>
                </li>
                <li class="layui-nav-item">
                    <a href="<%=request.getContextPath()%>/admin/comment">
                        评论
                    </a>
                </li>
                <li class="layui-nav-item">
                    <a href="<%=request.getContextPath()%>/admin/diary">
                        日记
                    </a>
                </li>
                <li class="layui-nav-item <c:if test='${listStatus == 5}'>layui-nav-itemed</c:if>">
                    <a class="" href="javascript:;">
                        用户
                    </a>
                    <dl class="layui-nav-child">
                        <dd><a href="<%=request.getContextPath()%>/admin/user">全部用户</a></dd>
                        <dd><a href="<%=request.getContextPath()%>/user/insert">添加用户</a></dd>
                    </dl>
                </li>
                <li class="layui-nav-item <c:if test='${listStatus == 6}'>layui-nav-itemed</c:if>">
                    <a href="javascript:;">设置</a>
                    <dl class="layui-nav-child">
                        <dd><a href="<%=request.getContextPath()%>/admin/menu">菜单</a></dd>
                        <dd><a href="<%=request.getContextPath()%>/admin/options">主要选项</a></dd>
                    </dl>
                </li>
            </ul>
        </div>
    </div>

    <div class="layui-body">
        <!-- 内容主体区域 -->
        <div style="padding: 15px;">
            <rapid:block name="content">

            </rapid:block>
        </div>
    </div>

    <div class="layui-footer">
        <!-- 底部固定区域 -->
        © <a href="#">博客</a>
    </div>
</div>

<script src="<%=request.getContextPath()%>/js/jquery.min.js"></script>
<script src="<%=request.getContextPath()%>/layui/layui.all.js"></script>
<script src="<%=request.getContextPath()%>/js/back.js"></script>
<rapid:block name="footer-script">

</rapid:block>
<script>
    //给文本编辑器的iframe引入代码高亮的css
    $("iframe").contents().find("head").append("<link rel=\"stylesheet\" href=\"<%=request.getContextPath()%>/css/highlight.css\">\n");

</script>

</body>
</html>
