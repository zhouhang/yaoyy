package com.ms.dao.vo;

import com.ms.dao.enums.PickEnum;
import com.ms.dao.model.Pick;

/**
 * Author: koabs
 * 3/7/17.
 * 寄卖下单详情
 */
public class SupplierOrderVo extends Pick {

    private String supplierName;

    private String supplierTel;

    private String commodityName;

    private Integer pickCommodityId;

    // 商品价格
    private Float price;

    // 商品数量
    private Float num;

    // 商品
    private String unit;

    private String spec;

    private String batchInfo;

    private String statusText;


    public String getSupplierName() {
        return supplierName;
    }

    public void setSupplierName(String supplierName) {
        this.supplierName = supplierName;
    }

    public String getSupplierTel() {
        return supplierTel;
    }

    public void setSupplierTel(String supplierTel) {
        this.supplierTel = supplierTel;
    }

    public String getCommodityName() {
        return commodityName;
    }

    public void setCommodityName(String commodityName) {
        this.commodityName = commodityName;
    }

    public Float getPrice() {
        return price;
    }

    public void setPrice(Float price) {
        this.price = price;
    }

    public Float getNum() {
        return num;
    }

    public void setNum(Float num) {
        this.num = num;
    }

    public String getUnit() {
        return unit;
    }

    public void setUnit(String unit) {
        this.unit = unit;
    }

    public String getSpec() {
        return spec;
    }

    public void setSpec(String spec) {
        this.spec = spec;
    }

    public String getStatusText() {
        statusText = PickEnum.findByValue(getStatus());
        return statusText;
    }

    public Integer getPickCommodityId() {
        return pickCommodityId;
    }

    public void setPickCommodityId(Integer pickCommodityId) {
        this.pickCommodityId = pickCommodityId;
    }

    public String getBatchInfo() {
        return batchInfo;
    }

    public void setBatchInfo(String batchInfo) {
        this.batchInfo = batchInfo;
    }
}
