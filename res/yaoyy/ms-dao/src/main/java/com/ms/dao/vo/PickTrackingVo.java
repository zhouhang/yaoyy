package com.ms.dao.vo;

import com.ms.dao.enums.BizPickTrackingTypeEnum;
import com.ms.dao.enums.PickTrackingTypeEnum;
import com.ms.dao.model.PickTracking;

public class PickTrackingVo extends PickTracking{

    private String recordTypeText;

    private String bizRecordTypeText;//前端描述

    private String memberTel;//后端客服人员tel;

    public String getBizRecordTypeText() {
        return BizPickTrackingTypeEnum.findByValue(getRecordType());
    }

    public void setBizRecordTypeText(String bizRecordTypeText) {
        this.bizRecordTypeText = bizRecordTypeText;
    }

    public String getMemberTel() {
        return memberTel;
    }

    public void setMemberTel(String memberTel) {
        this.memberTel = memberTel;
    }

    public String getRecordTypeText() {
        return PickTrackingTypeEnum.findByValue(getRecordType());
    }

    public void setRecordTypeText(String recordTypeText) {
        this.recordTypeText = recordTypeText;
    }
}