package com.ms.dao.model;

import java.io.Serializable;



public class CommodityBatch  implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private Integer id;
	
	//商品数量
	private Integer num;
	
	//订单商品表的ID
	private Integer pickCommodityId;
	
	//批次号
	private String no;
	
	public CommodityBatch(){}
	
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}
	
	public Integer getNum() {
		return num;
	}

	public void setNum(Integer num) {
		this.num = num;
	}
	
	public Integer getPickCommodityId() {
		return pickCommodityId;
	}

	public void setPickCommodityId(Integer pickCommodityId) {
		this.pickCommodityId = pickCommodityId;
	}
	
	public String getNo() {
		return no;
	}

	public void setNo(String no) {
		this.no = no;
	}
	
}