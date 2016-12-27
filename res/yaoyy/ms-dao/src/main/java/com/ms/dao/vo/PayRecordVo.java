package com.ms.dao.vo;

import com.ms.dao.enums.PayTypeEnum;
import com.ms.dao.model.PayDocument;
import com.ms.dao.model.PayRecord;

import java.util.Date;
import java.util.List;

public class PayRecordVo extends PayRecord{

    private String payTypeText;

    private String phone;

    private String nickname;

    private String name;

    private Date  startDate;

    private Date endDate;

    private String memberName;


    private List<PayDocumentVo> payDocuments;

    public List<PayDocumentVo> getPayDocuments() {
        return payDocuments;
    }

    public void setPayDocuments(List<PayDocumentVo> payDocuments) {
        this.payDocuments = payDocuments;
    }

    public String getMemberName() {
        return memberName;
    }

    public void setMemberName(String memberName) {
        this.memberName = memberName;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    public String getPayTypeText() {
        return PayTypeEnum.get(getPayType());
    }

    public void setPayTypeText(String payTypeText) {
        this.payTypeText = payTypeText;
    }
}