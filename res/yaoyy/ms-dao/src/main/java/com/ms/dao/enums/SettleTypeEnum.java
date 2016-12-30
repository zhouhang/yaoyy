package com.ms.dao.enums;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by xiao on 2016/12/27.
 */
public enum SettleTypeEnum {

    SETTLE_ALL(0,"全款"),
    SETTLE_DEPOSIT(1,"保证金"),
    SETTLE_BILL(2,"账期");

    private Integer type;
    private String value;

    SettleTypeEnum(Integer type, String value){
        this.type = type;
        this.value = value;
    }

    private static Map<Integer, String> map;

    static {
        map = new HashMap<>();
        for (SettleTypeEnum type : SettleTypeEnum.values()) {
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
