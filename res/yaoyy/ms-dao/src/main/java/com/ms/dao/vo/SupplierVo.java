package com.ms.dao.vo;

import com.ms.dao.model.Category;
import com.ms.dao.model.Supplier;

import java.util.List;

public class SupplierVo extends Supplier{

    /**
     * 入驻品种信息
     */
    private List<CategoryVo> enterCategoryList;

    private String enterCategoryText;

    public String getEnterCategoryText() {
        enterCategoryText="";
        if (enterCategoryList!=null) {
            for (int i=0;i<enterCategoryList.size();i++) {
                Category category=enterCategoryList.get(i);
                if(i==(enterCategoryList.size()-1)){
                    enterCategoryText = enterCategoryText + category.getVariety();
                }
                else{
                    enterCategoryText = enterCategoryText + category.getVariety() + ',';
                }

            }
        }
        return enterCategoryText;
    }

    public void setEnterCategoryText(String enterCategoryText) {
        this.enterCategoryText = enterCategoryText;
    }

    public List<CategoryVo> getEnterCategoryList() {
        return enterCategoryList;
    }

    public void setEnterCategoryList(List<CategoryVo> enterCategoryList) {
        this.enterCategoryList = enterCategoryList;
    }
}