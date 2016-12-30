package com.ms.dao.vo;

import com.ms.dao.model.HistoryPrice;

import java.util.Date;

public class HistoryPriceVo extends HistoryPrice{

    // 数据有效期
    private Date validityDate;

    public Date getValidityDate() {
        return validityDate;
    }

    public void setValidityDate(Date validityDate) {
        this.validityDate = validityDate;
    }
}