package com.ms.dao.enums;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by kevin on 2017/3/3.
 */
public enum MsgIsMemberEnum {

    IS_MEMBER(1, "后台管理员"),
    IS_NOT_MEMBER(0, "前台用户");

    private Integer key;
    private String value;

    MsgIsMemberEnum(Integer key, String value){
        this.key = key;
        this.value = value;
    }

    private static Map<Integer, String> map;

    static {
        map = new HashMap<Integer, String>();
        for (MsgIsMemberEnum isMember:MsgIsMemberEnum.values()) {
            map.put(isMember.getKey(), isMember.getValue());
        }
    }

    public static String get(Integer key){return map.get(key);}

    public Integer getKey(){ return key;}

    public String getValue(){return value;}

}
