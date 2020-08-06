package com.bolife.blog.service;

import com.bolife.blog.entity.ArticleLike;

/**
 * @author Mr.BoBo
 * @create 2020-08-05 8:03
 */
public interface ArticleLikeService {
    ArticleLike getArticleLike(Integer id, Integer userId);

    Integer insertArticleLike(Integer id, Integer userId);
}
