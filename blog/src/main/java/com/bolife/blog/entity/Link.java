package com.bolife.blog.entity;

import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
* @author Mr.BoBo
* @description 友情链接
* @Date: 2020/5/4
*/
@Data
public class Link  implements Serializable{


    private static final long serialVersionUID = -259829372268790508L;

    private Integer linkId;

    private String linkUrl;

    private String linkName;

    private String linkImage;

    private String linkDescription;

    private Date linkCreateTime;

    private Integer linkOrder;

    private Integer linkStatus;

}