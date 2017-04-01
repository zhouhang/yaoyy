package com.ms.service;

import com.github.pagehelper.PageInfo;
import com.ms.dao.model.SupplierCommodity;
import com.ms.dao.vo.SupplierCommodityVo;

import java.util.List;

public interface SupplierCommodityService extends ICommonService<SupplierCommodity>{

    public PageInfo<SupplierCommodityVo> findByParams(SupplierCommodityVo supplierCommodityVo,Integer pageNum,Integer pageSize);

    /**
     * 通过supplierId查询供应商经营的商品
     * @param supplierId
     * @return
     */
    public List<SupplierCommodityVo> findBySupplierId(Integer supplierId);

    public void save(SupplierCommodityVo supplierCommodityVo);

}
