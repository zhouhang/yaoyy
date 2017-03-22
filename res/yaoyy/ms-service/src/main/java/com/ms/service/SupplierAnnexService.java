package com.ms.service;

import com.github.pagehelper.PageInfo;
import com.ms.dao.model.SupplierAnnex;
import com.ms.dao.vo.SupplierAnnexVo;

public interface SupplierAnnexService extends ICommonService<SupplierAnnex>{

    public PageInfo<SupplierAnnexVo> findByParams(SupplierAnnexVo supplierAnnexVo,Integer pageNum,Integer pageSize);
}
