package com.ms.dao.vo;

import com.ms.dao.model.UserTrackRecord;

public class UserTrackRecordVo extends UserTrackRecord{

    public String getMember() {
        return member;
    }

    public void setMember(String member) {
        this.member = member;
    }

    private String member;

}