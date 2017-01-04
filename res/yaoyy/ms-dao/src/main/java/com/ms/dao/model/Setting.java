package com.ms.dao.model;

import java.io.Serializable;



public class Setting  implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private Integer id;
	
	//客服电话
	private String consumerHotline;
	
	//账户名称
	private String payAccount;
	
	//账号
	private String payBankCard;
	
	//开户行
	private String payBank;
	
	public Setting(){}
	
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}
	
	public String getConsumerHotline() {
		return consumerHotline;
	}

	public void setConsumerHotline(String consumerHotline) {
		this.consumerHotline = consumerHotline;
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
	
	public String getPayBank() {
		return payBank;
	}

	public void setPayBank(String payBank) {
		this.payBank = payBank;
	}
	
}