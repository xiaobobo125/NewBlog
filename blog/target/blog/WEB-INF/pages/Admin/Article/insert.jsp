<%--保留此处 start--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="rapid" uri="http://www.rapid-framework.org.cn/rapid" %>
<%--保留此处 end--%>
    <rapid:override name="title">
        - 新建文章
    </rapid:override>

<rapid:override name="content">
    <blockquote class="layui-elem-quote">
         <span class="layui-breadcrumb" lay-separator="/">
              <a href="<%=request.getContextPath()%>/admin">首页</a>
              <a href="<%=request.getContextPath()%>/admin/article">文章列表</a>
              <a><cite>添加文章</cite></a>
        </span>
    </blockquote>



    <form class="layui-form"  method="post" id="myForm" action="<%=request.getContextPath()%>/article/insertSubmit">
        <div class="layui-form-item">
            <input type="hidden" id="userId" value="0">
            <label class="layui-form-label">图片描述</label>
            <div class="layui-input-inline">
                <div class="layui-upload">
                    <div class="layui-upload-list" style="">
                        <img class="layui-upload-img" src="<%=request.getContextPath()%>/upload/7df93706-f2c9-4086-8fd8-43d41727ae99.jpg" id="demo1" width="100"
                             height="100">
                        <p id="demoText"></p>
                    </div>
                    <button type="button" class="layui-btn" id="test1">上传图片</button>
                </div>
            </div>
            <input type="hidden" name="articleImg" id="articleImg" value="/upload/7df93706-f2c9-4086-8fd8-43d41727ae99.jpg">
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">标题 <span style="color: #FF5722; ">*</span></label>
            <div class="layui-input-block">
                <input type="text" name="articleTitle" lay-verify="title" id="title" autocomplete="off" placeholder="请输入标题" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item layui-form-text">
            <label class="layui-form-label">内容 <span style="color: #FF5722; ">*</span></label>
            <div class="layui-input-block">
                <textarea class="layui-textarea layui-hide" name="articleContent" lay-verify="content" id="content"></textarea>
            </div>

        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">标签 <span style="color: #FF5722; ">*</span></label>
            <div class="layui-input-inline">
                <select name="tagId" id="tagId"
                        lay-filter="tagId">
                    <option value="">请选择标签</option>
                    <c:forEach items="${tagList}" var="c">
                        <option value="${c.tagId}">${c.tagName}</option>
                    </c:forEach>
                </select>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">order</label>
            <div class="layui-input-inline">
                <input type="number" name="articleOrder" value="" autocomplete="off"
                       class="layui-input">
            </div>
            <div class="layui-form-mid layui-word-aux">输入1-10的数字,order越大排序越前</div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">状态</label>
            <div class="layui-input-block">
                <input type="radio" name="articleStatus" value="2" title="原创" checked>
                <input type="radio" name="articleStatus" value="0" title="转载" >
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-input-block">
                <button class="layui-btn" lay-submit="" lay-filter="demo1">立即提交</button>
                <button type="reset" class="layui-btn layui-btn-primary" onclick="getCateIds()">重置</button>
            </div>
        </div>
        <input type="hidden" name="articleUserId" value="1">
        <blockquote class="layui-elem-quote layui-quote-nm">
            温馨提示：<br>
            1、文章内容的数据表字段类型为MEDIUMTEXT,每篇文章内容请不要超过500万字 <br>
            2、写文章之前，请确保标签和分类存在，否则可以先新建；请勿刷新页面，博客不会自动保存 <br>
            3、插入代码前，可以点击 <a href="http://liuyanzhao.com/code-highlight.html" target="_blank">代码高亮</a>,将代码转成HTML格式

        </blockquote>

    </form>


</rapid:override>

<rapid:override name="footer-script">

    <script>
        layui.use(['form', 'layedit', 'laydate'], function() {
            var form = layui.form
                , layer = layui.layer
                , layedit = layui.layedit
                , laydate = layui.laydate;


            //上传图片,必须放在 创建一个编辑器前面
            layedit.set({
                uploadImage: {
                     url: '<%=request.getContextPath()%>/upload/image' //接口url
                    ,type: 'post' //默认post
                }
            });

            //创建一个编辑器
            var editIndex = layedit.build('content',{
                    height:350,
                }
            );

            //自定义验证规则
            form.verify({
                title: function (value) {
                    if (value.length < 5) {
                        return '标题至少得5个字符啊';
                    }
                }
                , pass: [/(.+){6,12}$/, '密码必须6到12位']
                , content: function (value) {
                    layedit.sync(editIndex);
                }
            });

            layedit.build('content', {
                tool: [
                    'strong' //加粗
                    ,'italic' //斜体
                    ,'underline' //下划线
                    ,'del' //删除线
                    ,'|' //分割线
                    ,'left' //左对齐
                    ,'center' //居中对齐
                    ,'right' //右对齐
                    ,'link' //超链接
                    ,'unlink' //清除链接
                    ,'face' //表情
                    ,'image' //插入图片
                    ,'code'
                ]
            });

            layui.use('code', function(){ //加载code模块
                layui.code();
            });


     });
    layui.use('upload', function () {
        var $ = layui.jquery,
            upload = layui.upload;
        var uploadInst = upload.render({
            elem: '#test1',
            url: '<%=request.getContextPath()%>/upload/image',
            field: 'file',
            before: function (obj) {
                console.log(obj);
                obj.preview(function (index, file, result) {
                    $('#demo1').attr('src', result);
                });
            },
            done: function (res) {
                if (res.code != 0) {
                    return layer.msg('上传失败');
                }
                $("#articleImg").attr("value", "/upload/"+res.data.title);
                console.log(res);
            },
            error: function () {
                var demoText = $('#demoText');
                demoText.html('' +
                    '<span style="color: #FF5722;">上传失败</span>' +
                    ' <a class="layui-btn layui-btn-mini demo-reload">重试</a>');
                demoText.find('.demo-reload').on('click', function () {
                    uploadInst.upload();
                });
            }
        });

    });
        // layui.use(['upload', 'layer'], function () {
        //     var $ = layui.jquery
        //         , layer = layui.layer
        //         , upload = layui.upload;
        //
        //     upload.render({
        //         elem: '#test8'
        //         , url: '/ad,om'
        //         , auto: false
        //         , accept: 'file'
        //         , bindAction: '#test9'
        //         , ext: 'xls|xlsx'
        //         , choose: function (obj) {
        //             var file = this.files = obj.pushFile();
        //             obj.preview(function (index, file, result) {
        //                 document.getElementById("tt").style.display = "inline";
        //                 var xx = document.getElementById("tt").value = file.name + '【' + (file.size / 1024 / 1024).toFixed(2) + 'MB' + '】';
        //             })
        //         }
        //         , done: function (res) {
        //             if (res.code == 1) {
        //                 return layer.msg('Excel格式不对！');
        //             } else if (res.code == 2) {
        //                 return layer.msg('文件导入失败！！');
        //             } else if (res.code == 3) {
        //                 return layer.msg('文件上传失败！！');
        //             } else {
        //                 return layer.msg('文件导入成功！！');
        //             }
        //         }
        //     });
        //
        // });
    </script>

</rapid:override>


<%--此句必须放在最后--%>
<%@ include file="../Public/framework.jsp"%>

