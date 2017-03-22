package com.ms.dao.model;

import java.io.Serializable;
import java.util.Date;


public class SupplierContact  implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private Integer id;
	
	//supplier表id
	private Integer supplierId;
	//姓名
	private String name;
	
	private String phone;
	//职位
	private String position;
	//关键人
	private Integer kp;
	
	private Date createTime;
	
	public SupplierContact(){}
	
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}
	
	public Integer getSupplierId() {
		return supplierId;
	}

	public void setSupplierId(Integer supplierId) {
		this.supplierId = supplierId;
	}
	
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}
	
	public String getPosition() {
		return position;
	}

	public void setPosition(String position) {
		this.position = position;
	}
	
	public Integer getKp() {
		return kp;
	}

	public void setKp(Integer kp) {
		this.kp = kp;
	}
	
	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	
}