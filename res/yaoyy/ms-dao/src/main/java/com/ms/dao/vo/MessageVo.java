package com.ms.dao.vo;

import com.ms.dao.model.Message;

public class MessageVo extends Message{
    //跳转页面
    private String url;

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }
}