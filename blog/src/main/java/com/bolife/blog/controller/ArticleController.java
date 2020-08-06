package com.bolife.blog.controller;


import com.bolife.blog.entity.*;
import com.bolife.blog.service.*;
import com.bolife.blog.util.LuceneIndex;
import com.bolife.blog.util.ResultJSON;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.util.HtmlUtils;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
@RequestMapping("/article")
@Slf4j
public class ArticleController {

    @Autowired
    private ArticleService articleService;

    @Autowired
    private UserService userService;

    @Autowired
    private TagService tagService;

    @Autowired
    private OptionsService optionsService;

    @Autowired
    private MenuService menuService;

    @Autowired
    private ArticleLikeService articleLikeService;

    @RequestMapping("/admin/getAllArticle")
    @ResponseBody
    public ResultJSON returnJsonData(@RequestParam(required = false,defaultValue = "1")Integer page,
                                     @RequestParam(required = false,defaultValue = "10")Integer limit){
        ResultJSON resultJSON = new ResultJSON();
        List<Article> allArticle = articleService.getAllArticle((page-1)*limit, limit);
        for (Article article : allArticle) {
            User userById = userService.getUserById(article.getArticleUserId());
            article.setUser(userById);
        }
        Integer articleCountByShow = articleService.getArticleCountByShow();
        resultJSON.setCode(0);
        resultJSON.setMsg("");
        resultJSON.setCount(articleCountByShow);
        resultJSON.setData(allArticle);
        return resultJSON;
    }

    @RequestMapping("/del/{id}")
    @ResponseBody
    public ResultJSON delArticle(@PathVariable("id")Integer id){
        ResultJSON result = new ResultJSON();
        try{
            articleService.deleteArticle(id);
            result.setCode(1);
        }catch(Exception e){
            result.setCode(0);
            result.setMsg("删除失败，请联系管理员");
        }
        return result;
    }

    @RequestMapping("/edit/{id}")
    public String goEdit(@PathVariable("id")Integer id, Model model){
        Article articleById = articleService.getArticleById(id);
        Tag tagByArticleId = tagService.getTagByArticleId(id);
        List<Tag> tagList = tagService.getAllTag();
        articleById.setTag(tagByArticleId);
        Options options = optionsService.getOptions();
        List<Menu> allMenu = menuService.getAllMenu();
        model.addAttribute("menuList",allMenu);
        model.addAttribute("options",options);
        model.addAttribute("article",articleById);
        model.addAttribute("tagList",tagList);
        model.addAttribute("listStatus",1);
        return "Admin/Article/edit";
    }

    @RequestMapping("/insert")
    public String goInsert(Model model){
        Options options = optionsService.getOptions();
        List<Tag> allTag = tagService.getAllTag();
        model.addAttribute("options",options);
        model.addAttribute("listStatus",1);
        model.addAttribute("tagList",allTag);
        return "Admin/Article/insert";
    }

    @RequestMapping(value = "/editSubmit",method = RequestMethod.POST)
    public String editArticle(Article article,Integer tagId){
        Tag tagByArticleId = tagService.getTagByArticleId(article.getArticleId());
        if(tagByArticleId == null ){
            tagService.insertArticleTagRef(tagId,article.getArticleId());
        }else if(tagByArticleId.getTagId() != tagId){
            tagService.deleteArticleTagRef(tagByArticleId.getTagId(),article.getArticleId());
            tagByArticleId.setTagId(tagId);
            tagService.insertArticleTagRef(tagByArticleId.getTagId(),article.getArticleId());
        }
        articleService.updateArticle(article);
        try{
            LuceneIndex.addIndex(article);
        }catch (Exception e){
            log.error("分词器错误！");
        }
        return "redirect:/admin/article";
    }
    @RequestMapping(value = "/insertSubmit",method = RequestMethod.POST)
    public String insertArticle(Article article,Integer tagId){
        Integer integer = articleService.insertArticle(article);
        tagService.insertArticleTagRef(tagId,article.getArticleId());
        try{
            LuceneIndex.addIndex(article);
        }catch (Exception e){
            log.error("分词器错误！");
        }
        return "redirect:/admin/article";
    }

    @RequestMapping("/doGood/{id}")
    @ResponseBody
    public ResultJSON doGood(@PathVariable("id")Integer id, HttpServletRequest request){
        ResultJSON data = new ResultJSON();
        User user = (User) request.getSession().getAttribute("userLogin");
        if (user == null){
            data.setCode(0);
            data.setMsg("您还未登陆，请登录后操作！");
            return data;
        }
        ArticleLike articleLike = articleLikeService.getArticleLike(id, user.getUserId());
        if(articleLike == null){
            Article articleById = articleService.getArticleById(id);
            articleLikeService.insertArticleLike(id,user.getUserId());
            articleById.setArticleLikeCount(articleById.getArticleLikeCount()+1);
            articleService.updateArticle(articleById);
            data.setCode(1);
            data.setMsg("点赞成功！");
        }else{
            data.setCode(0);
            data.setMsg("您已经点过赞啦！");
        }
        return data;
    }

    @RequestMapping("/view/{id}")
    @ResponseBody
    public ResultJSON incrView(@PathVariable("id")Integer id){
        ResultJSON data = new ResultJSON();
        try {
            Article article = articleService.getArticleById(id);
            article.setArticleViewCount(article.getArticleViewCount() + 1);
            articleService.updateArticle(article);
            data.setCode(1);
            data.setMsg("增加访问量成功！");
        }catch (Exception e){
            data.setCode(0);
            data.setMsg("增加失败！");
        }
        return data;
    }

    @RequestMapping("/search")
    @ResponseBody
    public ResultJSON showIndex(String content){
        ResultJSON data = new ResultJSON();
        List<Article> articleList = null;
        try {
            articleList = LuceneIndex.searchBlog(content);
            data.setCode(1);
            data.setMsg("成功");
            data.setData(articleList);
        } catch (Exception e) {
            data.setCode(0);
            e.printStackTrace();
        }
        return data;
    }
}
