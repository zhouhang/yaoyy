package com.ms.dao.model;

import java.io.Serializable;
import java.util.Date;


public class Quotation  implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private Integer id;
	
	//标题
	private String title;
	
	//状态
	private Integer status;
	
	//清单内容
	private String content;
	
	//描述
	private String description;
	
	private Date createTime;
	
	private Date updateTime;
	
	public Quotation(){}
	
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}
	
	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}
	
	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}
	
	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
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