package com.bolife.blog.service;

import com.bolife.blog.entity.Tag;

import java.util.List;

/**
 * @author Mr.BoBo
 * @create 2020-07-30 10:20
 */
public interface TagService {
    Tag getTagByArticleId(Integer articleId);

    List<Tag> getAllTag();

    void deleteArticleTagRef(Integer tagId, Integer articleId);

    void insertArticleTagRef(Integer tagId, Integer articleId);

    Integer getTagCountArticle(Integer tagId);

    void insertTag(Tag tag);

    void deleteTag(Integer id);

    Tag getTagById(Integer id);

    void updateTag(Tag tag);
}
