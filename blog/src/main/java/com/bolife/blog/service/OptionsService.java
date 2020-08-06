package com.bolife.blog.service;

import com.bolife.blog.entity.Options;

import javax.swing.text.html.Option;

/**
 * @author Mr.BoBo
 * @create 2020-07-29 16:36
 */
public interface OptionsService {
    Options getOptions();

    void updateOptions(Options options);
}
