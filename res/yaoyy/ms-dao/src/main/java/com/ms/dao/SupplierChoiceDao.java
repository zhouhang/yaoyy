package com.ms.dao;

import com.ms.dao.config.AutoMapper;
import com.ms.dao.model.SupplierChoice;
import com.ms.dao.vo.SupplierChoiceVo;

import java.util.List;
@AutoMapper
public interface SupplierChoiceDao extends ICommonDao<SupplierChoice>{

    public List<SupplierChoiceVo> findByParams(SupplierChoiceVo supplierChoiceVo);

}
