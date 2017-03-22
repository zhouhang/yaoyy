package com.ms.dao.enums;

import java.util.HashMap;
import java.util.Map;

/**
 * Author: kevin
 * 03/22/17.
 * 供应商状态
 */
public enum SupplierStatusEnum {
    UNVERIFY(0,"未核实"),
    VERIFY(1,"已核实"),
    VERIFY_NOT_PASS(2,"核实不通过"),
    INVEST(3,"已实地考察"),
    SIGN(4,"已签约");

    private Integer type;
    private String value;

    SupplierStatusEnum(Integer type, String value){
        this.type = type;
        this.value = value;
    }

    private static Map<Integer, String> map;

    static {
        map = new HashMap<>();
        for (SupplierStatusEnum type : SupplierStatusEnum.values()) {
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
