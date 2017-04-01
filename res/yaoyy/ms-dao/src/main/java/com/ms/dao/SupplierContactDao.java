package com.ms.dao;

import com.ms.dao.config.AutoMapper;
import com.ms.dao.model.SupplierContact;
import com.ms.dao.vo.SupplierContactVo;

import java.util.List;
@AutoMapper
public interface SupplierContactDao extends ICommonDao<SupplierContact>{

    public List<SupplierContactVo> findByParams(SupplierContactVo supplierContactVo);

}
