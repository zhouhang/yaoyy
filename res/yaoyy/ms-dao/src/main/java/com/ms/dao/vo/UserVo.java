package com.ms.dao.vo;

import com.ms.dao.enums.IdentityTypeEnum;
import com.ms.dao.enums.UserEnum;
import com.ms.dao.model.Category;
import com.ms.dao.model.User;

import java.util.List;

public class UserVo extends User{

    /*
       是否登录，通过session可以获取
     */
    private boolean islogin;


    public boolean islogin() {
        return islogin;
    }

    public void setIslogin(boolean islogin) {
        this.islogin = islogin;
    }
    private String nickname;

    private Integer area;

    private String name;

    private String remark;

    private Integer identityType;

    private String typeName;

    private String position;

    private String categoryIds;

    private String company;

    private String sourceName;

    private String headImgUrl;

    /**
     * 品种信息
     */
    private List<CategoryVo> enterCategoryList;

    private String enterCategoryText;

    private String enterCategory;

    private String email;

    private String qq;

    private String mark;

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

    public void setIdentityTypeName(String identityTypeName) {
        this.identityTypeName = identityTypeName;
    }

    private String identityTypeName;

    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }

    public Integer getArea() {
        return area;
    }

    public void setArea(Integer area) {
        this.area = area;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public Integer getIdentityType() {
        return identityType;
    }

    public void setIdentityType(Integer identityType) {
        this.identityType = identityType;
    }

    public String getTypeName() {
        return UserEnum.get(super.getType());
    }

    public String getIdentityTypeName() {
        return IdentityTypeEnum.get(identityType);
    }

    public String getPosition() {return position;}

    public void setPosition(String position) {this.position = position;}

    public String getCategoryIds() {return categoryIds;}

    public void setCategoryIds(String categoryIds) {this.categoryIds = categoryIds;}

    public String getCompany() {return company;}

    public void setCompany(String company) {this.company = company;}

    public String getSourceName() {return sourceName;}

    public void setSourceName(String sourceName) {this.sourceName = sourceName;}

    public String getMark() {return mark;}

    public void setMark(String mark) {this.mark = mark;}

    public String getQq() {return qq;}

    public void setQq(String qq) {this.qq = qq;}

    public String getEmail() {return email;}

    public void setEmail(String email) {this.email = email;}

    public String getEnterCategory() {return enterCategory;}

    public void setEnterCategory(String enterCategory) {this.enterCategory = enterCategory;}

    public String getHeadImgUrl() {return headImgUrl;}

    public void setHeadImgUrl(String headImgUrl) {this.headImgUrl = headImgUrl;}
}