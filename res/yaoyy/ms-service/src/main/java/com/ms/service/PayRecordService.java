package com.ms.service;

import com.github.pagehelper.PageInfo;
import com.ms.dao.model.PayRecord;
import com.ms.dao.vo.PayRecordVo;

public interface PayRecordService extends ICommonService<PayRecord>{

    public PageInfo<PayRecordVo> findByParams(PayRecordVo payRecordVo,Integer pageNum,Integer pageSize);
    public PayRecordVo findVoById(Integer id);
    public PayRecordVo findByOrderId(PayRecordVo payRecordVo);
}
