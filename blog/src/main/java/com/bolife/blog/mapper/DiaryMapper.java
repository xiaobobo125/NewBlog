package com.bolife.blog.mapper;

import com.bolife.blog.entity.Diary;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @author Mr.BoBo
 * @create 2020-07-30 16:57
 */
@Mapper
public interface DiaryMapper {
    List<Diary> findAllDiary();

    void insertDiary(@Param("diary") String diary);
}
