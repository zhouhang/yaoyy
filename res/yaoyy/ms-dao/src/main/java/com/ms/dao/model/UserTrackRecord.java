package com.ms.dao.model;

import java.io.Serializable;
import java.util.Date;


public class UserTrackRecord  implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private Integer id;
	
	//user表id
	private Integer userId;
	
	private String content;
	
	private Date createTime;
	
	public UserTrackRecord(){}
	
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}
	
	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
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