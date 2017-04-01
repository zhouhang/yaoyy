package com.ms.dao.model;

import java.io.Serializable;
import java.util.Date;


public class UserTrackRecord  implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private Integer id;
	
	//user表id
	private Integer userId;

	private Integer supplierId;

	private Integer memberId;
	
	private String content;
	
	private Date createTime;

	//跟踪类型：0普通记录，1：核实记录，2：认证记录，3：签约记录
	private Integer type;
	
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

	public Integer getSupplierId() {return supplierId;}

	public void setSupplierId(Integer supplierId) {this.supplierId = supplierId;}

	public Integer getMemberId() {return memberId;}

	public void setMemberId(Integer memberId) {this.memberId = memberId;}

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


	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}
}