package com.bolife.blog.service;

import com.bolife.blog.entity.Notice;

import java.util.List;

/**
 * @author Mr.BoBo
 * @create 2020-07-31 16:30
 */
public interface NoticeService {

    List<Notice> getAllNotice();

    Notice getNoticeById(Integer id);

    Integer insertNotice(Notice notice);

    void updateNotice(Notice notice);

    void deleteNotice(Integer id);
}
