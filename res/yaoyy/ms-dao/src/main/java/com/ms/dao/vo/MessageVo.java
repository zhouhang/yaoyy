package com.ms.dao.vo;

import com.ms.dao.model.Message;

import java.util.List;

public class MessageVo extends Message{
    //跳转页面
    private String url;

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    private List<Integer> types;

    public List<Integer> getTypes() {
        return types;
    }

    public void setTypes(List<Integer> Types) {
        this.types = types;
    }

    public String typeName;

    public String getTypeName() {return typeName;}

    public void setTypeName(String typeName) {this.typeName = typeName;}

}