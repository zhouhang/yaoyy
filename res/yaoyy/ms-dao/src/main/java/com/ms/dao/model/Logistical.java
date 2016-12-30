package com.ms.dao.model;

import java.io.Serializable;
import java.util.Date;


public class Logistical  implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private Integer id;
	
	private Integer orderId;
	
	//发货日期
	private Date shipDate;
	
	//发货单据图片
	private String pictureUrl;
	
	private String content;
	
	//创建时间
	private Date createDate;
	
	public Logistical(){}
	
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}
	
	public Integer getOrderId() {
		return orderId;
	}

	public void setOrderId(Integer orderId) {
		this.orderId = orderId;
	}
	
	public Date getShipDate() {
		return shipDate;
	}

	public void setShipDate(Date shipDate) {
		this.shipDate = shipDate;
	}
	
	public String getPictureUrl() {
		return pictureUrl;
	}

	public void setPictureUrl(String pictureUrl) {
		this.pictureUrl = pictureUrl;
	}
	
	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}
	
	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	
}