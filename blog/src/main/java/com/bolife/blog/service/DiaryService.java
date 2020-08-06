package com.bolife.blog.service;

import com.bolife.blog.entity.Diary;

import java.util.List;

/**
 * @author Mr.BoBo
 * @create 2020-07-30 16:57
 */
public interface DiaryService {
    List<Diary> getAllDiary();

    void addDiary(String diary);
}
