package com.bolife.blog.service.impl;

import com.bolife.blog.entity.ArticleLike;
import com.bolife.blog.mapper.ArticleLikeMapper;
import com.bolife.blog.service.ArticleLikeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @author Mr.BoBo
 * @create 2020-08-05 8:04
 */
@Service
public class ArticleLikeServiceImpl implements ArticleLikeService {
    @Autowired
    private ArticleLikeMapper articleLikeMapper;

    @Override
    public ArticleLike getArticleLike(Integer id, Integer userId) {
        return articleLikeMapper.findArticleLike(id,userId);
    }

    @Override
    public Integer insertArticleLike(Integer id, Integer userId) {
        return articleLikeMapper.insertArticleLike(id,userId);
    }
}
