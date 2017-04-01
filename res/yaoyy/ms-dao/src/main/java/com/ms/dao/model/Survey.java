package com.ms.dao.model;

import java.io.Serializable;
import java.util.Date;


public class Survey  implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private Integer id;
	
	private String question;
	
	private String anwser;
	
	private Integer status;
	
	private Date createTime;
	
	public Survey(){}
	
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}
	
	public String getQuestion() {
		return question;
	}

	public void setQuestion(String question) {
		this.question = question;
	}
	
	public String getAnwser() {
		return anwser;
	}

	public void setAnwser(String anwser) {
		this.anwser = anwser;
	}
	
	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}
	
	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	
}