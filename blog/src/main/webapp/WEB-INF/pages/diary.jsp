<%--
  Created by IntelliJ IDEA.
  User: 12598
  Date: 2020/7/29
  Time: 16:17
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta name="renderer" content="webkit">
    <meta name="viewport" content="width=device-width" />
    <meta name="author" content="www.yanshisan.cn" />
    <meta name="robots" content="all" />
    <title>${options.optionSiteTitle}-日记</title>
    <link rel="shortcut icon" href="<%=request.getContextPath()%>/image/logo.png">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/font-awesome/css/font-awesome.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/layui/css/layui.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/master.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/gloable.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/nprogress.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/timeline.css" />
</head>
<body>
<div class="header">
</div>
<header class="gird-header">
    <div class="header-fixed">
        <div class="header-inner">
            <a href="javascript:void(0)" class="header-logo" id="logo">${options.optionSiteTitle}</a>
            <nav class="nav" id="nav">
                <ul>
                    <li><a href="<%=request.getContextPath()%>/index">首页</a></li>
                    <c:forEach var="menu" items="${menuList}">
                        <li><a href="<%=request.getContextPath()%>${menu.menuUrl}">${menu.menuName}</a></li>
                    </c:forEach>
                    <%--                    <li><a href="<%=request.getContextPath()%>/day">日记</a></li>--%>
                    <%--                    <li><a href="<%=request.getContextPath()%>/message">留言</a></li>--%>
                    <%--                    <li><a href="<%=request.getContextPath()%>/friendLink">友链</a></li>--%>
                </ul>
            </nav>
            <c:if test="${sessionScope.userLogin != null}">
                <a  href="<%=request.getContextPath()%>/logout" class="blog-user">
                    <i class="fa fa-user-circle" aria-hidden="true"></i>
                </a>
            </c:if>
            <c:if test="${sessionScope.userLogin == null}">
                <a id="login" href="<%=request.getContextPath()%>/login" class="blog-user">
                    <i class="fa fa-user-circle-o" aria-hidden="true"></i>
                </a>
            </c:if>
        </div>
    </div>
</header>
<div class="doc-container" id="doc-container">
    <div class="container-fixed">
        <div class="timeline-box shadow">
            <div class="timeline-main">
                <h1><i class="fa fa-clock-o"></i>日记</h1>
                <div class="timeline-line"></div>
                <c:forEach var="diary" items="${diaryList}">
                    <div class="timeline-year">
                        <h2><a class="yearToggle">${diary.key}年</a><i class="fa fa-caret-down fa-fw"></i></h2>
                        <div class="timeline-month">
                            <ul>
                                <c:forEach var="d" items="${diary.value}">
                                    <li>
                                        <div class="h4 animated fadeInLeft">
                                            <p class="date"><fmt:formatDate value="${d.diaryCreateTime}" pattern="MM月dd日"/></p>
                                        </div>
                                        <p class="dot-circle animated "><i class="fa fa-dot-circle-o"></i></p>
                                        <div class="content animated fadeInRight">${d.diaryContent}</div>
                                        <div class="clear"></div>
                                    </li>
                                </c:forEach>
                            </ul>
                        </div>
                    </div>
                </c:forEach>
                <h1 style="padding-top:4px;padding-bottom:2px;margin-top:40px;"><i class="fa fa-hourglass-end"></i>THE GO!</h1>
            </div>
        </div>
    </div>
</div>
<footer class="grid-footer">
    <div class="footer-fixed">
        <div class="copyright">
            <div class="info">
                <div class="contact">
                    <a href="https://github.com/${options.optionAboutsiteGithub}" class="github" target="_blank"><i class="fa fa-github"></i></a>
                    <a href="https://wpa.qq.com/msgrd?v=3&uin=${options.optionAboutsiteQq}&site=qq&menu=yes" class="qq" target="_blank" title="${options.optionAboutsiteQq}"><i class="fa fa-qq"></i></a>
                    <a href="http://weibo.com/${options.optionAboutsiteWeibo}" class="weibo" target="_blank" title="${options.optionAboutsiteWeibo}"><i class="fa fa-weibo"></i></a>
                    <a href="javascript:void(0)" class="weixin"><i class="fa fa-weixin"></i></a>
                </div>
                <p class="mt05">
                    Copyright &copy; 2020 ${options.optionSiteTitle} All Rights Reserved V.1.0.0<a href="http://beian.miit.gov.cn/" target="_blank">
                    <span>鲁ICP备20023189</span>
                </a>
                </p>
            </div>
        </div>
    </div>
</footer>
<script src="<%=request.getContextPath()%>/layui/layui.js"></script>
<script src="<%=request.getContextPath()%>/js/yss/gloable.js"></script>
<script src="<%=request.getContextPath()%>/js/plugins/nprogress.js"></script>
<script>NProgress.start();</script>
<script src="<%=request.getContextPath()%>/js/pagediary.js"></script>
<script>
    layui.use('jquery',function(){
        var $ = layui.jquery;
        var projectName=window.location.pathname.substring(0,window.location.pathname.substr(1).indexOf('/')+1);
        $('#login').attr('href',projectName+'/login?url='+window.location.pathname);
    });
    window.onload = function () {
        NProgress.done();
    };
</script>
</body>
</html>

