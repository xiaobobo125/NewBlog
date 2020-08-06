package com.bolife.blog.service.impl;

import com.bolife.blog.entity.User;
import com.bolife.blog.mapper.UserMapper;
import com.bolife.blog.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

/**
 * @author Mr.BoBo
 * @create 2020-07-31 10:06
 */
@Service
public class UserServiceImpl implements UserService {
    @Autowired
    private UserMapper userMapper;
    @Override
    public User getUserById(int id) {
        return userMapper.findUserById(id);
    }

    @Override
    public List<User> getAllUser(Integer pageNum, Integer limit) {
        List<User> allUser = userMapper.findAllUser(pageNum,limit);
        return allUser;
    }

    @Override
    public Integer getUserCount() {
        return userMapper.findUserCount();
    }

    @Override
    public void deleteUser(Integer id) {
        userMapper.deleteUser(id);
    }

    @Override
    public void updateUser(User user) {
        userMapper.updateUser(user);
    }

    @Override
    public Integer insertUser(User user) {
        user.setUserLastLoginTime(new Date());
        user.setUserRegisterTime(new Date());
        user.setUserNickname(user.getUserName());
        return userMapper.insert(user);
    }

    @Override
    public User getUserByUserName(String userName) {
        return userMapper.findUserByName(userName);
    }

    @Override
    public User getUserByEmail(String email) {
        return userMapper.findUserByEmail(email);
    }

    @Override
    public List<User> getUserByLastLogin(Integer count) {
        return userMapper.findUserByLastLogin(count);
    }

}
