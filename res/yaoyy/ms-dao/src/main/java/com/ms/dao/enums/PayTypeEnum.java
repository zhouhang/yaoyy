package com.ms.dao.enums;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by xiao on 2016/12/26.
 */
public enum PayTypeEnum {


    OFFLINE_PAY(0,"线下转账"),
    ALIPAY(1,"支付宝支付"),
    WXPAY(2,"微信支付");

    private Integer type;
    private String value;

    PayTypeEnum(Integer type, String value){
        this.type = type;
        this.value = value;
    }

    private static Map<Integer, String> map;

    static {
        map = new HashMap<>();
        for (PayTypeEnum type : PayTypeEnum.values()) {
            map.put(type.getType(),type.getValue());
        }
    }

    /**
     * 通过ID来查询属性名称
     *
     * @param type
     * @return
     */
    public static String get(Integer type) {
        return map.get(type);
    }


    public Integer getType() {
        return type;
    }

    public String getValue() {
        return value;
    }
}
