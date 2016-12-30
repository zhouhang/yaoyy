package com.ms.dao.model;

import java.io.Serializable;
import java.util.Date;


public class Pick  implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private Integer id;
	
	//用户id
	private Integer userId;
	
	private String nickname;
	
	private String phone;
	
	private String code;
	
	//0:正常，1废弃
	private Integer abandon;
	
	//送货单状态
	private Integer status;
	
	//运费
	private Float shippingCosts;
	
	//包装费
	private Float bagging;
	
	//检测费
	private Float checking;
	
	//税费
	private Float taxation;
	
	//结算方式：0：全款，1：保证金,2:账期
	private Integer settleType;
	
	//保证金
	private Float deposit;
	
	//账期时间单位天
	private Integer billTime;
	
	//对应下单地址记录里面的id
	private Integer addrHistoryId;
	
	//备注
	private String remark;
	
	//实际应付
	private Float amountsPayable;
	
	//操作人id
	private Integer memberId;
	
	//商品合计
	private Float sum;
	
	//发货时间
	private Date deliveryDate;
	
	//订单过期时间
	private Date expireDate;
	
	private Date updateTime;
	
	private Date createTime;
	
	public Pick(){}
	
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
	
	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	
	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}
	
	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}
	
	public Integer getAbandon() {
		return abandon;
	}

	public void setAbandon(Integer abandon) {
		this.abandon = abandon;
	}
	
	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}
	
	public Float getShippingCosts() {
		return shippingCosts;
	}

	public void setShippingCosts(Float shippingCosts) {
		this.shippingCosts = shippingCosts;
	}
	
	public Float getBagging() {
		return bagging;
	}

	public void setBagging(Float bagging) {
		this.bagging = bagging;
	}
	
	public Float getChecking() {
		return checking;
	}

	public void setChecking(Float checking) {
		this.checking = checking;
	}
	
	public Float getTaxation() {
		return taxation;
	}

	public void setTaxation(Float taxation) {
		this.taxation = taxation;
	}
	
	public Integer getSettleType() {
		return settleType;
	}

	public void setSettleType(Integer settleType) {
		this.settleType = settleType;
	}
	
	public Float getDeposit() {
		return deposit;
	}

	public void setDeposit(Float deposit) {
		this.deposit = deposit;
	}
	
	public Integer getBillTime() {
		return billTime;
	}

	public void setBillTime(Integer billTime) {
		this.billTime = billTime;
	}
	
	public Integer getAddrHistoryId() {
		return addrHistoryId;
	}

	public void setAddrHistoryId(Integer addrHistoryId) {
		this.addrHistoryId = addrHistoryId;
	}
	
	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}
	
	public Float getAmountsPayable() {
		return amountsPayable;
	}

	public void setAmountsPayable(Float amountsPayable) {
		this.amountsPayable = amountsPayable;
	}
	
	public Integer getMemberId() {
		return memberId;
	}

	public void setMemberId(Integer memberId) {
		this.memberId = memberId;
	}
	
	public Float getSum() {
		return sum;
	}

	public void setSum(Float sum) {
		this.sum = sum;
	}
	
	public Date getDeliveryDate() {
		return deliveryDate;
	}

	public void setDeliveryDate(Date deliveryDate) {
		this.deliveryDate = deliveryDate;
	}
	
	public Date getExpireDate() {
		return expireDate;
	}

	public void setExpireDate(Date expireDate) {
		this.expireDate = expireDate;
	}
	
	public Date getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}
	
	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	
}