package com.ms.service;

import com.github.pagehelper.PageInfo;
import com.ms.dao.model.Quotation;
import com.ms.dao.vo.QuotationVo;

public interface QuotationService extends ICommonService<Quotation>{

    public PageInfo<QuotationVo> findByParams(QuotationVo quotationVo,Integer pageNum,Integer pageSize);
}
