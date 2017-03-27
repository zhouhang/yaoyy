package com.ms.dao.vo;

import com.ms.dao.enums.SupplierSourceEnum;
import com.ms.dao.enums.SupplierStatusEnum;
import com.ms.dao.model.Category;
import com.ms.dao.model.Supplier;

import java.util.Date;
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

    //导出excel参数
    //信息核实人
    public String certifyMemberName;
    public Date certifyTime;

    //考察人
    public String judgeMemberName;
    public Date judgeTime;

    //签约人
    public String signMemberName;
    public Date signTime;


    public String getCertifyMemberName() {
        return certifyMemberName;
    }

    public void setCertifyMemberName(String certifyMemberName) {
        this.certifyMemberName = certifyMemberName;
    }

    public Date getCertifyTime() {
        return certifyTime;
    }

    public void setCertifyTime(Date certifyTime) {
        this.certifyTime = certifyTime;
    }

    public String getJudgeMemberName() {
        return judgeMemberName;
    }

    public void setJudgeMemberName(String judgeMemberName) {
        this.judgeMemberName = judgeMemberName;
    }

    public Date getJudgeTime() {
        return judgeTime;
    }

    public void setJudgeTime(Date judgeTime) {
        this.judgeTime = judgeTime;
    }

    public String getSignMemberName() {
        return signMemberName;
    }

    public void setSignMemberName(String signMemberName) {
        this.signMemberName = signMemberName;
    }

    public Date getSignTime() {
        return signTime;
    }

    public void setSignTime(Date signTime) {
        this.signTime = signTime;
    }
}