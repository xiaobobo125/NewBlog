package com.bolife.blog.mapper;

import com.bolife.blog.entity.User;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @author Mr.BoBo
 * @create 2020-07-31 10:06
 */
@Mapper
public interface UserMapper {
    User findUserById(@Param("id") Integer id);

    List<User> findAllUser(@Param("pageNum") Integer pageNum, @Param("limit") Integer limit);

    Integer findUserCount();

    void deleteUser(@Param("id") Integer id);

    void updateUser(@Param("user") User user);
    Integer insert(@Param("user")User user);

    User findUserByName(@Param("userName") String userName);

    User findUserByEmail(@Param("email") String email);

    List<User> findUserByLastLogin(@Param("count") Integer count);
}
