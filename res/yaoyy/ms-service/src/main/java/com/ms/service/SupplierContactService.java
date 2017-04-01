package com.ms.service;

import com.github.pagehelper.PageInfo;
import com.ms.dao.model.SupplierContact;
import com.ms.dao.vo.SupplierContactVo;

import java.util.List;

public interface SupplierContactService extends ICommonService<SupplierContact>{

    public PageInfo<SupplierContactVo> findByParams(SupplierContactVo supplierContactVo,Integer pageNum,Integer pageSize);

    public List<SupplierContactVo>  findBySupplierId(Integer supplierId);

    public void save(SupplierContactVo supplierContactVo);
}
