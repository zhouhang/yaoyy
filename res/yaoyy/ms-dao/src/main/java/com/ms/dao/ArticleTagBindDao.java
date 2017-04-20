package com.ms.dao;

import com.ms.dao.config.AutoMapper;
import com.ms.dao.model.ArticleTagBind;
import com.ms.dao.vo.ArticleTagBindVo;

import java.util.List;
@AutoMapper
public interface ArticleTagBindDao extends ICommonDao<ArticleTagBind>{

    List<ArticleTagBindVo> findByParams(ArticleTagBindVo articleTagBindVo);

    /**
     * 根据文章ID 删除与Tag 的绑定关系
     * @param articleId
     * @return
     */
    Integer deleteByArticleId(Integer articleId);

    String findTagsByArticleId(Integer articleId);
}
