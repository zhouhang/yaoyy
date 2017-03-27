package com.ms.dao.vo;

import com.ms.dao.enums.SupplierSourceEnum;
import com.ms.dao.enums.SupplierStatusEnum;
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
                    enterCategoryText = enterCategoryText + category.getName();
                }
                else{
                    enterCategoryText = enterCategoryText + category.getName() + ',';
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

    //区域中文
    private String areaname;

    public String getAreaname() {
        return areaname;
    }

    public void setAreaname(String areaname) {
        this.areaname = areaname;
    }

    //省市区的中文
    private String position;

    public String getPosition() {return position;}

    public void setPosition(String position) {this.position = position;}

    //供应商状态描述
    private String statusText;

    public String getStatusText() {return SupplierStatusEnum.get(this.getStatus());}

    public void setStatusText(String statusText) {this.statusText = statusText;}

    //是否绑定用户
    private String binding;

    //是否绑定用户
    private String sourceText;

    public String getSourceText() {return SupplierSourceEnum.get(this.getSource());}

    public void setSourceText(String sourceText) {this.sourceText = sourceText;}

    public String getBinding() {return binding;}

    public void setBinding(String binding) {this.binding = binding;}

}