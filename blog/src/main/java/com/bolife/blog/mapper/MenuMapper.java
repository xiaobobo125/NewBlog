package com.bolife.blog.mapper;

import com.bolife.blog.entity.Menu;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @author Mr.BoBo
 * @create 2020-08-03 16:05
 */
@Mapper
public interface MenuMapper {
    List<Menu> findAllMenu();

    void deleteMenu(@Param("id") Integer id);

    Menu findMenuById(@Param("id") Integer id);

    Integer insertMenu(@Param("menu") Menu menu);

    void updateMenu(@Param("menu") Menu menu);
}
