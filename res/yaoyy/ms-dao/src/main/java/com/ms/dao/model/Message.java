package com.ms.dao.model;

import java.io.Serializable;
import java.util.Date;


public class Message  implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private Integer id;
	
	//产生消息的用户id
	private Integer userId;
	
	//跳转页面
	private String url;
	
	private String content;
	
	//类型
	private Integer type;
	
	//处理状态
	private Integer status;
	
	//对应的id(寄样单，或是选货单)
	private Integer eventId;
	
	private Date createTime;
	
	public Message(){}
	
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
	
	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}
	
	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}
	
	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}
	
	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}
	
	public Integer getEventId() {
		return eventId;
	}

	public void setEventId(Integer eventId) {
		this.eventId = eventId;
	}
	
	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	
}