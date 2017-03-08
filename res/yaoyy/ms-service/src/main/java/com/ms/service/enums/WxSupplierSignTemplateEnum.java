package com.ms.service.enums;

import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Author: kevin
 * 03/08/17.
 */
public enum WxSupplierSignTemplateEnum {

    TEMPLATEID("w4qh_kBaLdv07G6fdRaeRFzNhTsMhNbDOn2-lkfct-s") ,
    URL("") ,
    PARAM1_NAME("first"),
    PARAM1_VALUE("恭喜您，已成为药优优签约供应商"),
    PARAM1_COLOR("#FF00FF"),
    PARAM2_NAME("keyword1"),
    PARAM2_VALUE("药优优供应商审核结果"),
    PARAM2_COLOR("#FF00FF"),
    PARAM3_NAME("keyword2"),
    PARAM3_VALUE("审核通过"),
    PARAM3_COLOR("#FF00FF"),
    PARAM4_NAME("keyword3"),
    PARAM4_VALUE(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS").format(new Date())),
    PARAM4_COLOR("#FF00FF"),
    PARAM5_NAME("keyword4"),
    PARAM5_VALUE("您可以在药优优公众号左侧“供应商管理”菜单看到您的订单情况，以及对您的商品进行调价。" +
                     "第一次使用请用您的账号：{1}和密码：{2} 进行登录。"),
    PARAM5_COLOR("#FF00FF")
    ;
    private String value;
    WxSupplierSignTemplateEnum(String value) {
        this.value = value;
    }

    public String get() {
        return value;
    }


}
