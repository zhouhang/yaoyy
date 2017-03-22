package com.ms.dao.model;

import java.io.Serializable;
import java.util.Date;


public class SupplierCommodity  implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private Integer id;
	
	//supplier表id
	private Integer supplierId;
	
	private String name;
	
	private String spec;
	
	private String origin;
	
	private Date createTime;
	
	public SupplierCommodity(){}
	
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
	
	public String getSpec() {
		return spec;
	}

	public void setSpec(String spec) {
		this.spec = spec;
	}
	
	public String getOrigin() {
		return origin;
	}

	public void setOrigin(String origin) {
		this.origin = origin;
	}
	
	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	
}