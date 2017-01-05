package com.ms.dao.model;

import java.io.Serializable;
import java.util.Date;


public class AccountBill  implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private Integer id;
	
	//账单编号
	private String code;
	
	//订单号
	private Integer orderId;
	
	//用户ID
	private Integer userId;
	
	//账单时间
	private Integer billTime;
	
	//应付
	private Float amountsPayable;
	
	//已付
	private Float alreadyPayable;
	
	//状态(0:未结清,1:已结清)
	private Integer status;
	
	//还款时间
	private Date repayTime;
	
	//操作人
	private Integer memberId;
	
	//创建时间
	private Date createDate;

	//更新时间
	private Date updateDate;
	
	public AccountBill(){}
	
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}
	
	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}
	
	public Integer getOrderId() {
		return orderId;
	}

	public void setOrderId(Integer orderId) {
		this.orderId = orderId;
	}
	
	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}
	
	public Integer getBillTime() {
		return billTime;
	}

	public void setBillTime(Integer billTime) {
		this.billTime = billTime;
	}
	
	public Float getAmountsPayable() {
		if (amountsPayable == null) amountsPayable = 0F;
		return amountsPayable;
	}

	public void setAmountsPayable(Float amountsPayable) {
		this.amountsPayable = amountsPayable;
	}
	
	public Float getAlreadyPayable() {
		if (alreadyPayable == null) alreadyPayable = 0F;
		return alreadyPayable;
	}

	public void setAlreadyPayable(Float alreadyPayable) {
		this.alreadyPayable = alreadyPayable;
	}
	
	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}
	
	public Date getRepayTime() {
		return repayTime;
	}

	public void setRepayTime(Date repayTime) {
		this.repayTime = repayTime;
	}
	
	public Integer getMemberId() {
		return memberId;
	}

	public void setMemberId(Integer memberId) {
		this.memberId = memberId;
	}
	
	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public Date getUpdateDate() {
		return updateDate;
	}

	public void setUpdateDate(Date updateDate) {
		this.updateDate = updateDate;
	}
}