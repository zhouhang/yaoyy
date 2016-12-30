package com.ms.dao;

import com.ms.dao.config.AutoMapper;
import com.ms.dao.model.ShippingAddress;
import com.ms.dao.vo.ShippingAddressVo;
import org.apache.ibatis.annotations.Param;

import java.util.List;
@AutoMapper
public interface ShippingAddressDao extends ICommonDao<ShippingAddress>{

    public List<ShippingAddressVo> findByParams(ShippingAddressVo shippingAddressVo);

    public void delete(@Param("userId")Integer userId, @Param("id") Integer addressId);

    public void updateAllNotDefault(Integer userId);

    /**
     * 根据用户id 查询用户送货地址数量
     * @param userId
     * @return
     */
    public Integer getCountByUserId(Integer userId);
}
