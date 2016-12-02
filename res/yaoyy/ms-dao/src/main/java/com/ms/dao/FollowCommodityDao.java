package com.ms.dao;

import com.ms.dao.config.AutoMapper;
import com.ms.dao.model.FollowCommodity;
import com.ms.dao.vo.FollowCommodityVo;

import java.util.List;
@AutoMapper
public interface FollowCommodityDao extends ICommonDao<FollowCommodity>{

    public List<FollowCommodityVo> findByParams(FollowCommodityVo followCommodityVo);

}
