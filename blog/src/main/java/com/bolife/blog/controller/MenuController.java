package com.bolife.blog.controller;

import com.bolife.blog.entity.Menu;
import com.bolife.blog.service.MenuService;
import com.bolife.blog.service.OptionsService;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

/**
 * @author Mr.BoBo
 * @create 2020-08-03 16:12
 */
@Controller
@RequestMapping("/menu")
public class MenuController {
    @Autowired
    private MenuService menuService;

    @Autowired
    private OptionsService optionsService;

    @RequestMapping("/delete/{id}")
    public String deleteMenu(@PathVariable("id")Integer id){
        menuService.deleteMenu(id);
        return "redirect:/admin/menu";
    }

    @RequestMapping("/edit/{id}")
    public String editMenu(@PathVariable("id")Integer id, Model model){
        Menu menuById = menuService.getMenuById(id);
        List<Menu> allMenu = menuService.getAllMenu();
        model.addAttribute("menuList",allMenu);
        model.addAttribute("menu",menuById);
        return "Admin/Menu/edit";
    }
    @RequestMapping("/insertSubmit")
    public String insertMenu(Menu menu){
        menuService.insertMenu(menu);
        return "redirect:/admin/menu";
    }

    @RequestMapping("/editSubmit")
    public String editMenu(Menu menu){
        menuService.updateMenu(menu);
        return "redirect:/admin/menu";
    }
}
