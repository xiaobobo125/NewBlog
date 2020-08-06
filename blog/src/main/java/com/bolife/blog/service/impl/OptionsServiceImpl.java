package com.bolife.blog.service.impl;

import com.bolife.blog.entity.Options;
import com.bolife.blog.mapper.OptionsMapper;
import com.bolife.blog.service.OptionsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author Mr.BoBo
 * @create 2020-07-29 16:36
 */
@Service
public class OptionsServiceImpl implements OptionsService {
    @Autowired
    private OptionsMapper optionsMapper;

    @Override
    public Options getOptions() {
        List<Options> options = optionsMapper.findOptions();
        if(options != null){
            return options.get(0);
        }
        return null;
    }

    @Override
    public void updateOptions(Options options) {
        optionsMapper.updateOptions(options);
    }
}
