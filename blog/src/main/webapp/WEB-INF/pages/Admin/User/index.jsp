<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="rapid" uri="http://www.rapid-framework.org.cn/rapid" %>

    <rapid:override name="title">
        - 用户列表
    </rapid:override>
<rapid:override name="header-style">
    <style>
        /*覆盖 layui*/

        .layui-table {
            margin-top: 0;
        }

        .layui-btn {
            margin: 2px 0!important;
        }
    </style>
</rapid:override>

<rapid:override name="content">
    <blockquote class="layui-elem-quote">
         <span class="layui-breadcrumb" lay-separator="/">
              <a href="/admin">首页</a>
              <a><cite>用户列表</cite></a>
        </span>
    </blockquote>

    <table id="userList" lay-filter="test"></table>
    <script type="text/html" id="barDemo">
        <a class="layui-btn layui-btn-xs layui-btn-radius layui-btn-normal" lay-event="edit">编辑</a>
        <a class="layui-btn layui-btn-xs layui-btn-radius layui-btn-danger" lay-event="del">删除</a>
    </script>
    <script type="text/html" id="createTime">
        <div>
            {{ layui.util.toDateString(d.userRegisterTime,"yyyy-MM-dd HH:mm:ss")}}
        </div>
    </script>
    <script type="text/html" id="updateTime">
        <div>
            {{ layui.util.toDateString(d.userLastLoginTime,"yyyy-MM-dd HH:mm:ss")}}
        </div>
    </script>

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
                elem: '#userList'
                ,height: 600
                ,url: '<%=request.getContextPath()%>/user/getAllUser' //数据接口
                ,page: true //开启分页
                ,limit: 10
                ,cols: [[
                    {field: 'userId', title: '用户ID', width:100, sort: true}
                    ,{field: 'userEmail', title: '用户Email', width:150}
                    ,{field: 'userAvatar', title: '头像', width:150}
                    ,{field: 'userName', title: '用户名', width:150}
                    ,{field: 'userNickname', title: '用户昵称', width: 150}
                    ,{field: 'userLastLoginIp', title: '登录IP', width: 150}
                    ,{field: 'userLastLoginTime', title: '最后登录', width: 200,sort:true,toolbar: '#createTime'}
                    ,{field: 'userRegisterTime', title: '注册时间', width: 200,sort:true,toolbar: '#updateTime'}
                    ,{field: 'userStatus', title: '用户状态', width: 100, templet:"<div>{{# if(d.userStatus == 2) return '管理员';else return '普通用户';}}</div>"}
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
                            url: "<%=request.getContextPath()%>/user/del/"+obj.data.userId,
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
                    window.location.href="<%=request.getContextPath()%>/user/edit/"+obj.data.userId;
                }
            });
        });
    </script>
</rapid:override>

<%@ include file="../Public/framework.jsp"%>
