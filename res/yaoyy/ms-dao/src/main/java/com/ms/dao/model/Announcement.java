package com.ms.dao.model;

import java.io.Serializable;
import java.util.Date;


public class Announcement  implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private Integer id;
	
	private Integer userType;
	
	private String content;
	
	private Date createTime;
	
	public Announcement(){}
	
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}
	
	public Integer getUserType() {
		return userType;
	}

	public void setUserType(Integer userType) {
		this.userType = userType;
	}
	
	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}
	
	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	
}