<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<!DOCTYPE html>
<!--[if IE 8]>
<html xmlns="http://www.w3.org/1999/xhtml" class="ie8" lang="zh-CN">
<![endif]-->
<!--[if !(IE 8) ]><!-->
<html xmlns="http://www.w3.org/1999/xhtml" lang="zh-CN">
<!--<![endif]-->
<html xmlns="http://www.w3.org/1999/xhtml" lang="zh-CN">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title>${options.optionSiteTitle} &lsaquo; 注册</title>
    <link rel="stylesheet" href="/plugin/font-awesome/css/font-awesome.min.css">
    <link rel="shortcut icon" href="/img/logo.png">
    <link rel='stylesheet' id='dashicons-css'  href='/plugin/login/dashicons.min.css' type='text/css' media='all' />
    <link rel='stylesheet' id='buttons-css'  href='/plugin/login/buttons.min.css' type='text/css' media='all' />
    <link rel='stylesheet' id='forms-css'  href='/plugin/login/forms.min.css' type='text/css' media='all' />
    <link rel='stylesheet' id='l10n-css'  href='/plugin/login/l10n.min.css' type='text/css' media='all' />
    <link rel='stylesheet' id='login-css'  href='/plugin/login/login.min.css' type='text/css' media='all' />
    <style type="text/css">
        body{
            font-family: "Microsoft YaHei", Helvetica, Arial, Lucida Grande, Tahoma, sans-serif;
            background: url(/img/loginBg.jpg);
            width:100%;
            height:100%;
        }
        .login h1 a {
            background-size: 220px 50px;
            width: 220px;
            height: 50px;
            padding: 0;
            margin: 0 auto 1em;
        }
        .login form {
            background: #fff;
            background: rgba(255, 255, 255, 0.6);
            border-radius: 2px;
            border: 1px solid #fff;
        }
        .login label {
            color: #000;
        }
        .login label .require {
            color: red;
        }

        .login label .input {
            font-size: 13px;
        }

        #backtoblog a, #nav a {
            color: #fff !important;
        }

    </style><meta name='robots' content='noindex,follow' />
    <meta name="viewport" content="width=device-width" />
    <style>
        body {
            background-repeat: no-repeat;
            background-size: 100% 100%;
            background-attachment: fixed;
        }
    </style>
</head>
<body class="login login-action-login wp-core-ui  locale-zh-cn">
<div id="login">
    <h1><a href="/" title="欢迎您光临本站！" tabindex="-1">${options.optionSiteTitle}用户注册</a></h1>
    <form name="registform" id="registform"  method="post">
        <p>
            <label for="user_email"><span id="errorMsg" class="require">${msg}</span><br /></label>
        </p>
        <p>
            <label for="user_email">邮箱<span class="require">*</span><br />
                <input type="text" name="email" id="user_email" class="input" placeholder="邮箱地址" size="5" required/></label>
        </p>
        <p>
            <label for="user_login">用户昵称<span class="require">*</span><br />
                <input type="text" name="username" id="user_login" class="input" placeholder="用户昵称" size="5" required/></label>
        </p>
        <p>
            <label for="user_pass">密码<span class="require">*</span><br />
                <input type="password" name="password" id="user_pass" class="input" placeholder="密码" size="5" required/>
            </label>
        </p>
        <p>
            <label for="user_confim">确认密码<span class="require">*</span><br />
                <input type="password" name="con-password" id="user_confim" class="input" placeholder="确认密码" size="5" required/>
            </label>
        </p>
        <p class="submit">
            <input type="button" name="wp-submit" id="submit-btn" class="button button-primary button-large" value="注册" />
        </p>
    </form>



    <script type="text/javascript">
        function wp_attempt_focus(){
            setTimeout( function(){ try{
                d = document.getElementById('user_login');
                d.focus();
                d.select();
            } catch(e){}
            }, 200);
        }

        wp_attempt_focus();
        if(typeof wpOnload=='function')wpOnload();
    </script>

    <p id="backtoblog"><a href="/">&larr; 返回到博客</a></p>

</div>


<div class="clear"></div>

<script src="/js/jquery.min.js"></script>
<script src="/js/validate.js"></script>
</body>
</html>

