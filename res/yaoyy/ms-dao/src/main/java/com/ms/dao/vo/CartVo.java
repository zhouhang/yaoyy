package com.ms.dao.vo;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by wangbin on 2017/4/22.
 */
public class CartVo implements Serializable {

    private static final long serialVersionUID = 1L;

    private Integer supplierId;

    private String supplierName;

    private String supplierCompany;

    List<CommodityVo> commodities = new ArrayList<>();


    public Integer getSupplierId() {
        return supplierId;
    }

    public void setSupplierId(Integer supplierId) {
        this.supplierId = supplierId;
    }

    public String getSupplierName() {
        return supplierName;
    }

    public void setSupplierName(String supplierName) {
        this.supplierName = supplierName;
    }

    public String getSupplierCompany() {
        return supplierCompany;
    }

    public void setSupplierCompany(String supplierCompany) {
        this.supplierCompany = supplierCompany;
    }

    public List<CommodityVo> getCommodities() {
        return commodities;
    }

    public void setCommodities(List<CommodityVo> commodities) {
        this.commodities = commodities;
    }
}
