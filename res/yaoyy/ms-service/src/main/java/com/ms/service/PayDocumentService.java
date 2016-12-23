package com.ms.service;

import com.github.pagehelper.PageInfo;
import com.ms.dao.model.PayDocument;
import com.ms.dao.vo.PayDocumentVo;

public interface PayDocumentService extends ICommonService<PayDocument>{

    public PageInfo<PayDocumentVo> findByParams(PayDocumentVo payDocumentVo,Integer pageNum,Integer pageSize);
}
