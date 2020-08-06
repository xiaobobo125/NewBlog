package com.bolife.blog.service;

import com.bolife.blog.entity.Link;

import java.util.List;

/**
 * @author Mr.BoBo
 * @create 2020-07-31 16:26
 */
public interface LinkService {
    List<Link> getAllLink();

    Link getLinkById(Integer id);

    void updateLink(Link link);

    void deleteLink(Integer id);

    void insertLink(Link link);
}
