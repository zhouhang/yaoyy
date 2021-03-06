package com.ms.dao.vo;

import com.ms.dao.model.ShippingAddress;

public class ShippingAddressVo extends ShippingAddress{
    // 省份ID
    private Integer provinceId;

    // 区域ID
    private Integer cityId;

    //地址全称
    private String fullAdd;

    public Integer getProvinceId() {
        return provinceId;
    }

    public void setProvinceId(Integer provinceId) {
        this.provinceId = provinceId;
    }

    public Integer getCityId() {
        return cityId;
    }

    public void setCityId(Integer cityId) {
        this.cityId = cityId;
    }

    public String getFullAdd() {
        return fullAdd;
    }

    public void setFullAdd(String fullAdd) {
        this.fullAdd = fullAdd;
    }
}