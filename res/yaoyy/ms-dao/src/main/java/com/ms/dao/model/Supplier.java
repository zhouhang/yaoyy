package com.ms.dao.model;

import java.io.Serializable;
import java.util.Date;


public class Supplier  implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private Integer id;
	
	//姓名
	private String name;

	//公司名
	private String company;
	
	//手机号
	private String phone;
	
	//手机号2
	private String phone2;
	
	//邮箱
	private String email;
	
	//座机
	private String telephone;
	
<<<<<<< HEAD
	//地区
	private Integer area;
=======
	//地区 地址ID
	private String area;
>>>>>>> 845323b00e5617814f39e1c141c81fcfe1eae6b8
	
	//入驻品种,逗号隔开
	private String enterCategory;
	
	//qq号
	private String qq;
	
	//备注
	private String mark;
	
	private Date createTime;
	
	private Date updateTime;
	
	public Supplier(){}
	
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}
	
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}


	public String getCompany() {return company;}

	public void setCompany(String company) {this.company = company;}
	
	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}
	
	public String getPhone2() {
		return phone2;
	}

	public void setPhone2(String phone2) {
		this.phone2 = phone2;
	}
	
	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}
	
	public String getTelephone() {
		return telephone;
	}

	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}
	
	public Integer getArea() {
		return area;
	}

	public void setArea(Integer area) {
		this.area = area;
	}
	
	public String getEnterCategory() {
		return enterCategory;
	}

	public void setEnterCategory(String enterCategory) {
		this.enterCategory = enterCategory;
	}
	
	public String getQq() {
		return qq;
	}

	public void setQq(String qq) {
		this.qq = qq;
	}
	
	public String getMark() {
		return mark;
	}

	public void setMark(String mark) {
		this.mark = mark;
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
	
}