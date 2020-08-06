package com.bolife.blog.service;

import com.bolife.blog.entity.Article;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @author Mr.BoBo
 * @create 2020-07-29 17:13
 */
public interface ArticleService {
    List<Article> getHotService(Integer count);

        List<Article> getAllArticle(Integer pageNum, Integer pageSize);

    Integer getArticleCountByShow();

    List<Article> getReTopArticle(int count);

    Article getArticleById(Integer id);

    List<Article> getArticlesByTagId(Integer id,Integer count);

    void updateArticle(Article articleById);

    List<Article> getAllArticlesByTagId(Integer id, Integer pageNum, Integer pageSize);

    Integer getAllArticlesByTagIdCount(Integer id);

    void deleteArticle(Integer id);

    Integer insertArticle(Article article);

    List<Article> getNearArticles(Integer count);
}
