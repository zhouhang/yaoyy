package com.ms.dao.model;

import java.io.Serializable;
import java.util.Date;


public class FollowCommodity  implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private Integer id;
	
	//商品id
	private Integer commodityId;
	
	//关注时价格
	private Float price;
	
	//用户id
	private Integer userId;
	
	//创建时间
	private Date createTime;
	
	public FollowCommodity(){}
	
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
	
	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}
	
	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	
}