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
    <title>友链</title>
    <link rel="shortcut icon" href="<%=request.getContextPath()%>/image/logo.png">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/font-awesome/css/font-awesome.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/layui/css/layui.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/master.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/gloable.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/nprogress.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/about.css" />
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
    <div class="about-banner" id="container">
        <header class="l-top hasAnim arrow-holder">
            <a data-path-hover="M31.3184948,33.1943359 C36.3357454,28.0664371 44.4728686,28.0690462 49.572124,33.2807584 C54.6360745,38.4563871 54.6061839,46.8782889 49.6566817,51.9369454 L31.318494,69.5197703 L49.6566817,89.71735 C54.6739322,94.8452488 54.6713794,103.161825 49.572124,108.373537 C44.5081735,113.549166 36.267997,113.518616 31.3184948,108.459959 L3.8112137,78.891075 C-1.25273677,73.7154463 -1.2880417,65.3601778 3.8112137,60.1484655 L31.3184948,33.1943359 Z">
                <svg width="0" height="0">
                    <path fill="#fff" d="M58.9103319,3.8342148C63.9275825,-1.29368407,72.0647057,-1.29107495,77.1639611,3.92063726C82.2279116,9.09626594,82.198021,17.5181678,77.2485188,22.5768242C77.2485188,22.5768242,31.318494,69.5197703,31.318494,69.5197703C31.318494,69.5197703,77.2485188,116.462716,77.2485188,116.462716C82.2657693,121.590615,82.2632165,129.907191,77.1639611,135.118903C72.1000106,140.294532,63.8598341,140.263982,58.9103319,135.205326C58.9103319,135.205326,3.8112137,78.891075,3.8112137,78.891075C-1.25273677,73.7154463,-1.2880417,65.3601778,3.8112137,60.1484655C3.8112137,60.1484655,58.9103319,3.8342148,58.9103319,3.8342148C58.9103319,3.8342148,58.9103319,3.8342148,58.9103319,3.8342148"></path>
                </svg>
            </a>
            <a data-path-hover="M31.3184948,33.1943359 C36.3357454,28.0664371 44.4728686,28.0690462 49.572124,33.2807584 C54.6360745,38.4563871 54.6061839,46.8782889 49.6566817,51.9369454 L31.318494,69.5197703 L49.6566817,89.71735 C54.6739322,94.8452488 54.6713794,103.161825 49.572124,108.373537 C44.5081735,113.549166 36.267997,113.518616 31.3184948,108.459959 L3.8112137,78.891075 C-1.25273677,73.7154463 -1.2880417,65.3601778 3.8112137,60.1484655 L31.3184948,33.1943359 Z">
                <svg width="0" height="0">
                    <path fill="#fff" d="M58.9103319,3.8342148 C63.9275825,-1.29368407 72.0647057,-1.29107495 77.1639611,3.92063726 C82.2279116,9.09626594 82.198021,17.5181678 77.2485188,22.5768242 L31.318494,69.5197703 L77.2485188,116.462716 C82.2657693,121.590615 82.2632165,129.907191 77.1639611,135.118903 C72.1000106,140.294532 63.8598341,140.263982 58.9103319,135.205326 L3.8112137,78.891075 C-1.25273677,73.7154463 -1.2880417,65.3601778 3.8112137,60.1484655 L58.9103319,3.8342148 Z"></path>
                </svg>
            </a>
        </header>
        <div class="about-title">
            <h1>${linkDesc.noticeTitle}</h1>
            <p>${options.optionSiteTitle}</p><p>${options.optionSiteDescrption}</p>
        </div>
    </div>
    <div class="container-fixed">
        <div class="container-inner">
            <article>
                <section>
                   ${linkDesc.noticeContent}
                </section>
            </article>
            <c:if test="${linkList != null}">
            <ul class="link-list">
                <c:forEach var="link" items="${linkList}">
                <li>
                    <div class="pd-lr-10">
                        <a href="${link.linkUrl}" target="_blank">
                            <img src="${link.linkImage}">
                            <h3>${link.linkName}</h3>
                            <p>${link.linkDescription}</p>
                        </a>
                    </div>
                </li>
                </c:forEach>
            </ul>
            </c:if>
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
<script src="https://cdn.bootcss.com/jquery/3.3.1/jquery.min.js"></script>
<script src="<%=request.getContextPath()%>/js/plugins/blogbenoitboucart.min.js"></script>
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
