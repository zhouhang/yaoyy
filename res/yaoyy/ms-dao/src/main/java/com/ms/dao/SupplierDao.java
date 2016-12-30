package com.ms.dao;

import com.ms.dao.config.AutoMapper;
import com.ms.dao.model.Supplier;
import com.ms.dao.vo.SupplierVo;

import java.util.List;
@AutoMapper
public interface SupplierDao extends ICommonDao<Supplier>{

    public List<SupplierVo> findByParams(SupplierVo supplierVo);

    public SupplierVo findVoById(Integer id);


}
