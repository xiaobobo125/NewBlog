package com.bolife.blog.service.impl;

import com.bolife.blog.entity.Tag;
import com.bolife.blog.mapper.TagMapper;
import com.bolife.blog.service.TagService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author Mr.BoBo
 * @create 2020-07-30 10:21
 */
@Service
public class TagServiceImpl implements TagService {
    @Autowired
    private TagMapper tagMapper;
    @Override
    public Tag getTagByArticleId(Integer articleId) {
        return tagMapper.findTagByArticleId(articleId);
    }

    @Override
    public List<Tag> getAllTag() {
        List<Tag> allTag = tagMapper.findAllTag();
        for (Tag tag : allTag) {
            Integer tagCountArticle = tagMapper.findTagCountArticle(tag.getTagId());
            tag.setArticleCount(tagCountArticle);
        }
        return allTag;
    }


    @Override
    public void deleteArticleTagRef(Integer tagId, Integer articleId) {
        tagMapper.deleteArticleTagRef(tagId,articleId);
    }

    @Override
    public void insertArticleTagRef(Integer tagId, Integer articleId) {
        tagMapper.insertArticleTagRef(tagId,articleId);
    }

    @Override
    public Integer getTagCountArticle(Integer tagId) {
        return tagMapper.findTagCountArticle(tagId);
    }

    @Override
    public void insertTag(Tag tag) {
        tagMapper.insertTag(tag);
    }

    @Override
    public void deleteTag(Integer id) {
        tagMapper.deleteTag(id);
    }

    @Override
    public Tag getTagById(Integer id) {
        return tagMapper.findTagById(id);
    }

    @Override
    public void updateTag(Tag tag) {
        tagMapper.updateTag(tag);
    }
}
