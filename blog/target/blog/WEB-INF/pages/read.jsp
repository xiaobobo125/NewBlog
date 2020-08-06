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
    <title>${options.optionSiteTitle}-${article.articleTitle}</title>
    <link rel="shortcut icon" href="<%=request.getContextPath()%>/image/logo.png">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/font-awesome/css/font-awesome.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/layui/css/layui.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/master.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/gloable.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/nprogress.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/blog.css"/>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/highlight.css"/>
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
        <div class="col-content" style="width:100%">
            <div class="inner">
                <article class="article-list">
                    <input type="hidden" value="@Model.BlogTypeID" id="blogtypeid" />
                    <section class="article-item">
                        <aside class="title" style="line-height:1.5;">
                            <h4>${article.articleTitle}</h4>
                            <p class="fc-grey fs-14">
                                <small>
                                    作者：<a href="<%=request.getContextPath()%>/" target="_blank" class="fc-link">Mr.BoBo</a>
                                </small>
                                <small class="ml10">围观群众：<i class="readcount">${article.articleViewCount}</i></small>
                                <small class="ml10">更新于 <label><fmt:formatDate value="${article.articleCreateTime}" pattern="yyyy年MM月dd日 hh:mm:ss"/> </label> </small>
                            </p>
                        </aside>
                        <div class="time mt10" style="padding-bottom:0;">
                            <span class="day"><fmt:formatDate value="${article.articleCreateTime}" pattern="dd"/> </span>
                            <span class="month fs-18"><fmt:formatDate value="${article.articleCreateTime}" pattern="MM"/><span class="fs-14">月</span></span>
                            <span class="year fs-18 ml10"><fmt:formatDate value="${article.articleCreateTime}" pattern="yyyy"/></span>
                        </div>
                        <div class="content artiledetail" style="border-bottom: 1px solid #e1e2e0; padding-bottom: 20px;">
                            <div class="single-content">
                                ${article.articleContent}
                            </div>
                            <c:if test="${article.articleStatus ==  2}">
                            <div class="copyright mt20">
                                <p class="f-toe fc-black">
                                    非特殊说明，本文版权归 Mr.BoBo 所有，转载请注明出处.
                                </p>
                                <p class="f-toe">
                                    本文标题：
                                    <a href="<%=request.getContextPath()%>/blog/article/${article.articleId}" class="r-title">${article.articleTitle}</a>
                                </p>
                                <p class="f-toe">
                                    本文网址：
                                    <a href=""><script>document.write(window.location.href);</script></a>
                                </p>
                            </div>
                            </c:if>
                            <div id="aplayer" style="margin:5px 0"></div>
                            <h6>延伸阅读</h6>
                                <c:forEach var="a" items="${articlesList}">
                                    <c:if test="${a.articleId != article.articleId}">
                                    <ol class="b-relation"><a href="<%=request.getContextPath()%>/blog/article/${a.articleId}" class="r-title">${a.articleTitle}</a></ol>
                                    </c:if>
                                </c:forEach>
                        </div>
<%--                        <div class="f-cb"></div>--%>
<%--                        <div class="mt20 f-fwn fs-24 fc-grey comment" style="border-top: 1px solid #e1e2e0; padding-top: 20px;">--%>

<%--                        </div>--%>
                        <fieldset name="goComment" class="layui-elem-field layui-field-title">
                            <legend>发表评论</legend>

                            <div class="layui-field-box">
                                <div class="leavemessage" style="text-align:initial">
                                    <form class="layui-form blog-editor" action="">
                                        <input type="hidden" name="articleid" id="articleid" value="${article.articleId}">
                                        <div class="layui-form-item">
                                            <textarea name="editorContent" lay-verify="content" id="remarkEditor" placeholder="请输入内容" class="layui-textarea"></textarea>
                                        </div>
                                        <div class="layui-form-item">
                                            <button class="layui-btn" lay-submit="formLeaveMessage" lay-filter="formLeaveMessage">提交留言</button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </fieldset>
                        <ul class="blog-comment" id="blog-comment">
                            <c:forEach var="comment" items="${commentList}">
                                <c:if test="${comment.commentPid == 0}">
                                <li>
                                    <div class="comment-parent">
                                        <a name="remark-225"></a>
                                        <img src="<%=request.getContextPath()%>${comment.user.userAvatar}">
                                        <div class="info">
                                            <span class="username">${comment.user.userName}</span>
                                            <c:if test="${comment.commentRole == 1}"><span class="blogger">站长</span></c:if>
                                        </div>
                                        <div class="comment-content">${comment.commentContent}</div>
                                        <p class="info info-footer">
                                            <span class="comment-time"><fmt:formatDate value="${comment.commentCreateTime}" pattern="yyyy年MM月dd日 hh:mm:ss"/></span>
                                            <a href="javascript:;" class="btn-reply" data-targetid="${comment.commentId}" data-targetname="${comment.user.userName}">回复</a>
                                        </p>
                                    </div>
                                </c:if>
                                    <c:forEach var="reply" items="${commentList}">
                                        <c:if test="${comment.commentId == reply.commentPid}">
                                            <hr>
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
                                                </p>
                                            </div>
                                        </c:if>
                                    </c:forEach>
                                    <div class="replycontainer layui-hide">
                                        <form class="layui-form" action="">
                                            <input type="hidden" name="articleId" value="${article.articleId}" />
                                            <div class="layui-form-item">
                                                <textarea name="replyContent" lay-verify="replyContent" placeholder="请输入回复内容" class="layui-textarea" style="min-height: 80px;"></textarea>
                                            </div>
                                            <div class="layui-form-item">
                                                <button class="layui-btn layui-btn-xs" lay-submit="formReply" lay-filter="formReply">提交</button>
                                            </div>
                                        </form>
                                    </div>
                                </li>
                            </c:forEach>
                        </ul>
                    </section>
                </article>
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
<script src="<%=request.getContextPath()%>/js/jquery.min.js"></script>
<script src="<%=request.getContextPath()%>/js/jquery.cookie.js"></script>
<script src="<%=request.getContextPath()%>/js/yss/gloable.js"></script>
<script src="<%=request.getContextPath()%>/js/plugins/nprogress.js"></script>
<script src="<%=request.getContextPath()%>/js/pagecomment.js"></script>
<script>NProgress.start();</script>
<script>
    layui.use(['jquery','code','util','laytpl'], function() { //加载code模
        var $ = layui.jquery;
        var laytpl = layui.laytpl;
        var projectName=window.location.pathname.substring(0,window.location.pathname.substr(1).indexOf('/')+1);
        $('#login').attr('href',projectName+'/login?url='+window.location.pathname);
        layui.code({
            elem: 'pre'
            ,title: ''
            , skin: 'notepad' //如果要默认风格，不用设定该key。
            , about: false
        });
        var html = '<div>\n' +
            '    <c:if test="${articleLike == null}">\n' +
            '        <i id="doGood" class="fa fa-thumbs-o-up" aria-hidden="true"></i>\n' +
            '    </c:if>\n' +
            '    <c:if test="${articleLike != null}">\n' +
            '        <i id="doGood" class="fa fa-thumbs-up" aria-hidden="true"></i>\n' +
            '    </c:if>\n' +
            '</div>';


        layui.util.fixbar({
            bar1: html
            ,css: {right: 50, bottom: 100}
            ,bgcolor: '#393D49'
            ,click: function(type){
                if(type == 'bar1'){
                    $.get({
                        url:'<%=request.getContextPath()%>/article/doGood/'+${article.articleId},
                        success:function (result) {
                            if(result.code == 1) {
                                $('#doGood').removeClass('fa fa-thumbs-o-up');
                                $('#doGood').addClass("fa fa-thumbs-up");
                            }
                            console.log(result);
                            layer.msg(result.msg);
                        }
                    });
                }
            }
        });
    });
    window.onload = function () {
        NProgress.done();
        increaseViewCount(${article.articleId});
    };
    //百度分享
    window._bd_share_config = {
        common: {
            bdText: '',
            bdDesc: '',
            bdUrl: '',
            bdPic: 'https://open.saintic.com/api/bingPic/'
        },
        share: [{
            "bdSize": 32
        }],
        slide: [{
            bdImg: 0,
            bdPos: "right",
            bdTop: 100
        }],
        image: [{
            viewType: 'list',
            viewPos: 'top',
            viewColor: 'black',
            viewSize: '32',
            viewList: ['qzone', 'tsina', 'weixin', 'tqq']
        }],
        selectShare: [{
            "bdselectMiniList": ['qzone', 'tsina', 'weixin', 'tqq']
        }]
    }
    with (document) 0[(getElementsByTagName('head')[0] || body).appendChild(createElement('script')).src = 'http://bdimg.share.baidu.com/static/api/js/share.js?cdnversion=' + ~(-new Date() / 36e5)];
    function increaseViewCount(articleId) {
        if ($.cookie("viewId") != articleId || $.cookie("viewId") == null) {
            $.ajax({
                async: false,
                url: "<%=request.getContextPath()%>/article/view/" + articleId,
                dataType: 'json',
                contentType: 'application/json',
                success: function (data) {
                    console.log(data);
                    $(".articleViewCount").html(data);
                    $.cookie(
                        "viewId",
                        articleId,//需要cookie写入的业务
                        {
                            "path": "/", //cookie的默认属性
                        }
                    );
                },
                error: function () {
                    // alert("获取数据出错!");
                },
            });
        }
    }
</script>
</body>
</html>
