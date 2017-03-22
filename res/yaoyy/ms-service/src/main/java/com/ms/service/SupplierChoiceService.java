package com.ms.service;

import com.github.pagehelper.PageInfo;
import com.ms.dao.model.SupplierChoice;
import com.ms.dao.vo.SupplierChoiceVo;

public interface SupplierChoiceService extends ICommonService<SupplierChoice>{

    public PageInfo<SupplierChoiceVo> findByParams(SupplierChoiceVo supplierChoiceVo,Integer pageNum,Integer pageSize);
}
