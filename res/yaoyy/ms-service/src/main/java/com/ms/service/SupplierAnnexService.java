package com.ms.service;

import com.github.pagehelper.PageInfo;
import com.ms.dao.model.SupplierAnnex;
import com.ms.dao.vo.SupplierAnnexVo;

import java.util.List;

public interface SupplierAnnexService extends ICommonService<SupplierAnnex>{

    public PageInfo<SupplierAnnexVo> findByParams(SupplierAnnexVo supplierAnnexVo,Integer pageNum,Integer pageSize);

    public List<SupplierAnnexVo> findBySupplierId(Integer supplierId);

    public void save(SupplierAnnexVo supplierAnnexVo);

    public void deleteBySupplierId(Integer supplierId);
}
