package com.bolife.blog.mapper;

import com.bolife.blog.entity.Options;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @author Mr.BoBo
 * @create 2020-07-29 16:36
 */
@Mapper
public interface OptionsMapper {
    List<Options> findOptions();

    void updateOptions(@Param("options") Options options);
}
