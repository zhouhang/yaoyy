package com.ms.dao.model;

import java.io.Serializable;
import java.util.Date;


public class ArticleTag  implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private Integer id;
	
	private Integer sort;
	
	private String name;
	
	private Date createTime;
	
	//0 禁用 1启用
	private Integer status;
	
	public ArticleTag(){}
	
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}
	
	public Integer getSort() {
		return sort;
	}

	public void setSort(Integer sort) {
		this.sort = sort;
	}
	
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	
	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}
	
}