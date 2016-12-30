package com.ms.dao;

import com.ms.dao.config.AutoMapper;
import com.ms.dao.model.ShippingAddressHistory;
import com.ms.dao.vo.ShippingAddressHistoryVo;

import java.util.List;
@AutoMapper
public interface ShippingAddressHistoryDao extends ICommonDao<ShippingAddressHistory>{

    public List<ShippingAddressHistoryVo> findByParams(ShippingAddressHistoryVo shippingAddressHistoryVo);

}
