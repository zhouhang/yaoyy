package com.ms.dao.model;

import java.io.Serializable;
import java.util.Date;


public class QuoteFeed  implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private Integer id;
	
	//报价单id
	private Integer qid;
	
	//昵称
	private String nickname;
	
	//评论内容
	private String content;
	
	//创建时间
	private Date createTime;
	
	public QuoteFeed(){}
	
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}
	
	public Integer getQid() {
		return qid;
	}

	public void setQid(Integer qid) {
		this.qid = qid;
	}
	
	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
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