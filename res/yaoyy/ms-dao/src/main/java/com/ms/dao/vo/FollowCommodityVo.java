package com.ms.dao.vo;

import com.ms.dao.model.FollowCommodity;

public class FollowCommodityVo extends FollowCommodity{
    // 商品当前价格
    private Float currentPrice;

    // 商品title
    private String title;

    // 商品名称
    private String name;

    // 差价
    private Float difference;

    public Float getCurrentPrice() {
        return currentPrice;
    }

    public void setCurrentPrice(Float currentPrice) {
        this.currentPrice = currentPrice;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Float getDifference() {
        return currentPrice - getPrice();
    }

    public void setDifference(Float difference) {
        this.difference = difference;
    }
}