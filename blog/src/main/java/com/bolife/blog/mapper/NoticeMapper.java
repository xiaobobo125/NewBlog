package com.bolife.blog.mapper;

import com.bolife.blog.entity.Notice;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @author Mr.BoBo
 * @create 2020-07-31 16:31
 */
@Mapper
public interface NoticeMapper {
    Notice findNoticeById(@Param("id") int id);

    List<Notice> findAllNotice();

    Integer insertNotice(@Param("notice") Notice notice);

    void updateNotice(@Param("notice") Notice notice);

    void deleteNotice(@Param("id") Integer id);
}
