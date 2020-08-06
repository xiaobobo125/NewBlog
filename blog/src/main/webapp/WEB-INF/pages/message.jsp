<%--
  Created by IntelliJ IDEA.
  User: 12598
  Date: 2020/7/29
  Time: 16:18
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
    <title>留言板</title>
    <link rel="shortcut icon" href="<%=request.getContextPath()%>/image/logo.png">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/font-awesome/css/font-awesome.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/layui/css/layui.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/master.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/gloable.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/nprogress.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/message.css" />
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
        <div class="container-inner">
            <section class="msg-remark">
                <h1>留言板</h1>
                <p>
                    沟通交流，拉近你我！
                </p>
            </section>
            <div class="textarea-wrap message" id="textarea-wrap">
                <form class="layui-form blog-editor" action="">
                    <input type="hidden" name="articleid" id="articleid" value="0">
                    <div class="layui-form-item">
                        <textarea name="editorContent" lay-verify="content" id="remarkEditor" placeholder="请输入内容" class="layui-textarea layui-hide"></textarea>
                    </div>
                    <div class="layui-form-item">
                        <button class="layui-btn" lay-submit="formLeaveMessage" lay-filter="formLeaveMessage">提交留言</button>
                    </div>
                </form>
            </div>
        </div>
        <div class="f-cb"></div>
        <div class="mt20">
            <ul class="message-list" id="message-list">
                <c:forEach var="comment" items="${commentList}">
                    <c:if test="${comment.commentPid == 0}">
                <li class="zoomIn article">
                    <div class="comment-parent">
                        <a name="remark-1"></a>
                        <img src="<%=request.getContextPath()%>${comment.user.userAvatar}">
                        <div class="info">
                            <span class="username">${comment.user.userName}</span>
                            <c:if test="${comment.commentRole == 1}"><span class="blogger">站长</span></c:if>
                        </div>
                        <div class="comment-content">${comment.commentContent}</div>
                        <p class="info info-footer">
                            <span class="comment-time"><fmt:formatDate value="${comment.commentCreateTime}" pattern="yyyy年MM月dd日 hh:mm:ss"/></span>
                            <a href="javascript:;" class="btn-reply" data-targetid="${comment.commentId}" data-targetname="${comment.user.userName}">回复</a>
                            <c:if test="${userLogin.userStatus == 1}">
                            <a href="<%=request.getContextPath()%>/comment/delete/${comment.commentId}" class="btn-delete">删除</a>
                            </c:if>
                        </p>
                    </div>
                    </c:if>
                    <c:forEach var="reply" items="${commentList}">
                        <c:if test="${comment.commentId == reply.commentPid}">
                    <hr />
                    <div class="comment-child">
                        <a name="reply-214"></a>
                        <img src="<%=request.getContextPath()%>${reply.user.userAvatar}"/>
                        <div class="info">
                            <span class="username">${reply.user.userName}</span>
                            <c:if test="${reply.commentRole == 1}"><span class="blogger">站长</span></c:if>
                            <span style="padding-right: 0; margin-left: -5px;">回复</span>
                            <span class="username">${reply.commentPname}</span>
                            <span>${reply.commentContent}</span>
                        </div>
                        <p class="info">
                            <span class="comment-time"><fmt:formatDate value="${reply.commentCreateTime}" pattern="yyyy年MM月dd日 hh:mm:ss"/></span>
                            <a href="javascript:;" class="btn-reply" data-targetid="${comment.commentId}" data-targetname="${reply.user.userName}">回复</a>
                        <c:if test="${userLogin.userStatus == 1}">
                            <a href="<%=request.getContextPath()%>/comment/delete/${reply.commentId}" class="btn-delete">删除</a>
                        </c:if>
                        </p>
                    </div></c:if>
                    </c:forEach>
                    <div class="replycontainer layui-hide">
                        <form class="layui-form" action="">
                            <input type="hidden" name="articleId" value="0" />
                            <input type="hidden" name="remarkId" value="1">
                            <input type="hidden" name="targetUserId" value="0">
                            <div class="layui-form-item">
                                <textarea name="replyContent" lay-verify="replyContent" placeholder="请输入回复内容" class="layui-textarea" style="min-height:80px;"></textarea>
                            </div>
                            <div class="layui-form-item">
                                <button class="layui-btn layui-btn-xs" lay-submit="formReply" lay-filter="formReply">提交</button>
                            </div>
                        </form>
                    </div>
                </li>
                </c:forEach>
            </ul>
        </div>
    </div>
</div>
<footer class="grid-footer">
    <div class="footer-fixed">
        <div class="copyright">
            <div class="info">
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
<script src="<%=request.getContextPath()%>/js/pagemessage.js"></script>
<script>NProgress.start();</script>
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
