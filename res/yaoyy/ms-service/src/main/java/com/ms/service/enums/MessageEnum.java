package com.ms.service.enums;

/**
 * Author: koabs
 * 12/5/16.
 */
public enum  MessageEnum {

    PICK(0),SAMPLE(1);
    private Integer value;
    MessageEnum(Integer value) {
        this.value = value;
    }

    public Integer get() {
        return value;
    }

    public static String getUrl(Integer type) {
        String url = "";
        switch (type){
            case 0: url = "/pick/detail/";
                break;
            case 1: url = "/sample/detail/";
                break;
            default: break;
        }
        return url;
    }
}
