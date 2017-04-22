package com.ms.dao;

import com.ms.dao.config.AutoMapper;
import com.ms.dao.model.Article;
import com.ms.dao.vo.ArticleVo;

import java.util.List;
@AutoMapper
public interface ArticleDao extends ICommonDao<Article>{

    List<ArticleVo> findByParams(ArticleVo articleVo);

    List<ArticleVo> headlinesListByTagId(Integer tagId);
}
