package com.ms.dao.enums;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by xc on 2017/3/23.
 */
public enum OrgTypeEnum {

    PERSON(1,"个人主体"),
    COMPANY(2,"公司或者合作社");

    private Integer type;
    private String value;

    OrgTypeEnum(Integer type, String value){
        this.type = type;
        this.value = value;
    }

    private static Map<Integer, String> map;

    static {
        map = new HashMap<>();
        for (OrgTypeEnum type : OrgTypeEnum.values()) {
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
