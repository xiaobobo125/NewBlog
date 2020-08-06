package com.bolife.blog.controller;

import com.bolife.blog.entity.Options;
import com.bolife.blog.entity.User;
import com.bolife.blog.service.OptionsService;
import com.bolife.blog.service.UserService;
import com.bolife.blog.util.ResultJSON;
import com.bolife.blog.util.SampleMail;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.List;

/**
 * @author Mr.BoBo
 * @create 2020-07-31 14:04
 */
@Controller
@RequestMapping("/user")
public class UserController {

    @Autowired
    private UserService userService;

    @Autowired
    private OptionsService optionsService;

    @RequestMapping("/login")
    public String userLogin(){
        return "Admin/login";
    }

    @RequestMapping("/admin")
    public String goAdmin(){
        return "Admin/index";
    }

    @RequestMapping("/getAllUser")
    @ResponseBody
    public ResultJSON get(@RequestParam(required = false,defaultValue = "1")Integer page,
                          @RequestParam(required = false,defaultValue = "10")Integer limit){
        ResultJSON resultJSON = new ResultJSON();
        List<User> userList = userService.getAllUser((page-1)*limit,limit);
        Integer userCount = userService.getUserCount();
        resultJSON.setCode(0);
        resultJSON.setMsg("");
        resultJSON.setCount(userCount);
        resultJSON.setData(userList);
        return resultJSON;
    }

    @RequestMapping("/del/{id}")
    @ResponseBody
    public ResultJSON deleteUser(@PathVariable("id")Integer id){
        ResultJSON result = new ResultJSON();
        try{
            userService.deleteUser(id);
            result.setCode(1);
        }catch(Exception e){
            result.setCode(0);
            result.setMsg("删除失败，请联系管理员");
        }
        return result;
    }

    @RequestMapping("/edit/{id}")
    public String editUser(@PathVariable("id")Integer id, Model model){
        User userById = userService.getUserById(id);
        model.addAttribute("user",userById);
        model.addAttribute("listStatus",5);
        return "Admin/User/edit";
    }

    @RequestMapping(value = "/editSubmit",method = RequestMethod.POST)
    public String editSubmit(User user){
        userService.updateUser(user);
        return "redirect:/admin/user";
    }
    @RequestMapping(value = "/insertSubmit",method = RequestMethod.POST)
    public String insertSubmit(User user){
        userService.insertUser(user);
        return "redirect:/admin/user";
    }

    @RequestMapping("/insert")
    public String insertUser(Model model) {
        Options options = optionsService.getOptions();
        model.addAttribute("options",options);
        model.addAttribute("listStatus",5);
        return "Admin/User/insert";
    }



    @RequestMapping("/info/{id}")
    public String userProfile(@PathVariable("id")Integer id,Model model){
        User userById = userService.getUserById(id);
        model.addAttribute("user",userById);
        return "Admin/User/profile";
    }

    @RequestMapping(value = "/username",method = RequestMethod.POST)
    @ResponseBody
    public ResultJSON username(String userName){
        ResultJSON resultJSON = new ResultJSON();
        User user = userService.getUserByUserName(userName);
        if(user != null){
            resultJSON.setCode(0);
            resultJSON.setMsg("用户名已经被注册");
            return resultJSON;
        }
        resultJSON.setCode(1);
        resultJSON.setMsg("用户名可用");
        return resultJSON;
    }
    @RequestMapping(value = "/email",method = RequestMethod.POST)
    @ResponseBody
    public ResultJSON email(String email){
        ResultJSON resultJSON = new ResultJSON();
        User user = userService.getUserByEmail(email);
        if(user != null){
            resultJSON.setCode(0);
            resultJSON.setMsg("邮箱已经被注册");
            return resultJSON;
        }
        resultJSON.setCode(1);
        resultJSON.setMsg("邮箱可用");
        return resultJSON;
    }

    @RequestMapping(value = "/regSubmit",method = RequestMethod.POST)
    @ResponseBody
    public ResultJSON regSubmit(User user){
        ResultJSON data = new ResultJSON();
        user.setUserStatus(3);
        Integer integer = userService.insertUser(user);
        if(integer == 0){
            data.setCode(0);
            data.setMsg("注册失败，请联系管理员！");
        }else{
            User userByEmail = userService.getUserByEmail(user.getUserEmail());
            if(userByEmail != null){
                new Thread(()->{
                    SampleMail.sendEmail(userByEmail);}).start();
            }
            data.setCode(1);
            data.setMsg("注册成功，请到邮箱进行激活！");
        }
        return data;
    }
    @RequestMapping("/userStatus/{id}")
    public String regEmail(@PathVariable("id")Integer id){
        User userById = userService.getUserById(id);
        userById.setUserStatus(2);
        userService.updateUser(userById);
        return "redirect:/login";
    }
    @RequestMapping(value = "/loginSubmit",method = RequestMethod.POST)
    @ResponseBody
    public ResultJSON loginSubmit(User user,String url, HttpServletRequest request){
        ResultJSON data = new ResultJSON();
        User userByUserName = userService.getUserByUserName(user.getUserName());
        if(userByUserName==null){
            data.setCode(0);
            data.setMsg("用户名错误，登陆失败！");
            return data;
        }
        if(!userByUserName.getUserPass().equals(user.getUserPass())){
           data.setCode(0);
           data.setMsg("密码错误，登陆失败！");
           return data;
        }
        if(userByUserName.getUserStatus() == 3){
            data.setCode(-1);
            data.setMsg("用户账户还未激活，请到邮箱激活后登陆！");
            return data;
        }
        request.getSession().setAttribute("userLogin",userByUserName);
        user.setUserLastLoginTime(new Date());
        userService.updateUser(user);
        data.setCode(1);
        data.setMsg("登陆成功！");
        return data;
    }

    @RequestMapping("/profile/{id}")
    public String goUserProfile(@PathVariable("id")Integer id,
                                Model model){
        Options options = optionsService.getOptions();
        User userById = userService.getUserById(id);
        model.addAttribute("user",userById);
        model.addAttribute("options",options);
        return "Admin/User/profile";
    }


}
