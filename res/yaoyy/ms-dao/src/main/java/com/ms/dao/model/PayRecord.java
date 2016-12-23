package com.ms.dao.model;

import java.io.Serializable;
import java.util.Date;


public class PayRecord  implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private Integer id;
	
	//支付流水号
	private String payCode;
	
	//订单编号
	private String orderCode;
	
	private Integer orderId;
	
	//单号类型：0:订单，1：账单
	private Integer codeType;
	
	//关联账单
	private Integer accountBillId;
	
	//三方支付id
	private Integer paymentId;
	
	//实付金额
	private Float actualPayment;
	
	//开户行
	private String payBank;
	
	//开户人
	private String payAccount;
	
	//银行卡号
	private String payBankCard;
	
	//用户id
	private Integer userId;
	
	//支付时间
	private Date paymentTime;
	
	//0付款待确认，1支付成功，2支付失败
	private Integer status;
	
	//支付渠道 ：0,线下转账，1支付宝支付,2.微信支付
	private Integer payType;
	
	//创建时间
	private Date createTime;
	
	public PayRecord(){}
	
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}
	
	public String getPayCode() {
		return payCode;
	}

	public void setPayCode(String payCode) {
		this.payCode = payCode;
	}
	
	public String getOrderCode() {
		return orderCode;
	}

	public void setOrderCode(String orderCode) {
		this.orderCode = orderCode;
	}
	
	public Integer getOrderId() {
		return orderId;
	}

	public void setOrderId(Integer orderId) {
		this.orderId = orderId;
	}
	
	public Integer getCodeType() {
		return codeType;
	}

	public void setCodeType(Integer codeType) {
		this.codeType = codeType;
	}
	
	public Integer getAccountBillId() {
		return accountBillId;
	}

	public void setAccountBillId(Integer accountBillId) {
		this.accountBillId = accountBillId;
	}
	
	public Integer getPaymentId() {
		return paymentId;
	}

	public void setPaymentId(Integer paymentId) {
		this.paymentId = paymentId;
	}
	
	public Float getActualPayment() {
		return actualPayment;
	}

	public void setActualPayment(Float actualPayment) {
		this.actualPayment = actualPayment;
	}
	
	public String getPayBank() {
		return payBank;
	}

	public void setPayBank(String payBank) {
		this.payBank = payBank;
	}
	
	public String getPayAccount() {
		return payAccount;
	}

	public void setPayAccount(String payAccount) {
		this.payAccount = payAccount;
	}
	
	public String getPayBankCard() {
		return payBankCard;
	}

	public void setPayBankCard(String payBankCard) {
		this.payBankCard = payBankCard;
	}
	
	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}
	
	public Date getPaymentTime() {
		return paymentTime;
	}

	public void setPaymentTime(Date paymentTime) {
		this.paymentTime = paymentTime;
	}
	
	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}
	
	public Integer getPayType() {
		return payType;
	}

	public void setPayType(Integer payType) {
		this.payType = payType;
	}
	
	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	
}