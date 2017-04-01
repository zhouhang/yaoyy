package com.ms.dao.vo;

import java.util.List;

/**
 * Created by xc on 2017/3/23.
 */
public class SupplierCertifyVo {


    private SupplierVo supplier;

    private List<SupplierCommodityVo>  supplierCommodityVos;

    private Integer memberId;

    public SupplierVo getSupplier() {
        return supplier;
    }

    public void setSupplier(SupplierVo supplier) {
        this.supplier = supplier;
    }

    public List<SupplierCommodityVo> getSupplierCommodityVos() {
        return supplierCommodityVos;
    }

    public void setSupplierCommodityVos(List<SupplierCommodityVo> supplierCommodityVos) {
        this.supplierCommodityVos = supplierCommodityVos;
    }

    public Integer getMemberId() {
        return memberId;
    }

    public void setMemberId(Integer memberId) {
        this.memberId = memberId;
    }
}
