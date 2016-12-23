package com.ms.dao;

import com.ms.dao.config.AutoMapper;
import com.ms.dao.model.PayDocument;
import com.ms.dao.vo.PayDocumentVo;

import java.util.List;
@AutoMapper
public interface PayDocumentDao extends ICommonDao<PayDocument>{

    public List<PayDocumentVo> findByParams(PayDocumentVo payDocumentVo);

}
