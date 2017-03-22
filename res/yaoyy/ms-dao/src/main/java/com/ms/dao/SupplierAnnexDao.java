package com.ms.dao;

import com.ms.dao.config.AutoMapper;
import com.ms.dao.model.SupplierAnnex;
import com.ms.dao.vo.SupplierAnnexVo;

import java.util.List;
@AutoMapper
public interface SupplierAnnexDao extends ICommonDao<SupplierAnnex>{

    public List<SupplierAnnexVo> findByParams(SupplierAnnexVo supplierAnnexVo);

}
