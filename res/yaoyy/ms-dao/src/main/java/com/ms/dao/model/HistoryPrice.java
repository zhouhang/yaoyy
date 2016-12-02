package com.ms.dao.model;

import java.io.Serializable;
import java.util.Date;


public class HistoryPrice  implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private Integer id;
	
	//商品id
	private Integer commodityId;
	
	//价格
	private Float price;
	
	//创建时间
	private Date createTime;
	
	//创建人
	private Integer createId;
	
	public HistoryPrice(){}
	
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}
	
	public Integer getCommodityId() {
		return commodityId;
	}

	public void setCommodityId(Integer commodityId) {
		this.commodityId = commodityId;
	}
	
	public Float getPrice() {
		return price;
	}

	public void setPrice(Float price) {
		this.price = price;
	}
	
	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	
	public Integer getCreateId() {
		return createId;
	}

	public void setCreateId(Integer createId) {
		this.createId = createId;
	}
	
}