package com.bolife.blog.controller;

import com.bolife.blog.util.ResultJSON;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

/**
 * @author Mr.BoBo
 * @create 2020-08-03 8:03
 */

@Controller
@RequestMapping("/upload")
@Slf4j
public class UpLoadController {
    private final static String PATH="D:\\226\\Java\\study\\blog\\upload\\";
//    private final static String PATH="/usr/local/uploads/";
    public final String allowSuffix = ".bmp.jpg.jpeg.png.gif.pdf.doc.zip.rar.gz";

    @RequestMapping(value = "/image",method = RequestMethod.POST)
    @ResponseBody
    public ResultJSON uploadImage(@RequestParam(value = "file") MultipartFile image, HttpServletRequest request){
        ResultJSON result = new ResultJSON();
        Map<String,Object> data = new HashMap<>();
        String fileName = image.getOriginalFilename();
        //文件名,如spring
        String name = fileName.substring(0, fileName.indexOf("."));
        //文件后缀,如.jpeg
        String suffix = fileName.substring(fileName.lastIndexOf("."));
        if (allowSuffix.indexOf(suffix) == -1) {
            result.setMsg("上传文件类型错误！");
            result.setCode(0);
        }
        String newName = UUID.randomUUID().toString()+suffix;
        File file = new File(PATH+ newName);
        while (file.exists()){
            newName = UUID.randomUUID().toString()+suffix;
            file = new File(PATH+ newName);
        }
        try {
            image.transferTo(file);
        } catch (IOException e) {
            e.printStackTrace();
            log.error("上传文件失败："+e);
        }
        result.setCode(0);
        result.setMsg("上传文件成功！");
        data.put("src",request.getContextPath()+"/upload/"+newName);
        data.put("title",newName);
        result.setData(data);
        return result;
    }
}
