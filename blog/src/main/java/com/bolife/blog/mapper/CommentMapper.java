package com.bolife.blog.mapper;

import com.bolife.blog.entity.Article;
import com.bolife.blog.entity.Comment;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @author Mr.BoBo
 * @create 2020-07-31 9:59
 */
@Mapper
public interface CommentMapper {
    List<Comment> findCommentByArticleId(@Param("id") Integer id);

    void insertComment(@Param("comment") Comment comment);

    void deleteComment(@Param("id") Integer id);

    List<Comment> findComment(@Param("count") Integer count);

    List<Comment> findAllComment(@Param("pageNum") int pageNum,
                                 @Param("pageSize") Integer pageSize);

    Integer findCommentCount();

    Comment findCommentById(@Param("id") Integer id);
}
