package com.ms.dao.enums;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by kevin on 2017/3/7.
 */
public enum VarietyEnum {

    QUOTER(1, "花类"),
    PURCHASER(2, "根茎类"),
    ALL(3, "全草类"),
    LEAVE(4, "叶类"),
    TREE(5, "树皮类"),
    WOOD(6, "藤木类"),
    RESIN(7, "树脂类"),
    ALGAE(8, "菌藻类"),
    ANIMAL(9, "动物类"),
    MINERAL(10, "矿物类"),
    OTHER(11, "其他加工类"),
    SEED(12, "果实种子类");

    private Integer key;
    private String value;

    VarietyEnum(Integer key, String value){
        this.key = key;
        this.value = value;
    }

    private static Map<Integer, String> map;

    static {
        map = new HashMap<Integer, String>();
        for (VarietyEnum obj: VarietyEnum.values()) {
            map.put(obj.getKey(), obj.getValue());
        }
    }

    public static String get(Integer key){return map.get(key);}

    public Integer getKey(){ return key;}

    public String getValue(){return value;}

}
