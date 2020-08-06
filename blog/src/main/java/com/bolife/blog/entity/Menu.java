package com.bolife.blog.entity;

import lombok.Data;

import java.io.Serializable;

/**
* @author Mr.BoBo
* @description 菜单
* @Date: 2020/5/4
*/
@Data
public class Menu implements Serializable {
    private static final long serialVersionUID = 489914127235951698L;
    private Integer menuId;

    private String menuName;

    private String menuUrl;

    private Integer menuLevel;

    private String menuIcon;

    private Integer menuOrder;

}