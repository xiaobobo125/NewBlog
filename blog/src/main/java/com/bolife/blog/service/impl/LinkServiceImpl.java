package com.bolife.blog.service.impl;

import com.bolife.blog.entity.Link;
import com.bolife.blog.mapper.LinkMapper;
import com.bolife.blog.service.LinkService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

/**
 * @author Mr.BoBo
 * @create 2020-07-31 16:26
 */
@Service
public class LinkServiceImpl implements LinkService {
    @Autowired
    private LinkMapper linkMapper;
    @Override
    public List<Link> getAllLink() {
        return linkMapper.findAllLink();
    }

    @Override
    public Link getLinkById(Integer id) {
        return linkMapper.findLinkById(id);
    }

    @Override
    public void updateLink(Link link) {
        link.setLinkCreateTime(new Date());
        linkMapper.updateLink(link);
    }

    @Override
    public void deleteLink(Integer id) {
        linkMapper.deleteLink(id);
    }

    @Override
    public void insertLink(Link link) {
        link.setLinkCreateTime(new Date());
        linkMapper.insertLink(link);
    }
}
