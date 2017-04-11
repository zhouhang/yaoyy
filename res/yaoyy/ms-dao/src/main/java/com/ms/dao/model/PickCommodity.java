package com.ms.dao.model;

import java.io.Serializable;
import java.util.Date;


public class PickCommodity  implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private Integer id;
	//选货单id
	private Integer pickId;

	//历史表中的商品id
	
	private Integer commodityId;
	//数量
	private Float num;
	//单位
	private String unit;
	//总量
	private Float total;
    //价格
	private Float price;
	
	private Date createTime;

	public Float getPrice() {
		return price;
	}

	public void setPrice(Float price) {
		this.price = price;
	}
	
	public PickCommodity(){}
	
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getPickId() {
		return pickId;
	}

	public void setPickId(Integer pickId) {
		this.pickId = pickId;
	}

	public Integer getCommodityId() {
		return commodityId;
	}

	public void setCommodityId(Integer commodityId) {
		this.commodityId = commodityId;
	}
	
	public Float getNum() {
		return num;
	}

	public void setNum(Float num) {
		this.num = num;
	}
	
	public String getUnit() {
		return unit;
	}

	public void setUnit(String unit) {
		this.unit = unit;
	}

	public Float getTotal() {
		return total;
	}

	public void setTotal(Float total) {
		this.total = total;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	
}