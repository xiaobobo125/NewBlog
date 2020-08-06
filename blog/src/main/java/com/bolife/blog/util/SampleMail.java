package com.bolife.blog.util;

import com.bolife.blog.entity.User;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.io.UnsupportedEncodingException;
import java.util.Properties;

public class SampleMail {
    private static final String ALIDM_SMTP_HOST = "smtpdm.aliyun.com";
    private static final String ALIDM_SMTP_PORT = "80";//或"80"
    public static void sendEmail(User user) {
        // 配置发送邮件的环境属性
        final Properties props = new Properties();
        // 表示SMTP发送邮件，需要进行身份验证
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.host", ALIDM_SMTP_HOST);
        props.put("mail.smtp.port", ALIDM_SMTP_PORT);
        // 发件人的账号，填写控制台配置的发信地址,比如xxx@xxx.com
        props.put("mail.user", "mrbobo@email.xinglili.top");
        // 访问SMTP服务时需要提供的密码(在控制台选择发信地址进行设置)
        props.put("mail.password", "SMTP1259892859mrbobo");
        Authenticator authenticator = new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                // 用户名、密码
                String userName = props.getProperty("mail.user");
                String password = props.getProperty("mail.password");
                return new PasswordAuthentication(userName, password);
            }
        };
        // 使用环境属性和授权信息，创建邮件会话
        Session mailSession = Session.getInstance(props, authenticator);
        // 创建邮件消息
        MimeMessage message = new MimeMessage(mailSession){
        };
        try {
        // 设置发件人邮件地址和名称。填写控制台配置的发信地址,比如xxx@xxx.com。和上面的mail.user保持一致。名称用户可以自定义填写。
        InternetAddress from = new InternetAddress("mrbobo@email.xinglili.top", "MrBoBo");
        message.setFrom(from);
        //可选。设置回信地址
        Address[] a = new Address[1];
        a[0] = new InternetAddress("1259892859@qq.com");
        message.setReplyTo(a);
        // 设置收件人邮件地址，比如yyy@yyy.com
        InternetAddress to = new InternetAddress(user.getUserEmail());
        message.setRecipient(MimeMessage.RecipientType.TO, to);
        //如果同时发给多人，才将上面两行替换为如下（因为部分收信系统的一些限制，尽量每次投递给一个人；同时我们限制单次允许发送的人数是30人）：
        // 设置邮件标题
        message.setSubject("用户账号验证");
        // 设置邮件的内容
        String html = "<h1>激活邮件</h1><h2>欢迎注册MrBoBo的博客网站，点击链接激活：</h2><a href=\"http://127.0.0.1:8080/blog/user/userStatus/"+user.getUserId()+"\" target=\"_blank\">点击激活</a>";
        message.setContent(html, "text/html;charset=UTF-8");
        // 发送附件代码，结束
        // 发送邮件
        Transport.send(message);
        }
        catch (MessagingException e) {
            String err = e.getMessage();
            // 在这里处理message内容， 格式是固定的
            System.out.println(err);
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
    }
}