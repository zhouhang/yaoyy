package com.ms.dao;

import com.ms.dao.config.AutoMapper;
import com.ms.dao.model.ArticleTag;
import com.ms.dao.vo.ArticleTagVo;

import java.util.List;
@AutoMapper
public interface ArticleTagDao extends ICommonDao<ArticleTag>{

    List<ArticleTagVo> findByParams(ArticleTagVo articleTagVo);

    ArticleTag findByName(String name);

}
