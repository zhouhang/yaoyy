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

	//地区
	private Integer area;
	
	//入驻品种,逗号隔开
	private String enterCategory;

	//入驻品种,逗号隔开
	private String enterCategoryStr;
	
	//qq号
	private String qq;
	
	//备注
	private String mark;
	
	private Date createTime;
	
	private Date updateTime;

	//记录5个状态  未核实 已核实 核实不正确   已实地考察  已签约(签约才添加商品)
	private Integer status;

	//详细地址
	private String address;

	//组织类型
	private Integer org;

	//年业务量
	private String bizYear;

	//业务类型
	private Integer bizType;

	//经营地
	private Integer bizPlace;

	//客户群体类型，因为多选，所以String，将群体类型id用逗号分隔
	private String bizCustomerType;

	//知名客户
	private String bizPartner;

	//员工规模
	private Integer scaleStaff;

	//仓库情况
	private Integer scaleStore;

	//仓库情况备注
	private String scaleStoreMark;

	//加工条件
	private Integer scaleProcess;

	//加工能力匹配性
	private Integer scaleProcessAble;

	//加工条件备注
	private String scaleProcessMark;

	private Integer source;

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

	public String getEnterCategoryStr() {return enterCategoryStr;}

	public void setEnterCategoryStr(String enterCategoryStr) {this.enterCategoryStr = enterCategoryStr;}

	public Integer getSource() {return source;}

	public void setSource(Integer source) {this.source = source;}

	public Integer getStatus() {return status;}

	public void setStatus(Integer status) {this.status = status;}

	public String getAddress() {return address;}

	public void setAddress(String address) {this.address = address;}

	public Integer getOrg() {return org;}

	public void setOrg(Integer org) {this.org = org;}

	public String getBizYear() {return bizYear;}

	public void setBizYear(String bizYear) {this.bizYear = bizYear;}

	public Integer getBizType() {return bizType;}

	public void setBizType(Integer bizType) {this.bizType = bizType;}

	public Integer getBizPlace() {return bizPlace;}

	public void setBizPlace(Integer bizPlace) {this.bizPlace = bizPlace;}

	public String getBizCustomerType() {return bizCustomerType;}

	public void setBizCustomerType(String bizCustomerType) {this.bizCustomerType = bizCustomerType;}

	public String getBizPartner() {return bizPartner;}

	public void setBizPartner(String bizPartner) {this.bizPartner = bizPartner;}

	public Integer getScaleStaff() {return scaleStaff;}

	public void setScaleStaff(Integer scaleStaff) {this.scaleStaff = scaleStaff;}

	public Integer getScaleStore() {return scaleStore;}

	public void setScaleStore(Integer scaleStore) {this.scaleStore = scaleStore;}

	public String getScaleStoreMark() {return scaleStoreMark;}

	public void setScaleStoreMark(String scaleStoreMark) {this.scaleStoreMark = scaleStoreMark;}

	public Integer getScaleProcess() {return scaleProcess;}

	public void setScaleProcess(Integer scaleProcess) {this.scaleProcess = scaleProcess;}

	public Integer getScaleProcessAble() {return scaleProcessAble;}

	public void setScaleProcessAble(Integer scaleProcessAble) {this.scaleProcessAble = scaleProcessAble;}

	public String getScaleProcessMark() {return scaleProcessMark;}

	public void setScaleProcessMark(String scaleProcessMark) {this.scaleProcessMark = scaleProcessMark;}
	
}