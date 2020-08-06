package com.bolife.blog.controller;

import com.bolife.blog.entity.Notice;
import com.bolife.blog.entity.Options;
import com.bolife.blog.service.NoticeService;
import com.bolife.blog.service.OptionsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * @author Mr.BoBo
 * @create 2020-08-03 17:46
 */
@Controller
@RequestMapping("/notice")
public class NoticeController {

    @Autowired
    private NoticeService noticeService;

    @Autowired
    private OptionsService optionsService;

    @RequestMapping("/{id}")
    public String goNotice(@PathVariable("id")Integer id, Model model){
        Notice noticeById = noticeService.getNoticeById(id);
        Options options = optionsService.getOptions();
        model.addAttribute("options",options);
        model.addAttribute("linkDesc",noticeById);
        return "link";
    }

    @RequestMapping(value = "/insert")
    public String goInsert(){
        return "Admin/Notice/insert";
    }

    @RequestMapping(value = "/insertSubmit",method = RequestMethod.POST)
    public String insertSubmit(Notice notice){
        noticeService.insertNotice(notice);
        return "redirect:/admin/notice";
    }

    @RequestMapping("/edit/{id}")
    public String goEdit(@PathVariable("id")Integer id,Model model){
        Notice noticeById = noticeService.getNoticeById(id);
        model.addAttribute("notice",noticeById);
        return "Admin/Notice/edit";
    }
    @RequestMapping("/del/{id}")
    public String delNotice(@PathVariable("id")Integer id){
        noticeService.deleteNotice(id);
        return "redirect:/admin/notice";
    }

    @RequestMapping(value = "/editSubmit",method = RequestMethod.POST)
    public String updateSubmit(Notice notice){
        noticeService.updateNotice(notice);
        return "redirect:/admin/notice";
    }
}
