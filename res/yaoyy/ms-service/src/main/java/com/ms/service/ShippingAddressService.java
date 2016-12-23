package com.ms.service;

import com.github.pagehelper.PageInfo;
import com.ms.dao.model.ShippingAddress;
import com.ms.dao.vo.ShippingAddressVo;

public interface ShippingAddressService extends ICommonService<ShippingAddress>{

    public PageInfo<ShippingAddressVo> findByParams(ShippingAddressVo shippingAddressVo,Integer pageNum,Integer pageSize);
}
