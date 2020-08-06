package com.bolife.blog.controller;

import com.bolife.blog.entity.*;
import com.bolife.blog.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

/**
 * @author Mr.BoBo
 * @create 2020-07-31 16:56
 */
@Controller
@RequestMapping("/tag")
public class TagController {

    @Autowired
    private TagService tagService;

    @Autowired
    private ArticleService articleService;

    @Autowired
    private OptionsService optionsService;

    @Autowired
    private MenuService menuService;

    @Autowired
    private UserService userService;

    @RequestMapping("/{id}")
    public String getTagArticle(@RequestParam(required = false,defaultValue = "0")Integer pageNum,
                                @RequestParam(required = false,defaultValue = "10")Integer pageSize,
                                @PathVariable("id") Integer id, Model model){
        Options options = optionsService.getOptions();
        List<Article> articlesByTagId = articleService.getAllArticlesByTagId(id,pageNum,pageSize);
        //获取文章个数
        Integer articleCount = articleService.getAllArticlesByTagIdCount(id);
        //获取文章分类
        List<Tag> allTag = tagService.getAllTag();
        //获取热门文章
        List<Article> hotService = articleService.getHotService(5);
        //获取置顶推荐
        List<Article> reTopArticle = articleService.getReTopArticle(5);
        //获取最近访客
        List<User> userByLastLogin = userService.getUserByLastLogin(12);
        List<Menu> allMenu = menuService.getAllMenu();
        model.addAttribute("userList",userByLastLogin);
        model.addAttribute("menuList",allMenu);
        model.addAttribute("options",options);
        model.addAttribute("articleList",articlesByTagId);
        model.addAttribute("articleCount",articleCount);
        model.addAttribute("pageNum",pageNum+1);
        model.addAttribute("tagList",allTag);
        model.addAttribute("hotService",hotService);
        model.addAttribute("reTopArticle",reTopArticle);
        model.addAttribute("tagId",id);
        return "tagArticle";
    }

    @RequestMapping(value = "/insertSubmit",method = RequestMethod.POST)
    public String insertTag(Tag tag){
        tagService.insertTag(tag);
        return "redirect:/admin/tag";
    }

    @RequestMapping("/delete/{id}")
    public String goTag(@PathVariable("id")Integer id){
        tagService.deleteTag(id);
        return "redirect:/admin/tag";
    }

    @RequestMapping("/edit/{id}")
    public String goEdit(@PathVariable("id")Integer id,Model model){
        Tag tag = tagService.getTagById(id);
        List<Tag> allTag = tagService.getAllTag();
        model.addAttribute("tagList",allTag);
        model.addAttribute("tag",tag);
        model.addAttribute("listStatus",1);
        return "Admin/Tag/edit";
    }
    @RequestMapping(value = "/editSubmit",method = RequestMethod.POST)
    public String editTag(Tag tag){
        tagService.updateTag(tag);
        return "redirect:/admin/tag";
    }
}
