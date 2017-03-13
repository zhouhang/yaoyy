package com.ms.dao.model;

import java.io.Serializable;
import java.util.Date;


public class UserDetail  implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private Integer id;
	
	//补全信息类型(身份类型)
	private Integer type;
	
	//微信名
	private String nickname;
	
	//联系电话
	private String phone;
	
	//地区
	private Integer area;
	
	//姓名
	private String name;
	
	//用户备注
	private String remark;
	
	//user表id
	private Integer userId;

	private String headImgUrl;

	private Date createTime;
	
	private Date updateTime;

	//经营品种
	private String categoryIds;

	//邮箱
	private String email;

	//qq
	private String qq;

	//公司名
	private String company;

	//供应商是否已签合同 0未签 1已签
	private Integer contract;
	
	public UserDetail(){}
	
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}
	
	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}
	
	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	
	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
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
	
	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}
	
	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	
	public Date getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}

	public String getHeadImgUrl() {
		return headImgUrl;
	}

	public void setHeadImgUrl(String headImgUrl) {
		this.headImgUrl = headImgUrl;
	}

	public String getCompany() {return company;}

	public void setCompany(String company) {this.company = company;}

	public String getQq() {return qq;}

	public void setQq(String qq) {this.qq = qq;}

	public String getEmail() {return email;}

	public void setEmail(String email) {this.email = email;}

	public String getCategoryIds() {return categoryIds;}

	public void setCategoryIds(String categoryIds) {this.categoryIds = categoryIds;}

	public Integer getContract() {return contract;}

	public void setContract(Integer contract) {this.contract = contract;}
}