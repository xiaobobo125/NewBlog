package com.bolife.blog.service.impl;

import com.bolife.blog.entity.Article;
import com.bolife.blog.entity.Comment;
import com.bolife.blog.entity.User;
import com.bolife.blog.mapper.ArticleMapper;
import com.bolife.blog.mapper.CommentMapper;
import com.bolife.blog.mapper.UserMapper;
import com.bolife.blog.service.CommentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.util.HtmlUtils;

import java.util.List;

/**
 * @author Mr.BoBo
 * @create 2020-07-31 9:58
 */
@Service
public class CommentServiceImpl implements CommentService {
    @Autowired
    private CommentMapper commentMapper;
    @Autowired
    private UserMapper userMapper;
    @Autowired
    private ArticleMapper articleMapper;
    @Override
    public List<Comment> getCommentByArticleId(Integer id) {
        List<Comment> commentByArticleId = commentMapper.findCommentByArticleId(id);
        for (Comment comment : commentByArticleId) {
            User userById = userMapper.findUserById(comment.getCommentUserId());
            comment.setCommentContent(HtmlUtils.htmlUnescape(comment.getCommentContent()));
            comment.setUser(userById);
        }
        return commentByArticleId;
    }

    @Override
    public void addComment(Comment comment) {
        commentMapper.insertComment(comment);
    }

    @Override
    public List<Comment> getComment() {
        List<Comment> commentByArticleId = commentMapper.findCommentByArticleId(0);
        for (Comment comment : commentByArticleId) {
            comment.setUser(userMapper.findUserById(comment.getCommentUserId()));
            comment.setCommentContent(HtmlUtils.htmlUnescape(comment.getCommentContent()));
        }
        return commentByArticleId;
    }

    @Override
    public void deleteComment(Integer id) {
        commentMapper.deleteComment(id);
    }

    @Override
    public List<Comment> getTopComment(int count) {
        List<Comment> commentList = commentMapper.findComment(count);
        for (Comment comment : commentList) {
            User userById = userMapper.findUserById(comment.getCommentUserId());
            comment.setUser(userById);
            Article articleById = articleMapper.findArticleById(comment.getCommentArticleId());
            comment.setArticle(articleById);
            comment.setCommentContent(HtmlUtils.htmlUnescape(comment.getCommentContent()));
        }
        return commentList;
    }

    @Override
    public List<Comment> getAllComment(int pageNum, Integer pageSize) {
        List<Comment> allComment = commentMapper.findAllComment(pageNum, pageSize);
        for (Comment comment : allComment) {
            comment.setCommentContent(HtmlUtils.htmlUnescape(comment.getCommentContent()));
            comment.setArticle(articleMapper.findArticleById(comment.getCommentArticleId()));
            comment.setUser(userMapper.findUserById(comment.getCommentUserId()));
        }
        return allComment;
    }

    @Override
    public Integer getCommentCount() {
        return commentMapper.findCommentCount();
    }

    @Override
    public Comment getCommentById(Integer id) {
        return commentMapper.findCommentById(id);
    }
}
