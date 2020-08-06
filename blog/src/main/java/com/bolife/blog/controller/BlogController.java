package com.bolife.blog.controller;

import com.bolife.blog.entity.*;
import com.bolife.blog.service.*;
import com.bolife.blog.util.ResultJSON;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.util.HtmlUtils;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * @author Mr.BoBo
 * @create 2020-07-30 9:26
 */
@Controller
@RequestMapping("/blog")
public class BlogController {
    @Autowired
    private ArticleService articleService;

    @Autowired
    private OptionsService optionsService;

    @Autowired
    private CommentService commentService;

    @Autowired
    private ArticleLikeService  articleLikeService;

    @Autowired
    private MenuService menuService;

    @RequestMapping("/article/{id}")
    public String goArticleInfo(@PathVariable("id")Integer id,
                                HttpServletRequest request,
                                Model model){
        User userLogin = (User) request.getSession().getAttribute("userLogin");
        ResultJSON resultJSON = new ResultJSON();
        ArticleLike articleLike = null;
        //获取网站信息
        Options options = optionsService.getOptions();
        //获取文章信息
        Article articleById = articleService.getArticleById(id);
        if(articleById == null){
            return "redirect:/404";
        }
        //延伸阅读
        List<Article> articlesByTagId = articleService.getArticlesByTagId(id, 5);
        //获取评论
        List<Comment> commentByArticleId = commentService.getCommentByArticleId(id);
        List<Menu> allMenu = menuService.getAllMenu();
        if(userLogin != null){
            articleLike = articleLikeService.getArticleLike(id, userLogin.getUserId());
        }
        model.addAttribute("articleLike",articleLike);
        model.addAttribute("menuList",allMenu);
        model.addAttribute("commentList",commentByArticleId);
        model.addAttribute("options",options);
        model.addAttribute("article",articleById);
        model.addAttribute("articlesList",articlesByTagId);
        return "read";
    }


    @RequestMapping(value = "/addComment",method = RequestMethod.POST)
    @ResponseBody
    public ResultJSON resultJSON(Integer articleid, String editorContent,
                                 @RequestParam(required = false,defaultValue = "0")Integer comPid,
                                 @RequestParam(required = false,defaultValue = "")String comPName,
                                 HttpServletRequest request){
        ResultJSON resultJSON = new ResultJSON();
        User user = (User) request.getSession().getAttribute("userLogin");
        if(user == null){
            resultJSON.setCode(0);
            resultJSON.setMsg("您还未登录，请登录后留言");
            return resultJSON;
        }
        Comment comment = new Comment();
        comment.setCommentUserId(user.getUserId());
        comment.setCommentArticleId(articleid);
        comment.setCommentContent(HtmlUtils.htmlEscape(editorContent));
        comment.setCommentPid(comPid);
        comment.setCommentPname(comPName);
        if(user.getUserStatus() == 1){
            comment.setCommentRole(1);
        }
        commentService.addComment(comment);
        Article articleById = articleService.getArticleById(articleid);
        if(articleById != null){
            articleById.setArticleCommentCount(articleById.getArticleCommentCount()+1);
            articleService.updateArticle(articleById);
        }
        resultJSON.setCode(1);
        resultJSON.setMsg("留言成功");
        return resultJSON;
    }
}
