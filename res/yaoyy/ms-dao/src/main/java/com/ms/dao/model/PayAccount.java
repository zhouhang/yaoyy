package com.ms.dao.model;

import java.io.Serializable;
import java.util.Date;


public class PayAccount  implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private Integer id;
	
	//收款银行
	private String receiveBank;
	
	//收款账户
	private String receiveAccount;
	
	//收款银行卡号
	private String receiveBankCard;
	
	//创建时间
	private Date createDate;
	
	public PayAccount(){}
	
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}
	
	public String getReceiveBank() {
		return receiveBank;
	}

	public void setReceiveBank(String receiveBank) {
		this.receiveBank = receiveBank;
	}
	
	public String getReceiveAccount() {
		return receiveAccount;
	}

	public void setReceiveAccount(String receiveAccount) {
		this.receiveAccount = receiveAccount;
	}
	
	public String getReceiveBankCard() {
		return receiveBankCard;
	}

	public void setReceiveBankCard(String receiveBankCard) {
		this.receiveBankCard = receiveBankCard;
	}
	
	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	
}