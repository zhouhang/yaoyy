package com.ms.service;

import com.github.pagehelper.PageInfo;
import com.ms.dao.model.SupplierCommodity;
import com.ms.dao.vo.SupplierCommodityVo;

public interface SupplierCommodityService extends ICommonService<SupplierCommodity>{

    public PageInfo<SupplierCommodityVo> findByParams(SupplierCommodityVo supplierCommodityVo,Integer pageNum,Integer pageSize);
}
