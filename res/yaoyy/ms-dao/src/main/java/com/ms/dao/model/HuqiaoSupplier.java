package com.ms.dao.model;

import java.io.Serializable;



public class HuqiaoSupplier  implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private Integer id;
	
	private String name;
	
	private String mobile;

	private String batchNumber;

	private String category;

	private String supplierNum;
	
	public HuqiaoSupplier(){}
	
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
	
	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	
	public String getSupplierNum() {
		return supplierNum;
	}

	public void setSupplierNum(String supplierNum) {
		this.supplierNum = supplierNum;
	}

	public String getBatchNumber() {
		return batchNumber;
	}

	public void setBatchNumber(String batchNumber) {
		this.batchNumber = batchNumber;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	@Override
	public String toString() {
		return "HuqiaoSupplier{" +
				"id=" + id +
				", name='" + name + '\'' +
				", mobile='" + mobile + '\'' +
				", batchNumber='" + batchNumber + '\'' +
				", category='" + category + '\'' +
				", supplierNum='" + supplierNum + '\'' +
				'}';
	}
}