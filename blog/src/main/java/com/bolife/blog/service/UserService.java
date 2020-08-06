package com.bolife.blog.service;

import com.bolife.blog.entity.User;

import java.util.List;

/**
 * @author Mr.BoBo
 * @create 2020-07-31 10:06
 */
public interface UserService {
    User getUserById(int id);

    List<User> getAllUser(Integer pageNum, Integer limit);

    Integer getUserCount();

    void deleteUser(Integer id);

    void updateUser(User user);

    Integer insertUser(User user);

    User getUserByUserName(String userName);

    User getUserByEmail(String email);

    List<User> getUserByLastLogin(Integer count);
}
