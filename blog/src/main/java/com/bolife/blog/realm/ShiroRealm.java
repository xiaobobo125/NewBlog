package com.bolife.blog.realm;

import com.bolife.blog.entity.User;
import com.bolife.blog.service.UserService;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.*;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.PrincipalCollection;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.Date;

/**
 * @author Mr.BoBo
 * @create 2020-08-04 15:36
 */
public class ShiroRealm extends AuthorizingRealm {

    @Autowired
    private UserService userService;

    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principalCollection) {
        return null;
    }

    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws AuthenticationException {
        UsernamePasswordToken userToken = (UsernamePasswordToken) token;
        String username = userToken.getUsername();
        String password = String.valueOf(userToken.getPassword());
        User user = userService.getUserByUserName(username);
        if(user == null) {
            throw new AccountException("账号错误");
        }
        if(!password.equals(user.getUserPass())){
            throw new AccountException("密码错误");
        }
        if(user.getUserStatus()==null || user.getUserStatus() != 1){
            throw new AccountException("用户权限不足！");
        }
        user.setUserLastLoginTime(new Date());
        userService.updateUser(user);
        Session session = SecurityUtils.getSubject().getSession();
        session.setAttribute("user",user);
        SimpleAuthenticationInfo simpleAuthenticationInfo = new SimpleAuthenticationInfo(user.getUserName(),user.getUserPass(),user.getUserId().toString());
        return simpleAuthenticationInfo;
    }
}
