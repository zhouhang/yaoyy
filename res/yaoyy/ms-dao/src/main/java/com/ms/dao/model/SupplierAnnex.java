package com.ms.dao.model;

import java.io.Serializable;
import java.util.Date;


public class SupplierAnnex  implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private Integer id;
	
	//supplier表id
	private Integer supplierId;
	//图片地址
	private String url;
	
	private String status;

	private Date createTime;
	
	public SupplierAnnex(){}
	
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
	
	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}
	
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	
}