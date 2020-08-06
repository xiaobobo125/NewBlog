package com.bolife.blog.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

/**
* @author Mr.BoBo
* @description 文章点赞关联表
* @Date: 2020/5/4
*/
@Data
public class ArticleLike implements Serializable{

    private static final long serialVersionUID = -6809206515467725995L;

    private Integer articleId;

    private Integer userId;

    public ArticleLike() {
    }

    public ArticleLike(Integer articleId, Integer userId) {
        this.articleId = articleId;
        this.userId = userId;
    }
}