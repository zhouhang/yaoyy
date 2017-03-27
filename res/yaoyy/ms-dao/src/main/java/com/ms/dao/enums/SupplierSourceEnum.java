package com.ms.dao.enums;

import java.util.HashMap;
import java.util.Map;

/**
 * Author: kevin
 * 03/22/17.
 * 供应商来源
 */
public enum SupplierSourceEnum {
    SYSTEM(1,"系统录入"),
    HUQIAO(2,"沪谯导入"),
    TIANJI(3,"天济导入"),
    WECHART(4,"微信登记");

    private Integer type;
    private String value;

    SupplierSourceEnum(Integer type, String value){
        this.type = type;
        this.value = value;
    }

    private static Map<Integer, String> map;

    static {
        map = new HashMap<>();
        for (SupplierSourceEnum type : SupplierSourceEnum.values()) {
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
