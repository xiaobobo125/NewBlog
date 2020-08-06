package com.bolife.blog.mapper;

import com.bolife.blog.entity.ArticleLike;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

/**
 * @author Mr.BoBo
 * @create 2020-08-05 8:04
 */
@Mapper
public interface ArticleLikeMapper {
    ArticleLike findArticleLike(@Param("articleId") Integer articleId,
                                @Param("userId") Integer userId);

    Integer insertArticleLike(@Param("articleId") Integer articleId,
                              @Param("userId") Integer userId);
}
