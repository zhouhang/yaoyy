package com.ms.service;

import com.github.pagehelper.PageInfo;
import com.ms.dao.model.Supplier;
import com.ms.dao.vo.SupplierVo;

public interface SupplierService extends ICommonService<Supplier>{

    public PageInfo<SupplierVo> findByParams(SupplierVo supplierVo,Integer pageNum,Integer pageSize);

    public SupplierVo findVoById(Integer id);

    public void save(SupplierVo supplierVo);
}
