package com.ms.service;

import com.github.pagehelper.PageInfo;
import com.ms.dao.model.SupplierChoice;
import com.ms.dao.vo.SupplierChoiceVo;

import java.util.List;

public interface SupplierChoiceService extends ICommonService<SupplierChoice>{

    public PageInfo<SupplierChoiceVo> findByParams(SupplierChoiceVo supplierChoiceVo,Integer pageNum,Integer pageSize);

    /**
     * 根据supplierid查询
     * @return
     */
    public List<SupplierChoiceVo> findBySupplierId(Integer supplierId);


    public void save(SupplierChoiceVo supplierChoiceVo);

    public void deleteBySupplierId(Integer supplierId);
}
