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
<html lang="zh-Hans-CN">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta name="renderer" content="webkit">
    <meta name="viewport" content="width=device-width" />
    <title>${options.optionSiteTitle}</title>
    <link rel="shortcut icon" href="<%=request.getContextPath()%>/image/logo.png">
    <link href="<%=request.getContextPath()%>/layui/css/layui.css" rel="stylesheet" type="text/css">
    <link href="<%=request.getContextPath()%>/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    <link href="<%=request.getContextPath()%>/css/index_style.css" rel="stylesheet" type="text/css">
    <link href="<%=request.getContextPath()%>/css/animate.min.css" rel="stylesheet" type="text/css">
</head>
<body>
<div id="menu" class="hover_animation menu_open" data-mark="false">
    <span></span>
    <span></span>
    <span></span>
</div>
<div id="navgation" class="navgation navgation_close">
    <ul class="point">
        <li><a href="<%=request.getContextPath()%>/">首页</a></li>
        <c:forEach var="menu" items="${menuList}">
        <li><a href="<%=request.getContextPath()%>${menu.menuUrl}">${menu.menuName}</a></li>
        </c:forEach>
<%--        <li><a href="<%=request.getContextPath()%>/message">留言</a></li>--%>
<%--        <li><a href="<%=request.getContextPath()%>/day">日记</a></li>--%>
<%--        <li><a href="<%=request.getContextPath()%>/friendLink">友链</a></li>--%>
    </ul>
    <div class="logo"><a>${options.optionSiteTitle}</a></div>
</div>
<div class="section" id="section1">
    <div class="fp-tablecell">
        <div class="page1">
            <div class="nav wow zoomIn" data-wow-duration="2s">
                <h1>${options.optionSiteTitle}</h1>
                <p>${options.optionSiteDescrption}</p>
                <a class="layui-btn layui-btn-normal" style="margin-top: 20px" href="<%=request.getContextPath()%>/blogIndex">Enter Blog</a>
            </div>
            <a class="next wow fadeInUp" data-wow-duration="2s" id="next"></a>
        </div>
    </div>
</div>
<div class="section" id="section2">
    <div class="fp-tablecell">
        <div class="page2">
            <div class="warp-box">
                <div class="new-article">
                    <div class="inner wow fadeInDown" data-wow-delay=".2s">
                        <h1>热门文章</h1>
                        <p id="one-say">
                            <script type="text/javascript" src="https://api.xygeng.cn/one/get/"></script>
                        </p>
                    </div>
                </div>

                <div class="layui-row">
                    <c:forEach var="article" items="${hotArticle}">
                    <div class="layui-col-xs12 layui-col-sm4 layui-col-md4  wow fadeInUp" style="padding: 0 10px">
                        <div class="single-news">
                            <div class="news-head">
                                <img src="<%=request.getContextPath()%>${article.articleImg}">
                                <a href="<%=request.getContextPath()%>/blog/article/${article.articleId}" class="link"><i class="fa fa-link"></i></a>
                            </div>
                            <div class="news-content">
                                <h4>
                                    <a href="<%=request.getContextPath()%>/blog/article/${article.articleId}">
                                        ${article.articleTitle}
                                    </a>
                                </h4>
                                <div class="date">
                                    <fmt:formatDate value="${article.articleCreateTime}" pattern="yyyy年MM月dd日"/>
                                </div>
                                <p>
                                    ${article.articleSummary}
                                </p>
                                <a href="<%=request.getContextPath()%>/blog/article/${article.articleId}" class="btn">
                                    阅读更多
                                </a>
                            </div>
                        </div>
                    </div>
                    </c:forEach>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="section" id="section3">
    <div class="fp-tablecell">
        <div class="page3">
            <div class="warp-box">
                <div class="warp">
                    <div class="inner">
                        <div class="links">
                            <ul>
                                <c:forEach items="${linkList}" var="link">
                                    <li class="wow fadeInRight"><a href="${link.linkUrl}" target="_blank">${link.linkName}</a></li>
                                </c:forEach>
                                <li class="wow fadeInRight"><a href="<%=request.getContextPath()%>/friendLink" target="_blank">+友情链接</a></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="section" id="section4">
    <div class="fp-tablecell">
        <div class="page4">
            <div class="warp-box">
                <div class="about">
                    <div class="inner">
                        <h1 class="wow fadeInLeft">梦の自己</h1>
                        <p class="wow fadeInRight">
                            ${options.optionAboutsiteContent}
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<footer class="footer wow fadeInUp" id="contact">
    <div class="footer-top">
        <div class="container">
            <div class="layui-row">
                <div class="layui-col-xs12 layui-col-sm6 layui-col-md4">
                    <div class="single-widget about">
                        <div class="footer-logo">
                            <h2>${options.optionSiteTitle}</h2>
                        </div>
                        <p>${options.optionSiteDescrption}</p>
                    </div>
                </div>
                <div class="layui-col-xs12 layui-col-sm6 layui-col-md4">
                    <div class="single-widget">
                        <h2>相关链接</h2>
                        <ul class="social-icon">
                            <li class="active"><a href="<%=request.getContextPath()%>/blogIndex"><i class="fa fa-book"></i>博文</a></li>
                            <li class="active"><a href="<%=request.getContextPath()%>/message"><i class="fa fa-comments"></i>留言</a></li>
                            <li class="active"><a href="<%=request.getContextPath()%>/day"><i class="fa fa-snowflake-o"></i>日记</a></li>
<%--                            <li class="active"><a href="#"><i class="fa fa-share"></i>资源</a></li>--%>
<%--                            <li class="active"><a href="#"><i class="fa fa-files-o"></i>归档</a></li>--%>
                        </ul>
                    </div>
                </div>
                <div class="layui-col-xs12 layui-col-sm12 layui-col-md4">
                    <div class="single-widget contact">
                        <h2>联系我</h2>
                        <ul class="list">
                            <li><i class="fa fa-map"></i>地址: 山东省潍坊市寿光市潍坊科技学院</li>
                            <li><i class="fa fa-qq"></i>QQ: 1259892859 </li>
                            <li><i class="fa fa-envelope"></i>邮箱: 1259892859@qq.com</li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="copyright">
        <div class="container">
            <div class="layui-row">
                <div class="layui-col-xs12 layui-col-sm12 layui-col-md12 text-center">
                    <p>Copyright &copy; 2020 ${options.optionSiteTitle} All Rights Reserved V.3.1.3
                        <a href="http://beian.miit.gov.cn/" target="_blank">
                        <span>鲁ICP备20023189</span>
                    </a></p>
                </div>
            </div>
        </div>
    </div>
</footer>
<script src="<%=request.getContextPath()%>/layui/layui.js"></script>
<script src="<%=request.getContextPath()%>/js/wow.min.js"></script>
<script src="<%=request.getContextPath()%>/js/index.js"></script>
</body>
</html>