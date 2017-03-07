package com.ms.service;

import com.github.pagehelper.PageInfo;
import com.ms.dao.model.Supplier;
import com.ms.dao.vo.SupplierVo;

import java.util.List;

public interface SupplierService extends ICommonService<Supplier>{

    public PageInfo<SupplierVo> findByParams(SupplierVo supplierVo,Integer pageNum,Integer pageSize);

    public SupplierVo findVoById(Integer id);

    public void save(SupplierVo supplierVo);

    List<SupplierVo> search(String name);

    public PageInfo<SupplierVo> findVoByParams(SupplierVo supplierVo,Integer pageNum,Integer pageSize);
}
