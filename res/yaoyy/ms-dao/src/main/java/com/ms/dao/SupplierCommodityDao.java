package com.ms.dao;

import com.ms.dao.config.AutoMapper;
import com.ms.dao.model.SupplierCommodity;
import com.ms.dao.vo.SupplierCommodityVo;

import java.util.List;
@AutoMapper
public interface SupplierCommodityDao extends ICommonDao<SupplierCommodity>{

    public List<SupplierCommodityVo> findByParams(SupplierCommodityVo supplierCommodityVo);

}
