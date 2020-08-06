package com.bolife.blog.entity;

import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
* @author Mr.BoBo
* @description 文章评论
* @Date: 2020/5/4
*/
@Data
public class Comment implements Serializable{

    private static final long serialVersionUID = -1038897351672911219L;
    private Integer commentId;

    private Integer commentPid;

    private String commentPname;

    private Integer commentArticleId;

    private Integer commentUserId;

    private String commentContent;

    private Date commentCreateTime;

    /**
     * 角色(管理员1，访客0)
     */
    private Integer commentRole;

    /**
     * 非数据库字段
     */
    private Article article;

    private User user;

}