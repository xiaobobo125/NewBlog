package com.bolife.blog.entity;

import lombok.Data;

import java.io.Serializable;
import java.util.Date;
import java.util.List;
import com.bolife.blog.entity.*;

/**
* @author Mr.BoBo
* @description 文章类
* @Date: 2020/5/4
*/
@Data
public class Article implements Serializable{

    private static final long serialVersionUID = 5207865247400761539L;

    private Integer articleId;

    private Integer articleUserId;

    private String articleTitle;

    private Integer articleViewCount;

    private Integer articleCommentCount;

    private Integer articleLikeCount;

    private Date articleCreateTime;

    private Date articleUpdateTime;

    private Integer articleIsComment;
    //0-草稿，1-发布，2-原创，3-转载
    private Integer articleStatus;
    //0-普通,1-置顶
    private Integer articleOrder;

    private String articleContent;

    private String articleSummary;

    private String articleImg;

    private User user;
    private Tag tag;
    private List<User> likeList;
}