package com.ms.dao.vo;

import com.ms.dao.enums.AnnouncementUserTypeEnum;
import com.ms.dao.model.Announcement;

import java.util.List;

public class AnnouncementVo extends Announcement{

    private String userTypeName;

    public String getUserTypeName() {
        return AnnouncementUserTypeEnum.get(super.getUserType());
    }

    public void setUserTypeName(Integer userType) {
        this.userTypeName = userTypeName;
    }

    private List<Integer> userTypes;

    public List<Integer> getUserTypes() {
        return userTypes;
    }

    public void setUserTypes(List<Integer> userTypes) {
        this.userTypes = userTypes;
    }

}