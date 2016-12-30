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

    /**
     * 商品价格变动后更新关注的商品动态
     * @param commodityId
     * @return
     */
    Integer updateStatus(@Param("commodityId")Integer commodityId);

    /**
     * 修改用户关注商品状态为已读
     * @param userId
     * @return
     */
    Integer changeRead(Integer userId);
}
