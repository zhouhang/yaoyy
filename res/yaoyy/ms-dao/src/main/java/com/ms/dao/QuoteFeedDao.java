package com.ms.dao;

import com.ms.dao.config.AutoMapper;
import com.ms.dao.model.QuoteFeed;
import com.ms.dao.vo.QuoteFeedVo;

import java.util.List;
@AutoMapper
public interface QuoteFeedDao extends ICommonDao<QuoteFeed>{

    public List<QuoteFeedVo> findByParams(QuoteFeedVo quoteFeedVo);

}
