package com.ms.service;

import com.github.pagehelper.PageInfo;
import com.ms.dao.model.PayDocument;
import com.ms.dao.vo.PayDocumentVo;

import java.util.List;

public interface PayDocumentService extends ICommonService<PayDocument>{

    public PageInfo<PayDocumentVo> findByParams(PayDocumentVo payDocumentVo,Integer pageNum,Integer pageSize);

    public List<PayDocumentVo> findByParams(PayDocumentVo payDocumentVo);

    public void deleteByRecordId(Integer recordId);
}
