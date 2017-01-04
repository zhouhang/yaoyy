package com.ms.dao.model;

import java.io.Serializable;
import java.util.Date;


public class Payment  implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private Integer id;
	
	//用户id
	private Integer userId;
	
	//支付方式
	private Integer payType;
	
	//支付状态 0待支付1支付成功2支付失败
	private Integer status;
	
	//0:订单，1：账单
	private Integer type;
	
	//订单id
	private Integer orderId;
	
	//账单id
	private Integer billId;
	
	//支付金额
	private Float money;
	
	//支付宝/微信交易号
	private String tradeNo;
	
	//提供给第三方支付的订单号，必须唯一
	private String outTradeNo;
	
	private String remark;
	
	//返回参数
	private String inParam;
	
	//传出参数
	private String outParam;
	
	//创建时间
	private Date createTime;
	
	//回调时间
	private Date callbackTime;
	
	public Payment(){}
	
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
	
	public Integer getPayType() {
		return payType;
	}

	public void setPayType(Integer payType) {
		this.payType = payType;
	}
	
	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}
	
	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}
	
	public Integer getOrderId() {
		return orderId;
	}

	public void setOrderId(Integer orderId) {
		this.orderId = orderId;
	}
	
	public Integer getBillId() {
		return billId;
	}

	public void setBillId(Integer billId) {
		this.billId = billId;
	}
	
	public Float getMoney() {
		return money;
	}

	public void setMoney(Float money) {
		this.money = money;
	}
	
	public String getTradeNo() {
		return tradeNo;
	}

	public void setTradeNo(String tradeNo) {
		this.tradeNo = tradeNo;
	}
	
	public String getOutTradeNo() {
		return outTradeNo;
	}

	public void setOutTradeNo(String outTradeNo) {
		this.outTradeNo = outTradeNo;
	}
	
	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}
	
	public String getInParam() {
		return inParam;
	}

	public void setInParam(String inParam) {
		this.inParam = inParam;
	}
	
	public String getOutParam() {
		return outParam;
	}

	public void setOutParam(String outParam) {
		this.outParam = outParam;
	}
	
	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	
	public Date getCallbackTime() {
		return callbackTime;
	}

	public void setCallbackTime(Date callbackTime) {
		this.callbackTime = callbackTime;
	}
	
}