package com.bolife.blog.controller;

import com.bolife.blog.entity.Options;
import com.bolife.blog.service.OptionsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * @author Mr.BoBo
 * @create 2020-08-03 16:37
 */
@Controller
@RequestMapping("/options")
public class OptionsController {
    @Autowired
    private OptionsService optionsService;

    @RequestMapping("/editSubmit")
    public String options(Options options){
        optionsService.updateOptions(options);
        return "redirect:/admin/options";
    }
}
