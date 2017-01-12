package com.ms.service.enums;

/**
 * Author: koabs
 * 12/5/16.
 */
public enum  MessageEnum {

    // 用户 选货登记(微信), 客服受理订单(微信), 客服确认订单(微信,短信),客服确认发货(微信),用户确认收货(微信)
    // 客服 用户提交转账凭证,客户微信支付宝付款
    // 待加: 账期确认时, 修改订单时，账单支付，支付成功给客户发送支付成功微信
    PICK(0) ,// 选货登记(微信) 客服
    PICK_C(8) ,// 选货登记(微信) 用户
    SAMPLE(1),// 客户提交寄样申请 客服
    PICK_ACCEPT(2),// 客服受理订单(微信)
    PICK_CONFIRM(3),// 客服确认订单(微信,短信)
    PICK_DELIVERY(4), // 客服确认发货(微信)
    PICK_FINISH(5), // 用户确认收货(微信)
    PAY_BANK(6), //用户提交转账凭证 客服
    PAY_ONLINE(7), //客户微信支付宝付款(线上支付) 客服
    PAY_SUCCESS(9) // 支付宝支付成功回调,和客服后台确认转账信息有效
    ;
    private Integer value;
    MessageEnum(Integer value) {
        this.value = value;
    }

    public Integer get() {
        return value;
    }

    public static String getUrl(Integer type) {
        String url = "";
        switch (type){
            case 0: url = "/pick/detail/";
                break;
            case 1: url = "/sample/detail/";
                break;
            default:
                url = "";
                break;
        }
        return url;
    }
}
