package com.ms.dao.vo;

import com.ms.dao.model.Category;

public class CategoryVo extends Category{

    private String parentName;

    private Integer defaultCommodityId;

    private Float defaultCommodityPrice;

    private String defaultCommodityUnitName;


    public String getParentName() {
        return parentName;
    }

    public void setParentName(String parentName) {
        this.parentName = parentName;
    }

    public Integer getDefaultCommodityId() {
        return defaultCommodityId;
    }

    public void setDefaultCommodityId(Integer defaultCommodityId) {
        this.defaultCommodityId = defaultCommodityId;
    }

    public Float getDefaultCommodityPrice() {
        return defaultCommodityPrice;
    }

    public void setDefaultCommodityPrice(Float defaultCommodityPrice) {
        this.defaultCommodityPrice = defaultCommodityPrice;
    }

    public String getDefaultCommodityUnitName() {
        return defaultCommodityUnitName;
    }

    public void setDefaultCommodityUnitName(String defaultCommodityUnitName) {
        this.defaultCommodityUnitName = defaultCommodityUnitName;
    }
}