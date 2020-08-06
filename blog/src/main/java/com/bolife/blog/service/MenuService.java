package com.bolife.blog.service;

import com.bolife.blog.entity.Menu;

import java.util.List;

/**
 * @author Mr.BoBo
 * @create 2020-08-03 16:05
 */
public interface MenuService {
    List<Menu> getAllMenu();

    void deleteMenu(Integer id);

    Menu getMenuById(Integer id);

    Integer insertMenu(Menu menu);

    void updateMenu(Menu menu);
}
