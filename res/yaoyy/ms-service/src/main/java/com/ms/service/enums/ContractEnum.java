package com.ms.service.enums;

import com.ms.dao.enums.MsgIsMemberEnum;

import java.util.HashMap;
import java.util.Map;

/**
 * Author: kevin
 * 3/13/17.
 */
public enum ContractEnum {

    IS_CONTRACT(1, "已签合同"),
    IS_NOT_CONTRACT(0, "未签合同");

    private Integer key;
    private String value;

    ContractEnum(Integer key, String value){
        this.key = key;
        this.value = value;
    }

    private static Map<Integer, String> map;

    static {
        map = new HashMap<Integer, String>();
        for (ContractEnum contract:ContractEnum.values()) {
            map.put(contract.getKey(), contract.getValue());
        }
    }

    public static String get(Integer key){return map.get(key);}

    public Integer getKey(){ return key;}

    public String getValue(){return value;}
}
