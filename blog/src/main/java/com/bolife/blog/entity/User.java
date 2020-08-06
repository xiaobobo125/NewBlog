package com.bolife.blog.entity;

import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
* @author Mr.BoBo
* @description 用户实体类
* @Date: 2020/5/4
*/
@Data
public class User implements Serializable{
    private static final long serialVersionUID = -4415517704211731385L;
    private Integer userId;

    private String userName;

    private String userPass;

    private String userNickname;

    private String userEmail;

    private String userUrl;

    private String userAvatar;

    private String userLastLoginIp;

    private Date userRegisterTime;

    private Date userLastLoginTime;

    private Integer userStatus;

    private Integer articleCount;

}