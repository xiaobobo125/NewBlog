package com.bolife.blog.service.impl;

import com.bolife.blog.entity.Menu;
import com.bolife.blog.mapper.MenuMapper;
import com.bolife.blog.service.MenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author Mr.BoBo
 * @create 2020-08-03 16:05
 */
@Service
public class MenuServiceImpl implements MenuService {
    @Autowired
    private MenuMapper menuMapper;

    @Override
    public List<Menu> getAllMenu() {
        return menuMapper.findAllMenu();
    }

    @Override
    public void deleteMenu(Integer id) {
        menuMapper.deleteMenu(id);
    }

    @Override
    public Menu getMenuById(Integer id) {
        return menuMapper.findMenuById(id);
    }

    @Override
    public Integer insertMenu(Menu menu) {
        return menuMapper.insertMenu(menu);
    }

    @Override
    public void updateMenu(Menu menu) {
        menuMapper.updateMenu(menu);
    }
}
