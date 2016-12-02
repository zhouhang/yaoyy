package com.ms.dao;

import com.ms.dao.config.AutoMapper;
import com.ms.dao.model.Quotation;
import com.ms.dao.vo.QuotationVo;

import java.util.List;
@AutoMapper
public interface QuotationDao extends ICommonDao<Quotation>{

    public List<QuotationVo> findByParams(QuotationVo quotationVo);

}
