package com.ms.service;

import com.github.pagehelper.PageInfo;
import com.ms.dao.model.Payment;
import com.ms.dao.vo.PaymentVo;

public interface PaymentService extends ICommonService<Payment>{

    public PageInfo<PaymentVo> findByParams(PaymentVo paymentVo,Integer pageNum,Integer pageSize);
    public PaymentVo getByOutTradeNo(String outTradeNo);
}
