﻿layui.use(['element', 'jquery', 'form', 'layedit', 'flow'], function () {
    var element = layui.element;
    var form = layui.form;
    var $ = layui.jquery;
    var layedit = layui.layedit;
    var flow = layui.flow;
    var pathName=window.document.location.pathname;
    var editIndex = layedit.build('remarkEditor', {
        height: 150,
        tool: ['face'],
    });

    var targetId;
    var targetName;
    //评论和留言的编辑器的验证
    form.verify({
        content: function (value) {
            value = $.trim(layedit.getContent(editIndex));
            if (value == "") return "请输入内容";
            layedit.sync(editIndex);
        },
        replyContent: function (value) {
            if (value == "") return "请输入内容";
        }
    });

    form.on("submit(formLeaveMessage)", function(data) {
        var projectName=pathName.substring(0,pathName.substr(1).indexOf('/')+1);
        console.log(data.field);
        // layer.load(1);
        $.ajax({
            url:projectName+"/blog/addComment",
            type: "POST",
            data:{
                articleid: data.field.articleid,
                editorContent: data.field.editorContent,
            },
            success:function (result) {
                if(result.code == 1){
                    layer.msg ("留言成功！");
                    window.location.reload();
                    // window.location.assign(projectName+"/blog/article/"+data.field.articleid);
                }else{
                    layer.msg (result.msg);
                }
                console.log(result);
            },
            error: function (result) {
                layer.msg ("服务器出错，请联系管理员！");
                console.log(result);
            }
        })
        return false;
    });

    form.on("submit(formReply)", function(data) {
        console.log(data.field);
        var projectName=pathName.substring(0,pathName.substr(1).indexOf('/')+1);
        console.log(data.field);
        // layer.load(1);
        $.ajax({
            url:projectName+"/blog/addComment",
            type: "POST",
            data:{
                articleid: data.field.articleId,
                editorContent: data.field.replyContent,
                comPid: targetId,
                comPName: targetName,
            },
            success:function (result) {
                if(result.code == 1){
                    layer.msg ("留言成功！");
                    window.location.reload();
                    // window.location.assign(projectName+"/blog/article/"+data.field.articleid);
                }else{
                    layer.msg (result.msg);
                }
                console.log(result);
            },
            error: function (result) {
                layer.msg ("服务器出错，请联系管理员！");
                console.log(result);
            }
        })
        return false;
    });

    //回复按钮点击事件
    $('#blog-comment').on('click', '.btn-reply', function () {
        targetId = $(this).data('targetid');
        targetName = $(this).data('targetname');
        var $container = $(this).parent('p').parent().siblings('.replycontainer');
        if ($(this).text() == '回复') {
            $container.find('textarea').attr('placeholder', '回复【' + targetName + '】');
            $container.removeClass('layui-hide');
            $container.find('input[name="targetUserId"]').val(targetId);
            $(this).parents('.blog-comment li').find('.btn-reply').text('回复');
            $(this).text('收起');
        } else {
            $container.addClass('layui-hide');
            $container.find('input[name="targetUserId"]').val(0);
            $(this).text('回复');
        }
    });
});
 