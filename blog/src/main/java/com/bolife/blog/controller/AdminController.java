package com.bolife.blog.controller;

import com.bolife.blog.entity.*;
import com.bolife.blog.service.*;
import com.bolife.blog.util.ResultJSON;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AccountException;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private ArticleService articleService;

    @Autowired
    private CommentService commentService;

    @Autowired
    private OptionsService optionsService;

    @Autowired
    private TagService tagService;

    @Autowired
    private NoticeService noticeService;

    @Autowired
    private LinkService linkService;

    @Autowired
    private UserService userService;

    @Autowired
    private MenuService menuService;

    @RequestMapping({"","/index"})
    public String goAdminIndex(Model model){
        Options options = optionsService.getOptions();
        List<Article> articleList = articleService.getNearArticles(6);
        List<Comment> topComment = commentService.getTopComment(10);
        model.addAttribute("articleList",articleList);
        model.addAttribute("commentList",topComment);
        model.addAttribute("options",options);

        return "Admin/index";
    }

    @RequestMapping("/article")
    public String goArticle(@RequestParam(required = false,defaultValue = "0")Integer pageNum,
                            @RequestParam(required = false,defaultValue = "10")Integer pageSize,
                            Model model){
        Options options = optionsService.getOptions();
        List<Article> articleList = articleService.getAllArticle(pageNum, pageSize);
        model.addAttribute("options",options);
        model.addAttribute("articleList",articleList);
        model.addAttribute("listStatus",1);
        return "Admin/Article/index";
    }

    @RequestMapping("/tag")
    public String goCategory(Model model){
        List<Tag> tagList = tagService.getAllTag();
        Options options = optionsService.getOptions();
        model.addAttribute("options",options);
        model.addAttribute("tagList",tagList);
        model.addAttribute("listStatus",1);
        return "Admin/Tag/index";
    }

    @RequestMapping("/notice")
    public String goNotice(Model model){
        List<Notice> allNotice = noticeService.getAllNotice();
        Options options = optionsService.getOptions();
        model.addAttribute("options",options);
        model.addAttribute("noticeList",allNotice);
        model.addAttribute("listStatus",4);
        return "Admin/Notice/index";
    }

    @RequestMapping("/link")
    public String goLink(Model model){
        List<Link> allLink = linkService.getAllLink();
        Options options = optionsService.getOptions();
        model.addAttribute("options",options);
        model.addAttribute("linkList",allLink);
        model.addAttribute("listStatus",3);
        return "Admin/Link/index";
    }

    @RequestMapping("/comment")
    public String goComment(Model model){
        Options options = optionsService.getOptions();
        model.addAttribute("options",options);
        return "Admin/Comment/index";
    }

    @RequestMapping("/user")
    public String goUser(Model model){
        Options options = optionsService.getOptions();
        model.addAttribute("options",options);
        model.addAttribute("listStatus",5);
        return "Admin/User/index";
    }

    @RequestMapping("/menu")
    public String goMenu(Model model){
        List<Menu> allMenu = menuService.getAllMenu();
        Options options = optionsService.getOptions();
        model.addAttribute("options",options);
        model.addAttribute("menuList",allMenu);
        model.addAttribute("listStatus",6);
        return "Admin/Menu/index";
    }

    @RequestMapping("/options")
    public String goOptions(Model model){
        Options options = optionsService.getOptions();
        model.addAttribute("option",options);
        model.addAttribute("options",options);
        model.addAttribute("listStatus",6);
        return "Admin/Options/index";
    }

    @RequestMapping("/diary")
    public String goDiary(){
        return "Admin/Diary/index";
    }


    @RequestMapping("/login")
    public String adminLogin(Model model){
        Options options = optionsService.getOptions();
        model.addAttribute("options",options);
        return "Admin/login";
    }

    @RequestMapping(value = "/loginVerify",method = RequestMethod.POST)
    @ResponseBody
    public ResultJSON loginVerify(User user){
        ResultJSON data = new ResultJSON();
        try {
            Subject currentUser = SecurityUtils.getSubject();
            //未认证登录
            if(!currentUser.isAuthenticated()) {
                UsernamePasswordToken usernamePasswordToken = new UsernamePasswordToken(user.getUserName(), user.getUserPass());
                //认证登陆
                currentUser.login(usernamePasswordToken);
            }
            data.setCode(1);
            data.setMsg("登陆成功！");
        } catch (AuthenticationException e) {
            if(e instanceof AccountException) {
                data.setCode(0);
                data.setMsg(e.getMessage());
                System.out.println(data.getMsg());
            }
        }
        return data;
    }

    @RequestMapping("/logout")
    public String logOut(){
        Subject subject = SecurityUtils.getSubject();
        subject.logout();
        return "redirect:/admin/login";
    }
}
