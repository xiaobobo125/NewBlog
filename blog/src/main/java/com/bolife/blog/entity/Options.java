package com.bolife.blog.entity;

import lombok.Data;

import java.io.Serializable;

/**
* @author Mr.BoBo
* @description 网站信息
* @Date: 2020/5/4
*/
@Data
public class Options implements Serializable{
    private static final long serialVersionUID = -776792869602511933L;
    private Integer optionId;

    private String optionSiteTitle;

    private String optionSiteDescrption;

    private String optionMetaDescrption;

    private String optionMetaKeyword;

    private String optionAboutsiteAvatar;

    private String optionAboutsiteTitle;

    private String optionAboutsiteContent;

    private String optionAboutsiteWechat;

    private String optionAboutsiteQq;

    private String optionAboutsiteGithub;

    private String optionAboutsiteWeibo;

    private String optionViewTotal;

    private Integer optionStatus;

}