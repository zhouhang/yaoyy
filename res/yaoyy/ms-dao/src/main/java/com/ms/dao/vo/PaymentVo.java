package com.ms.dao.vo;

import com.ms.dao.model.Payment;

public class PaymentVo extends Payment{

    private String payAppId;

    public String getPayAppId() {
        return payAppId;
    }

    public void setPayAppId(String payAppId) {
        this.payAppId = payAppId;
    }
}