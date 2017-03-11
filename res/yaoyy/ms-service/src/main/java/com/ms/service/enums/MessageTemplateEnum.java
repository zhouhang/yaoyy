package com.ms.service.enums;

/**
 * Author: kevin
 * 3/11/17.
 */
public enum MessageTemplateEnum {

    //商品类  修改价格和库存
    SUPPLIER_COMMODITY_PRICE_TEMPLATE("{name}修改了 商品（{commodity} {spec}） 价格 {pre_price}元/公斤更改为{price}元/公斤"),
    SUPPLIER_COMMODITY_STOCK_TEMPLATE("{name}修改了 商品（{commodity} {spec}） 库存 {pre_stock}公斤更改为{stock}公斤"),

    //寄养类
    SUPPLIER_SAMPLE_TEMPLATE("客服 {name}  为你发出了 商品（{commodity}） 的样品"),

    //订单
    SUPPLIER_ORDER_TEMPLATE("商品（{commodity}）产生了一笔订单")
    ;
    private String value;
    MessageTemplateEnum(String value) {
        this.value = value;
    }

    public String get() {
        return value;
    }

}
