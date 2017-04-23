package com.ms.service;

import com.github.pagehelper.PageInfo;
import com.ms.dao.model.Article;
import com.ms.dao.model.ArticleTag;
import com.ms.dao.vo.ArticleTagVo;
import com.ms.dao.vo.ArticleVo;

import java.util.List;

public interface ArticleService extends ICommonService<Article>{

    PageInfo<ArticleVo> findByParams(ArticleVo articleVo,Integer pageNum,Integer pageSize);

    void changeStatus(Integer id, Integer status);

    Article save(Article article);

    /**
     * 头条文章保存修改
     * @param article
     * @return
     */
    Article createTouTiao(ArticleVo article);

    /**
     * CMS文章保存修改
     * @param article
     * @return
     */
    Article createCMS(Article article);

    /**
     * 查询所有的标签列表
     * @return
     */
    List<ArticleTagVo> tags();

    ArticleVo findVoById(Integer id);

    PageInfo<ArticleVo> headlinesList(ArticleVo articleVo,Integer pageNum,Integer pageSize);

    PageInfo<ArticleVo> headlinesListByTagId(Integer tagId,Integer pageNum,Integer pageSize);

    ArticleTag findTagByName(String name);

}
