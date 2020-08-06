package com.bolife.blog.controller;

import com.bolife.blog.entity.Link;
import com.bolife.blog.entity.Options;
import com.bolife.blog.service.LinkService;
import com.bolife.blog.service.OptionsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import java.util.List;

/**
 * @author Mr.BoBo
 * @create 2020-08-03 11:19
 */
@Controller
@RequestMapping("/link")
public class LinkController {

    @Autowired
    private LinkService linkService;

    @Autowired
    private OptionsService optionsService;

    @RequestMapping("/edit/{id}")
    public String edit(@PathVariable("id")Integer id,
                        Model model){
        Link link = linkService.getLinkById(id);
        List<Link> allLink = linkService.getAllLink();
        model.addAttribute("linkList",allLink);
        model.addAttribute("link",link);
        return "Admin/Link/edit";
    }

    @RequestMapping(value = "/editSubmit",method = RequestMethod.POST)
    public String editLink(Link link){
        linkService.updateLink(link);
        return "redirect:/admin/link";
    }
    @RequestMapping("/delete/{id}")
    public String deleteLink(@PathVariable("id")Integer id){
        linkService.deleteLink(id);
        return "redirect:/admin/link";
    }

    @RequestMapping("/insert")
    public String insertLink(Model model){
        List<Link> allLink = linkService.getAllLink();
        Options options = optionsService.getOptions();
        model.addAttribute("options",options);
        model.addAttribute("linkList",allLink);
        model.addAttribute("listStatus",3);
        return "Admin/Link/insert";
    }

    @RequestMapping(value = "/insertSubmit",method = RequestMethod.POST)
    public String insertLinkSubmit(Link link){
        linkService.insertLink(link);
        return "redirect:/admin/link";
    }
}
