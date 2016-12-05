package com.ms.dao.vo;

import com.ms.dao.model.Supplier;

import java.util.List;

public class SupplierVo extends Supplier{

    /**
     * 入驻品种信息
     */
    private List<CategoryVo> enterCategoryList;

    public List<CategoryVo> getEnterCategoryList() {
        return enterCategoryList;
    }

    public void setEnterCategoryList(List<CategoryVo> enterCategoryList) {
        this.enterCategoryList = enterCategoryList;
    }
}