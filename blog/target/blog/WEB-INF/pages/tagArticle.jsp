<%--
  Created by IntelliJ IDEA.
  User: 12598
  Date: 2020/7/29
  Time: 16:16
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
    <title>${options.optionSiteTitle}-博客</title>
    <link rel="shortcut icon" href="<%=request.getContextPath()%>/image/logo.png">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/font-awesome/css/font-awesome.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/layui/css/layui.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/master.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/gloable.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/nprogress.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/blog.css" />
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
        <div class="col-content">
            <div class="inner">
                <article class="article-list bloglist" id="LAY_bloglist" >
                    <c:if test="${articleList.size() == 0}">
                        <section class="article-item zoomIn article">
                            本分类还没有文章哦~
                        </section>
                    </c:if>
                    <c:if test="${articleList.size()>0}">
                    <c:forEach var="article" items="${articleList}">
                        <section class="article-item zoomIn article">
                            <c:if test="${article.articleOrder == 1}">
                                <div class="fc-flag">置顶</div>
                            </c:if>
                            <h5 class="title">
                                <c:if test="${article.articleStatus == 2}"><span class="fc-blue">【原创】</span></c:if>
                                <c:if test="${article.articleStatus == 3}"><span class="fc-blue">【转载】</span></c:if>
                                <a href="<%=request.getContextPath()%>/blog/article/${article.articleId}">${article.articleTitle}</a>
                            </h5>
                            <div class="time">
                                <span class="day"><fmt:formatDate value="${article.articleCreateTime}" pattern="dd"/> </span>
                                <span class="month fs-18"><fmt:formatDate value="${article.articleCreateTime}" pattern="MM"/><span class="fs-14">月</span></span>
                                <span class="year fs-18 ml10"><fmt:formatDate value="${article.articleCreateTime}" pattern="yyyy"/></span>
                            </div>
                            <div class="content">
                                <a href="<%=request.getContextPath()%>/blog/article/${article.articleId}" class="cover img-light">
                                    <img src="<%=request.getContextPath()%>${article.articleImg}">
                                </a>
                                <p>
                                        ${article.articleSummary}
                                </p>
                            </div>
                            <div class="read-more">
                                <a href="<%=request.getContextPath()%>/blog/article/${article.articleId}" class="fc-black f-fwb">继续阅读</a>
                            </div>
                            <aside class="f-oh footer">
                                <div class="f-fl tags">
                                    <span class="fa fa-tags fs-16"></span>
                                    <a class="tag">${article.tag.tagName}</a>
                                </div>
                                <div class="f-fr">
                                        <span class="read">
                                            <i class="fa fa-eye fs-16"></i>
                                            <i class="num">${article.articleViewCount}</i>
                                        </span>
                                    <span class="ml20">
                                            <i class="fa fa-comments fs-16"></i>
                                            <a href="javascript:void(0)" class="num fc-grey">${article.articleCommentCount}</a>
                                        </span>
                                </div>
                            </aside>
                        </section>
                    </c:forEach>
                    <%-- 分页 --%>
                    <div id="show-page"></div>
                    </c:if>
                </article>
            </div>
        </div>
        <div class="col-other">
            <div class="inner">
                <div class="other-item" id="categoryandsearch">
                    <div class="search">
                        <label class="search-wrap">
                            <input id="search" type="text" id="searchtxt" placeholder="输入关键字搜索" />
                            <span class="search-icon">
					                <i class="fa fa-search"></i>
					            </span>
                        </label>
                        <ul id="seaResult" class="search-result">

                        </ul>
                    </div>
                    <ul class="category mt20" id="category">
                        <li data-index="0" class="slider"></li>
                        <li data-index="1"><a href="<%=request.getContextPath()%>/blogIndex">全部文章</a></li>
                        <%int i=2; %>
                        <c:forEach var="tag" items="${tagList}">
                            <li data-index="<%=i%>"><a href="<%=request.getContextPath()%>/tag/${tag.tagId}">${tag.tagName}</a></li>
                            <% i++; %>
                        </c:forEach>
                    </ul>
                </div>
                <!--右边悬浮 平板或手机设备显示-->
                <div class="category-toggle"><i class="layui-icon">&#xe603;</i></div>
                <div class="article-category">
                    <div class="article-category-title">分类导航</div>
                    <%int j=2; %>
                    <c:forEach var="tag" items="${tagList}">
                        <li data-index="<%=j%>"><a href="<%=request.getContextPath()%>/tag/${tag.tagId}/">${tag.tagName}</a></li>
                        <% j++; %>
                    </c:forEach>
                    <div class="f-cb"></div>
                </div>
                <!--遮罩-->
                <div class="blog-mask animated layui-hide"></div>
                <div class="other-item">
                    <h5 class="other-item-title">热门文章</h5>
                    <div class="inner">
                        <ul class="hot-list-article">
                            <c:forEach var="article" items="${hotService}" >
                                <li> <a href="<%=request.getContextPath()%>/blog/article/${article.articleId}">${article.articleTitle}</a></li>
                            </c:forEach>
                        </ul>
                    </div>
                </div>
                <div class="other-item">
                    <h5 class="other-item-title">置顶推荐</h5>
                    <div class="inner">
                        <ul class="hot-list-article">
                            <c:forEach var="article" items="${reTopArticle}">
                                <li> <a href="<%=request.getContextPath()%>/blog/article/${article.articleId}">${article.articleTitle}</a></li>
                            </c:forEach>
                        </ul>
                    </div>
                </div>
                <div class="other-item">
                    <h5 class="other-item-title">最近访客</h5>
                    <div class="inner">
                        <dl class="vistor">
                            <c:forEach var="user" items="${userList}">
                                <dd><a href="javasript:;"><img src="<%=request.getContextPath()%>${user.userAvatar}"><cite>${user.userName}</cite></a></dd>
                            </c:forEach>
                        </dl>
                    </div>
                </div>
            </div>
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
    </div>
</footer>
<script src="<%=request.getContextPath()%>/layui/layui.js"></script>
<script src="<%=request.getContextPath()%>/js/yss/gloable.js"></script>
<script src="<%=request.getContextPath()%>/js/plugins/nprogress.js"></script>
<script>NProgress.start();</script>
<script src="<%=request.getContextPath()%>/js/yss/article.js"></script>
<script>
    window.onload = function () {
        NProgress.done();
    };
    layui.use(['jquery','laypage', 'layer'], function() {
        var laypage = layui.laypage,layer = layui.layer;
        var $ = layui.jquery;
        var projectName=window.location.pathname.substring(0,window.location.pathname.substr(1).indexOf('/')+1);
        $('#login').attr('href',projectName+'/login?url='+window.location.pathname);
        //总页数大于页码总数
        laypage.render({
            elem: 'show-page'
            ,curr: ${pageNum}
            ,count: ${articleCount} //数据总数
            ,limit: 10
            ,jump: function(obj,first){
                console.log(obj)
                if(!first){
                    var pageNum = obj.curr;
                    var pageSize = obj.limit;
                    var num = parseInt(pageNum)-1;
                    window.location.assign("<%=request.getContextPath()%>/tag/${tagId}?pageNum="+num+"&pageSize="+pageSize);
                }
            }
        });
        $('#search').keyup(function () {
            var content = $(this).val();
            if(content != '') {
                $.ajax({
                    url: "<%=request.getContextPath()%>/article/search",
                    data: {content: content},
                    success: function (result) {
                        if (result.code == 1) {
                            $('.child').remove();
                            console.log(result.data);
                            var html = '';
                            for (var i = 0; i < result.data.length; i++) {
                                html = html + "<li class='child' style='display:block'><a href=\"<%=request.getContextPath()%>/blog/article/" + result.data[i].articleId + "\">" + result.data[i].articleTitle + "</a></li>"
                            }
                            $('#seaResult').append(html);
                            $('#seaResult').css('display', 'block');
                        }
                    }
                });
            }else{
                $('.child').remove();
            }
        });
    });
</script>
</body>
</html>
