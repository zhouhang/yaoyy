package com.ms.service;

import com.github.pagehelper.PageInfo;
import com.ms.dao.model.FollowCommodity;
import com.ms.dao.vo.FollowCommodityVo;

public interface FollowCommodityService extends ICommonService<FollowCommodity>{

    public PageInfo<FollowCommodityVo> findByParams(FollowCommodityVo followCommodityVo,Integer pageNum,Integer pageSize);
}
