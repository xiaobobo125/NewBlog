package com.bolife.blog.entity;

import lombok.Data;

import java.util.Date;

/**
 * @author Mr.BoBo
 * @create 2020-07-30 16:56
 */
@Data
public class Diary {
    private Integer diaryId;
    private String diaryContent;
    private Date diaryCreateTime;
    private Integer diaryUserId;
    private User user;
}
