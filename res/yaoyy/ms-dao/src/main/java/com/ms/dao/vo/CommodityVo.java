package com.ms.dao.vo;

import com.ms.dao.model.Commodity;
import com.ms.dao.model.Gradient;

import java.util.List;

public class CommodityVo extends Commodity{

    // 品种名
    private String categoryName;

    // 单位名称
    private String unitName;

    // 量大价优价格梯度
    private List<Gradient> gradient;

    // 用户是否关注
    private Boolean watch = false;

    // 供应商名称
    private String supplierName;

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public List<Gradient> getGradient() {
        return gradient;
    }

    public void setGradient(List<Gradient> gradient) {
        this.gradient = gradient;
    }

    public String getUnitName() {
        return unitName;
    }

    public void setUnitName(String unitName) {
        this.unitName = unitName;
    }

    public Boolean getWatch() {
        return watch;
    }

    public void setWatch(Boolean watch) {
        this.watch = watch;
    }

    public String getSupplierName() {
        return supplierName;
    }

    public void setSupplierName(String supplierName) {
        this.supplierName = supplierName;
    }
}