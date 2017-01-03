package com.ms.service;

import com.github.pagehelper.PageInfo;
import com.ms.dao.model.PayRecord;
import com.ms.dao.vo.PayRecordVo;

public interface PayRecordService extends ICommonService<PayRecord>{

    public PageInfo<PayRecordVo> findByParams(PayRecordVo payRecordVo,Integer pageNum,Integer pageSize);
    public PayRecordVo findVoById(Integer id);
    //根据订单号查找
    public PayRecordVo findByOrderId(PayRecordVo payRecordVo);
    //根据账单号查找
    public PayRecordVo findByBillId(Integer billId);
    public PayRecordVo save(PayRecordVo payRecord);
}
