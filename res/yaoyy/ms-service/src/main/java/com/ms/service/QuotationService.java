package com.ms.service;

import com.github.pagehelper.PageInfo;
import com.ms.dao.model.Quotation;
import com.ms.dao.vo.QuotationVo;

import java.util.List;

public interface QuotationService extends ICommonService<Quotation>{

    public PageInfo<QuotationVo> findByParams(QuotationVo quotationVo,Integer pageNum,Integer pageSize);

    public void save(QuotationVo quotationVo);


    /**
     * 获取最近的发布的10篇报价单
     * @return
     */
    public List<QuotationVo> recentList();

    /**
     * 获取最近发布的报价单
     * @return
     */
    public QuotationVo getRecent();
}
