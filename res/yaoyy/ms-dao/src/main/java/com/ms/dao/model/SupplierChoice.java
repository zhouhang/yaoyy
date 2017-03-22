package com.ms.dao.model;

import java.io.Serializable;
import java.util.Date;


public class SupplierChoice  implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private Integer id;
	
	//supplier表id
	private Integer supplierId;
	
	//survey表id
	private Integer surveyId;
	//答案序号
	private Integer choose;
	//描述
	private String desc;
	
	private Date createTime;
	
	public SupplierChoice(){}
	
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
	
	public Integer getSurveyId() {
		return surveyId;
	}

	public void setSurveyId(Integer surveyId) {
		this.surveyId = surveyId;
	}
	
	public Integer getChoose() {
		return choose;
	}

	public void setChoose(Integer choose) {
		this.choose = choose;
	}
	
	public String getDesc() {
		return desc;
	}

	public void setDesc(String desc) {
		this.desc = desc;
	}
	
	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	
}