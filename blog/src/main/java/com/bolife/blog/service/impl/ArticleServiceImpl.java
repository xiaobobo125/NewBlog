package com.bolife.blog.service.impl;

import cn.hutool.http.HtmlUtil;
import com.bolife.blog.entity.Article;
import com.bolife.blog.entity.Tag;
import com.bolife.blog.mapper.ArticleMapper;
import com.bolife.blog.service.ArticleService;
import com.bolife.blog.service.TagService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

/**
 * @author Mr.BoBo
 * @create 2020-07-29 17:14
 */
@Service
public class ArticleServiceImpl implements ArticleService {
    @Autowired
    private ArticleMapper articleMapper;

    @Autowired
    private TagService tagService;


    @Override
    public List<Article> getHotService(Integer count) {
        return articleMapper.findHotArticle(count);
    }

    @Override
    public List<Article> getAllArticle(Integer pageNum, Integer pageSize) {
        List<Article> allArticle = articleMapper.findAllArticle(pageNum, pageSize);
        for (Article article : allArticle) {
            Tag tag = tagService.getTagByArticleId(article.getArticleId());
            if(tag != null){
                article.setTag(tag);
            }else{
                article.setTag(new Tag("默认标签"));
            }
        }
        return allArticle;
    }

    @Override
    public Integer getArticleCountByShow() {
        return articleMapper.findArticleCountByShow();
    }

    @Override
    public List<Article> getReTopArticle(int count) {
        return articleMapper.fingReTopArticle(count);
    }

    @Override
    public Article getArticleById(Integer id) {
        return articleMapper.findArticleById(id);
    }

    @Override
    public List<Article> getArticlesByTagId(Integer id,Integer count) {
        Tag tagByArticleId = tagService.getTagByArticleId(id);
        if(tagByArticleId == null){
            List<Article> articleList = articleMapper.randomArticles(count);
            return articleList;
        }
        List<Article> articlesByTagId = articleMapper.findArticlesByTagId(tagByArticleId.getTagId(),count);
        if(articlesByTagId == null){
            List<Article> articleList = articleMapper.randomArticles(count);
            return articleList;
        }
        return articlesByTagId;
    }

    @Override
    public List<Article> getAllArticlesByTagId(Integer id, Integer pageNum, Integer pageSize) {
        Tag tagByArticleId = tagService.getTagByArticleId(id);
        if(tagByArticleId == null)
            return null;
        List<Article> allArticlesByTagId = articleMapper.findAllArticlesByTagId(id, pageNum, pageSize);
        for (Article article : allArticlesByTagId) {
            article.setTag(tagByArticleId);
        }
        return allArticlesByTagId;
    }

    @Override
    public Integer getAllArticlesByTagIdCount(Integer id) {
        return articleMapper.findAllArticlesByTagIdCount(id);
    }

    @Override
    public void deleteArticle(Integer id) {
        articleMapper.deleteArticle(id);
    }

    @Override
    public Integer insertArticle(Article article) {
        article.setArticleCreateTime(new Date());
        article.setArticleUpdateTime(new Date());
        article.setArticleCommentCount(0);
        article.setArticleLikeCount(0);
        article.setArticleViewCount(0);
        article.setArticleSummary(HtmlUtil.cleanHtmlTag(article.getArticleContent()));
       return articleMapper.insertArticle(article);
    }

    @Override
    public List<Article> getNearArticles(Integer count) {
        return articleMapper.findNearArticles(count);
    }

    @Override
    public void updateArticle(Article articleById) {
        articleMapper.updateArticle(articleById);
    }

}
