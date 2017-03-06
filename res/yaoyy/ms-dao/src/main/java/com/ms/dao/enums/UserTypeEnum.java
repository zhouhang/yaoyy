package com.ms.dao.enums;

import java.util.HashMap;
import java.util.Map;

/**
 * Author: koabs
 * 10/24/16.
 * 用户状态
 */
public enum UserTypeEnum {
    purchase(1,"采购商"),
    supplier(2,"供应商");

    private Integer type;
    private String value;

    UserTypeEnum(Integer type, String value){
        this.type = type;
        this.value = value;
    }

    private static Map<Integer, String> map;

    static {
        map = new HashMap<>();
        for (UserTypeEnum type : UserTypeEnum.values()) {
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
