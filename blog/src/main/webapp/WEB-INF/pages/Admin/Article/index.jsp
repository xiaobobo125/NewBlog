<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="rapid" uri="http://www.rapid-framework.org.cn/rapid" %>
<rapid:override name="title">
    - 文章列表
</rapid:override>
<rapid:override name="header-style">
    <style>

    </style>
</rapid:override>

<rapid:override name="content">
    <blockquote class="layui-elem-quote">
        <span class="layui-breadcrumb" lay-separator="/">
          <a href="<%=request.getContextPath()%>/admin">首页</a>
          <a><cite>文章列表</cite></a>
        </span>
    </blockquote>

    <div class="layui-tab layui-tab-card">
        <table id="articleList" lay-filter="test"></table>
        <script type="text/html" id="barDemo">
            <a class="layui-btn layui-btn-xs layui-btn-radius layui-btn-normal" lay-event="edit">编辑</a>
            <a class="layui-btn layui-btn-xs layui-btn-radius layui-btn-danger" lay-event="del">删除</a>
        </script>
        <script type="text/html" id="createTime">
           <div>
            {{ layui.util.toDateString(d.articleCreateTime,"yyyy-MM-dd HH:mm:ss")}}
           </div>
        </script>
        <script type="text/html" id="updateTime">
           <div>
            {{ layui.util.toDateString(d.articleUpdateTime,"yyyy-MM-dd HH:mm:ss")}}
           </div>
        </script>
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
                elem: '#articleList'
                ,height: 600
                ,url: '<%=request.getContextPath()%>/article/admin/getAllArticle' //数据接口
                ,title: '文章表'
                ,page: true //开启分页
                ,limit: 10
                ,cols: [[
                    {field: 'articleId', title: '文章ID', width:100, sort: true}
                    ,{field: 'user', title: '用户名', width:150, templet: "<div>{{d.user.userName}}</div>"}
                    ,{field: 'articleTitle', title: '文章标题', width: 200, sort: true}
                    ,{field: 'articleStatus', title: '文章状态', width: 200, templet:"<div>{{# if(d.articleStatus == 2) return '原创';else return '转载';}}</div>"}
                    ,{field: 'articleOrder', title: '文章优先级', width:200}
                    ,{field: 'articleCreateTime', title: '创建时间', width: 200,sort:true,toolbar: '#createTime'}
                    ,{field: 'articleUpdateTime', title: '最后更新', width: 200,sort:true, toolbar: '#updateTime'}
                    ,{fixed: 'right', width: 300, align:'center', toolbar: '#barDemo'}
                ]]
            });
            console.log("表格初始化完成！");

            //监听行工具事件
            table.on('tool(test)', function(obj){ //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
                var data = obj.data //获得当前行数据
                    ,layEvent = obj.event; //获得 lay-event 对应的值
                if(layEvent === 'detail'){
                    layer.msg('查看操作');
                } else if(layEvent === 'del'){
                    layer.confirm('真的删除行么', function(index){

                        console.log(index);
                        console.log(obj)
                        $.ajax({
                            url: "<%=request.getContextPath()%>/article/del/"+obj.data.articleId,
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
                    layer.msg("正在跳转到编辑页面...");
                    window.location.href="<%=request.getContextPath()%>/article/edit/"+obj.data.articleId;
                }
            });
        });
    </script>
</rapid:override>
<%@ include file="../Public/framework.jsp" %>
