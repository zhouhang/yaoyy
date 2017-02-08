package com.ms.service;

import com.github.pagehelper.PageInfo;
import com.ms.dao.model.QuoteFeed;
import com.ms.dao.vo.QuoteFeedVo;

public interface QuoteFeedService extends ICommonService<QuoteFeed>{

    public PageInfo<QuoteFeedVo> findByParams(QuoteFeedVo quoteFeedVo,Integer pageNum,Integer pageSize);
}
