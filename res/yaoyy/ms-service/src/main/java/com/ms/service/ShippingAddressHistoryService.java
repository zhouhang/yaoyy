package com.ms.service;

import com.github.pagehelper.PageInfo;
import com.ms.dao.model.ShippingAddressHistory;
import com.ms.dao.vo.ShippingAddressHistoryVo;

public interface ShippingAddressHistoryService extends ICommonService<ShippingAddressHistory>{

    public PageInfo<ShippingAddressHistoryVo> findByParams(ShippingAddressHistoryVo shippingAddressHistoryVo,Integer pageNum,Integer pageSize);
}
