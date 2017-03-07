package com.ms.dao.model;

import java.io.Serializable;
import java.util.Date;


public class Category  implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private Integer id;
	
	//父类id
	private Integer pid;
	
	//品种名
	private String name;
	
	//标题
	private String title;
	
	//价格描述
	private String priceDesc;
	
	//价格单位
	private String unit;
	
	private Integer sort;
	
	private Date createTime;
	
	private String pictureUrl;
	
	//上下架状态 0下架 1上架
	private Integer status;
	
	private Integer level;
	
	private Date updateTime;

	//新添加字段 add by kevin
	private String spec;

	private String unitDesc;

	private String alias;
	
	public Category(){}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}
	
	public Integer getPid() {
		return pid;
	}

	public void setPid(Integer pid) {
		this.pid = pid;
	}
	
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}
	
	public String getPriceDesc() {
		return priceDesc;
	}

	public void setPriceDesc(String priceDesc) {
		this.priceDesc = priceDesc;
	}
	
	public String getUnit() {
		return unit;
	}

	public void setUnit(String unit) {
		this.unit = unit;
	}
	
	public Integer getSort() {
		return sort;
	}

	public void setSort(Integer sort) {
		this.sort = sort;
	}
	
	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	
	public String getPictureUrl() {
		return pictureUrl;
	}

	public void setPictureUrl(String pictureUrl) {
		this.pictureUrl = pictureUrl;
	}
	
	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}
	
	public Integer getLevel() {
		return level;
	}

	public void setLevel(Integer level) {
		this.level = level;
	}
	
	public Date getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}

	//add by kevin
	public void setSpec(String spec) {
		this.spec = spec;
	}

	public void setUnitDesc(String unitDesc) {
		this.unitDesc = unitDesc;
	}

	public void setAlias(String alias) {
		this.alias = alias;
	}

	public String getSpec() {
		return spec;
	}

	public String getAlias() {
		return alias;
	}

	public String getUnitDesc() {
		return unitDesc;
	}
	
}