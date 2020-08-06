package com.bolife.blog.service;

import com.bolife.blog.entity.Article;
import com.bolife.blog.entity.Comment;

import java.util.List;

/**
 * @author Mr.BoBo
 * @create 2020-07-31 9:58
 */
public interface CommentService {
    List<Comment> getCommentByArticleId(Integer id);

    void addComment(Comment comment);

    List<Comment> getComment();

    void deleteComment(Integer id);

    List<Comment> getTopComment(int count);

    List<Comment> getAllComment(int pageNum, Integer pageSize);

    Integer getCommentCount();

    Comment getCommentById(Integer id);
}
