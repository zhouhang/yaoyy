package com.ms.dao;

import com.ms.dao.config.AutoMapper;
import com.ms.dao.model.ShippingAddress;
import com.ms.dao.vo.ShippingAddressVo;

import java.util.List;
@AutoMapper
public interface ShippingAddressDao extends ICommonDao<ShippingAddress>{

    public List<ShippingAddressVo> findByParams(ShippingAddressVo shippingAddressVo);

}
