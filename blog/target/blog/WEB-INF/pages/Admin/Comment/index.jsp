<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="rapid" uri="http://www.rapid-framework.org.cn/rapid" %>

<rapid:override name="title">
    - 评论列表
</rapid:override>
<rapid:override name="header-style">
    <style>
        /*覆盖 layui*/
        .layui-table {
            margin-top: 0;
        }
    </style>
</rapid:override>

<rapid:override name="content">
    <blockquote class="layui-elem-quote">
        <span class="layui-breadcrumb" lay-separator="/">
              <a href="/admin">首页</a>
              <a><cite>评论列表</cite></a>
        </span>
    </blockquote>
    <div class="layui-tab layui-tab-card">
    <table id="commentList" lay-filter="test"></table>
    <script type="text/html" id="barDemo">
        <a class="layui-btn layui-btn-xs layui-btn-radius layui-btn-normal" lay-event="edit">回复</a>
        <a class="layui-btn layui-btn-xs layui-btn-radius layui-btn-danger" lay-event="del">删除</a>
    </script>
    <script type="text/html" id="createTime">
        <div>
            {{ layui.util.toDateString(d.articleCreateTime,"yyyy-MM-dd HH:mm:ss")}}
        </div>
    </script>
        <div id="nav" style="">
            <%@ include file="../Public/paging.jsp" %>
        </div>
    </div>


</rapid:override>
<rapid:override name="footer-script">
    <script>
        layui.use([ 'laypage', 'layer', 'table','util', 'element','laytpl'], function(){
            var laypage = layui.laypage //分页
                ,utils = layui.util
                ,layer = layui.layer //弹层
                ,table = layui.table //表格
                ,laytpl = layui.laytpl
                ,element = layui.element; //元素操作
            //执行一个 table 实例
            table.render({
                elem: '#commentList'
                ,height: 600
                ,url: '<%=request.getContextPath()%>/comment/getAllComment' //数据接口
                ,page: true //开启分页
                ,limit: 10
                ,cols: [[
                    {field: 'commentId', title: '评论ID', width:100, sort: true}
                    ,{field: 'user', title: '用户名', width:150, templet: "<div>{{d.user.userName}}</div>"}
                    ,{field: 'commentPid', title: '评论/回复', width: 200, sort: true,templet:"<div>{{# if(d.commentPid == 0) return '评论';else return '回复';}}</div>"}
                    ,{field: 'commentArticleId', title: '评论来源', width: 200,templet:"<div>{{# if(d.commentArticleId == 0) return '留言板';else return d.article.articleTitle;}}</div>"}
                    ,{field: 'commentContent', title: '评论内容', width:200}
                    ,{field: 'commentCreateTime', title: '创建时间', width: 200,sort:true,toolbar: '#createTime'}
                    ,{field: 'commentRole', title: '评论角色', width: 200,templet:"<div>{{# if(d.commentPid == 1) return '博主';else return '游客';}}</div>"}
                    ,{fixed: 'right', width: 300, align:'center', toolbar: '#barDemo'}
                ]]
            });
            console.log("表格初始化完成！");
            //监听行工具事件
            table.on('tool(test)', function(obj){ //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
                var data = obj.data //获得当前行数据
                    ,layEvent = obj.event; //获得 lay-event 对应的值
                if(layEvent === 'del'){
                    layer.confirm('确认删除？', function(index){
                        console.log(index);
                        console.log(obj)
                        $.ajax({
                            url: "<%=request.getContextPath()%>/comment/del/"+obj.data.commentId,
                            success:function (result) {
                                if(result.code == 1){
                                    obj.del(); //删除对应行（tr）的DOM结构
                                    layer.close(index);
                                }else{
                                    layer.msg(result.msg);
                                }
                            }
                        });
                    });
                } else if(layEvent === 'edit'){
                    layer.msg("正在跳转到页面...");
                    window.location.href="<%=request.getContextPath()%>/blog/article/"+obj.data.commentArticleId;
                }
                });
          });
    </script>
</rapid:override>
<%@ include file="../Public/framework.jsp" %>
