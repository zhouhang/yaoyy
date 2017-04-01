package com.ms.dao.enums;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by xc on 2017/3/27.
 */
public enum UserTrackTypeEnum {
    GENERAL(0,"普通记录"),
    CERTIFY(1,"核实记录"),
    JUDGE(2,"认证记录"),
    SIGN(3,"签约记录");

    private Integer type;
    private String value;

    UserTrackTypeEnum(Integer type, String value){
        this.type = type;
        this.value = value;
    }

    private static Map<Integer, String> map;

    static {
        map = new HashMap<>();
        for (UserTrackTypeEnum type : UserTrackTypeEnum.values()) {
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
