package com.bolife.blog.mapper;

import com.bolife.blog.entity.Article;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @author Mr.BoBo
 * @create 2020-07-29 17:14
 */
@Mapper
public interface ArticleMapper {
    List<Article> findHotArticle(@Param("count") Integer count);

    List<Article> findAllArticle(@Param("pageNum") Integer pageNum,
                                 @Param("pageSize") Integer pageSize);

    Integer findArticleCountByShow();

    List<Article> fingReTopArticle(@Param("count") int count);

    Article findArticleById(@Param("id") Integer id);

    List<Article> findArticlesByTagId(@Param("id") Integer id,
                                      @Param("count") Integer count);

    List<Article> randomArticles(@Param("count") Integer count);

    void updateArticle(@Param("article") Article article);

    List<Article> findAllArticlesByTagId(@Param("id") Integer id,
                                         @Param("pageNum") Integer pageNum,
                                         @Param("pageSize") Integer pageSize);

    Integer findAllArticlesByTagIdCount(@Param("id") Integer id);

    void deleteArticle(@Param("id") Integer id);

    Integer insertArticle(@Param("article") Article article);

    List<Article> findNearArticles(@Param("count") Integer count);
}
