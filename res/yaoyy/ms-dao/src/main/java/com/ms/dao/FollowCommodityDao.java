package com.ms.dao;

import com.ms.dao.config.AutoMapper;
import com.ms.dao.model.FollowCommodity;
import com.ms.dao.vo.FollowCommodityVo;
import org.apache.ibatis.annotations.Param;

import java.util.List;
@AutoMapper
public interface FollowCommodityDao extends ICommonDao<FollowCommodity>{

    public List<FollowCommodityVo> findByParams(FollowCommodityVo followCommodityVo);

    Integer count(Integer userId);

    void unwatch(@Param("followId") Integer followId, @Param("commodityId") Integer commodityId, @Param("userId") Integer userId);
}
