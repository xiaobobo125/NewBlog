package com.bolife.blog.controller;


import com.bolife.blog.entity.Diary;
import com.bolife.blog.service.DiaryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.util.HtmlUtils;

@Controller
@RequestMapping("/diary")
public class DiaryController {
    @Autowired
    private DiaryService diaryService;
    @RequestMapping(value = "/addDiary",method = RequestMethod.POST)
    public String addDiary(Diary diary, Model model){
        diaryService.addDiary(HtmlUtils.htmlEscape(diary.getDiaryContent()));
        return "redirect:/admin";
    }
}
