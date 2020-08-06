package com.bolife.blog.service.impl;

import com.bolife.blog.entity.Diary;
import com.bolife.blog.mapper.DiaryMapper;
import com.bolife.blog.service.DiaryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author Mr.BoBo
 * @create 2020-07-30 16:57
 */
@Service
public class DiaryServiceIml implements DiaryService {
    @Autowired
    private DiaryMapper diaryMapper;
    @Override
    public List<Diary> getAllDiary() {
        return diaryMapper.findAllDiary();
    }

    @Override
    public void addDiary(String diary) {
        diaryMapper.insertDiary(diary);
    }
}
