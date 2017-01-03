package com.ms.dao;

import com.ms.dao.config.AutoMapper;
import com.ms.dao.model.Payment;
import com.ms.dao.vo.PaymentVo;

import java.util.List;
@AutoMapper
public interface PaymentDao extends ICommonDao<Payment>{

    public List<PaymentVo> findByParams(PaymentVo paymentVo);

    public PaymentVo getByOutTradeNo(String outTradeNo);

}
