package com.bolife.blog.controller;

import com.bolife.blog.entity.*;
import com.bolife.blog.service.*;
import com.bolife.blog.util.SessionCount;
import lombok.extern.slf4j.Slf4j;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.util.HtmlUtils;

import javax.jws.WebParam;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * @author Mr.BoBo
 * @create 2020-07-29 16:27
 */
@Controller
@Slf4j
public class HomeController {
    @Autowired
    private OptionsService optionsService;

    @Autowired
    private ArticleService articleService;

    @Autowired
    private TagService tagService;

    @Autowired
    private DiaryService diaryService;

    @Autowired
    private CommentService commentService;

    @Autowired
    private UserService userService;

    @Autowired
    private LinkService linkService;

    @Autowired
    private NoticeService noticeService;

    @Autowired
    private MenuService menuService;

    @RequestMapping({"/","index"})
    public String goHome(Model model){
        Options options = optionsService.getOptions();
        List<Article> hotArticle = articleService.getHotService(3);
        List<Link> allLink = linkService.getAllLink();
        List<Menu> allMenu = menuService.getAllMenu();
        model.addAttribute("menuList",allMenu);
        model.addAttribute("linkList",allLink);
        model.addAttribute("hotArticle",hotArticle);
        model.addAttribute("options",options);
        return "index";
    }

    @RequestMapping("/blogIndex")
    public String goBlogIndex(@RequestParam(required = false,defaultValue = "0")Integer pageNum,
                              @RequestParam(required = false,defaultValue = "10")Integer pageSize,
                              Model model){
        //获取网站信息
        Options options = optionsService.getOptions();
        //获取菜单
        List<Menu> allMenu = menuService.getAllMenu();
        //获取文章列表
        List<Article> articleList = articleService.getAllArticle(pageNum*pageSize,pageSize);
        //获取文章个数
        Integer articleCount = articleService.getArticleCountByShow();
        //获取文章分类
        List<Tag> allTag = tagService.getAllTag();
        //获取热门文章
        List<Article> hotService = articleService.getHotService(5);
        //获取置顶推荐
        List<Article> reTopArticle = articleService.getReTopArticle(5);
        //获取最近访客
        List<User> userByLastLogin = userService.getUserByLastLogin(12);
        model.addAttribute("userList",userByLastLogin);
        model.addAttribute("menuList",allMenu);
        model.addAttribute("options",options);
        model.addAttribute("articleList",articleList);
        model.addAttribute("articleCount",articleCount);
        model.addAttribute("pageNum",pageNum+1);
        model.addAttribute("tagList",allTag);
        model.addAttribute("hotService",hotService);
        model.addAttribute("reTopArticle",reTopArticle);
        return "article";
    }

    @RequestMapping("/day")
    public String goDayIndex(Model model){
        Options options = optionsService.getOptions();
        List<Diary> diaryList = diaryService.getAllDiary();
        Map<String,List<Diary>> data = new HashMap<>();
        for (Diary diary : diaryList) {
            diary.setDiaryContent(HtmlUtils.htmlUnescape(diary.getDiaryContent()));
            String year = new SimpleDateFormat("yyyy").format(diary.getDiaryCreateTime());
            if (!data.containsKey(year)) {
                ArrayList<Diary> day = new ArrayList<>();
                day.add(diary);
                data.put(year, day);
            } else {
                data.get(year).add(diary);
            }
        }
        List<Menu> allMenu = menuService.getAllMenu();
        model.addAttribute("menuList",allMenu);
        model.addAttribute("diaryList",data);
        model.addAttribute("options",options);
        return "diary";
    }

    @RequestMapping("/message")
    public String goMessage(HttpServletRequest request,Model model){
        User userLogin = (User) request.getSession().getAttribute("userLogin");
        List<Comment> commentList = commentService.getComment();
        Options options = optionsService.getOptions();
        List<Menu> allMenu = menuService.getAllMenu();
        model.addAttribute("menuList",allMenu);
        model.addAttribute("options",options);
        model.addAttribute("commentList",commentList);
        model.addAttribute("userLogin",userLogin);
        return "message";
    }

    @RequestMapping("/friendLink")
    public String goLink(Model model){
        List<Link> allLink = linkService.getAllLink();
        Notice noticeById = noticeService.getNoticeById(1);
        Options options = optionsService.getOptions();
        List<Menu> allMenu = menuService.getAllMenu();
        model.addAttribute("menuList",allMenu);
        model.addAttribute("options",options);
        model.addAttribute("linkList",allLink);
        model.addAttribute("linkDesc",noticeById);
        return "link";
    }

    @RequestMapping("/about/{id}")
    public String goAbout(@PathVariable("id")Integer id, Model model){
        Notice noticeById = noticeService.getNoticeById(id);
        Options options = optionsService.getOptions();
        List<Menu> allMenu = menuService.getAllMenu();
        model.addAttribute("menuList",allMenu);
        model.addAttribute("options",options);
        model.addAttribute("linkDesc",noticeById);
        return "about";
    }

    @RequestMapping("/login")
    public String goLogin(String url,HttpServletRequest request,Model model){
        if(StringUtils.isEmpty(url)){
            url=request.getContextPath();
        }
        model.addAttribute("url",url);
        return "login";
    }
    @RequestMapping("/regist")
    public String goRegist(){
        return "regist";
    }

    @RequestMapping("/logout")
    private String userLogout(HttpServletRequest request){
        HttpSession session = request.getSession();
        session.removeAttribute("userLogin");
        return "redirect:/login";
    }

    @RequestMapping("/404")
    public String goError404(){
        return "404";
    }
    @RequestMapping("/500")
    public String goError500(){
        return "500";
    }
}
