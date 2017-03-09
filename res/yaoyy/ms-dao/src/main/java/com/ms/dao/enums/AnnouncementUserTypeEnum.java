package com.ms.dao.enums;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by kevin on 2017/3/3.
 */
public enum AnnouncementUserTypeEnum {

    SUPPLIER(1, "供应商"),
    PURCHASER(2, "用户"),
    ALL(0, "全部用户");

    private Integer key;
    private String value;

    AnnouncementUserTypeEnum(Integer key, String value){
        this.key = key;
        this.value = value;
    }

    private static Map<Integer, String> map;

    static {
        map = new HashMap<Integer, String>();
        for (AnnouncementUserTypeEnum obj: AnnouncementUserTypeEnum.values()) {
            map.put(obj.getKey(), obj.getValue());
        }
    }

    public static String get(Integer key){return map.get(key);}

    public Integer getKey(){ return key;}

    public String getValue(){return value;}

}
