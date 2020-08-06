package com.bolife.blog.mapper;

import com.bolife.blog.entity.Tag;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @author Mr.BoBo
 * @create 2020-07-30 10:30
 */
@Mapper
public interface TagMapper {
    Tag findTagByArticleId(@Param("articleId") Integer articleId);

    List<Tag> findAllTag();


    void deleteArticleTagRef(@Param("tagId") Integer tagId,
                             @Param("articleId") Integer articleId);

    void insertArticleTagRef(@Param("tagId") Integer tagId,
                             @Param("articleId") Integer articleId);

    Integer findTagCountArticle(@Param("tagId") Integer tagId);

    void insertTag(@Param("tag") Tag tag);

    void deleteTag(@Param("id") Integer id);

    Tag findTagById(@Param("id") Integer id);

    void updateTag(@Param("tag") Tag tag);
}
