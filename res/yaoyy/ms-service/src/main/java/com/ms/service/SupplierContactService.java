package com.ms.service;

import com.github.pagehelper.PageInfo;
import com.ms.dao.model.SupplierContact;
import com.ms.dao.vo.SupplierContactVo;

public interface SupplierContactService extends ICommonService<SupplierContact>{

    public PageInfo<SupplierContactVo> findByParams(SupplierContactVo supplierContactVo,Integer pageNum,Integer pageSize);
}
