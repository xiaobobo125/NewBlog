package com.bolife.blog.controller;

import com.bolife.blog.entity.*;
import com.bolife.blog.service.CommentService;
import com.bolife.blog.service.OptionsService;
import com.bolife.blog.util.ResultJSON;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * @author Mr.BoBo
 * @create 2020-07-31 15:45
 */
@Controller
@RequestMapping("/comment")
public class CommentController {
    @Autowired
    private CommentService commentService;

    @RequestMapping("/delete/{id}")
    public String deleteComment(@PathVariable("id") Integer id){
        commentService.deleteComment(id);
        return "redirect:/message";
    }

    @RequestMapping("/getAllComment")
    @ResponseBody
    public ResultJSON get(@RequestParam(required = false,defaultValue = "1")Integer page,
                         @RequestParam(required = false,defaultValue = "10")Integer limit){
        ResultJSON resultJSON = new ResultJSON();
        List<Comment> commentList = commentService.getAllComment((page-1)*limit,limit);
        Integer articleCountByShow = commentService.getCommentCount();
        resultJSON.setCode(0);
        resultJSON.setMsg("");
        resultJSON.setCount(articleCountByShow);
        resultJSON.setData(commentList);
        return resultJSON;
    }

    @RequestMapping("/del/{id}")
    @ResponseBody
    public ResultJSON delArticle(@PathVariable("id")Integer id){
        ResultJSON result = new ResultJSON();
        try{
            commentService.deleteComment(id);
            result.setCode(1);
        }catch(Exception e){
            result.setCode(0);
            result.setMsg("删除失败，请联系管理员");
        }
        return result;
    }
}
