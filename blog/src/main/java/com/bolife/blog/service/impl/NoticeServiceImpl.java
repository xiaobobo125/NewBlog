package com.bolife.blog.service.impl;

import com.bolife.blog.entity.Notice;
import com.bolife.blog.mapper.NoticeMapper;
import com.bolife.blog.service.NoticeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.util.HtmlUtils;

import java.util.List;

/**
 * @author Mr.BoBo
 * @create 2020-07-31 16:30
 */
@Service
public class NoticeServiceImpl implements NoticeService {
    @Autowired
    private NoticeMapper noticeMapper;
    @Override
    public Notice getNoticeById(Integer id) {
        Notice noticeById = noticeMapper.findNoticeById(id);
        noticeById.setNoticeContent(HtmlUtils.htmlUnescape(noticeById.getNoticeContent()));
        return noticeById;
    }

    @Override
    public Integer insertNotice(Notice notice) {
        notice.setNoticeContent(HtmlUtils.htmlEscape(notice.getNoticeContent()));
        return noticeMapper.insertNotice(notice);
    }

    @Override
    public void updateNotice(Notice notice) {
        notice.setNoticeContent(HtmlUtils.htmlEscape(notice.getNoticeContent()));
        noticeMapper.updateNotice(notice);
    }

    @Override
    public void deleteNotice(Integer id) {
        noticeMapper.deleteNotice(id);
    }

    @Override
    public List<Notice> getAllNotice() {
        List<Notice> allNotice = noticeMapper.findAllNotice();
        for (Notice notice : allNotice) {
            notice.setNoticeContent(HtmlUtils.htmlUnescape(notice.getNoticeContent()));
        }
        return allNotice;
    }
}
