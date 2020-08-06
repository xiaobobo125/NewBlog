package com.bolife.blog.util;

import com.bolife.blog.service.OptionsService;
import org.apache.shiro.session.Session;
import org.apache.shiro.session.SessionListener;
import org.springframework.beans.factory.annotation.Autowired;

import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

/**
 * @author Mr.BoBo
 * @create 2020-08-05 10:23
 */
public class SessionCount implements HttpSessionListener {
    private static Integer sessionCount = 0;
    public static Integer getSessionCount(){
        return sessionCount;
    }

    @Override
    public void sessionCreated(HttpSessionEvent se) {
        sessionCount++;
    }

    @Override
    public void sessionDestroyed(HttpSessionEvent se) {
        if(sessionCount>0){
            sessionCount--;
        }
    }
}
