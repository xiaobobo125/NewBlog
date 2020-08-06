package com.bolife.blog.mapper;

import com.bolife.blog.entity.Link;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @author Mr.BoBo
 * @create 2020-07-31 16:26
 */
@Mapper
public interface LinkMapper {

    List<Link> findAllLink();

    Link findLinkById(@Param("id") Integer id);

    void updateLink(@Param("link") Link link);

    void deleteLink(@Param("id") Integer id);

    void insertLink(@Param("link") Link link);
}
