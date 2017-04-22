package com.ms.dao.model;

import java.io.Serializable;
import java.util.Date;


public class Commodity  implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private Integer id;
	
	private String title;
	
	private String name;

	// 年限
	private String harYear;

	// 产地
	private String origin;

	//规格等级
	private String spec;

	//加工方式
	private String process;

	//性状特征
	private String exterior;

	//执行标准
	private String executiveStandard;

	//品种id
	private Integer categoryId;


	// 商品图片
	private String pictureUrl;

	// 商品缩略图
	private String thumbnailUrl;
    //商品详情
	private String detail;

	//0：下架，1：上架
	private Integer status;

	// 商品属性 JSON 串
	private String attribute;

	// 价格
	private Float price;

	// 单位
	private Integer unit;

	//起购数量
	private Integer minimumQuantity;

	//商品标语
	private String slogan;

	// 排序
	private Integer sort;
	
	private Date createTime;
	
	private Date updateTime;

	//这个字段之前是与supplier的id关联，后来因为业务修改，与user表的id关联，及供应商变成我们注册用户可以添加商品 add by kevin 03/08/2017
	private Integer supplierId;

	// 价格更新时间
	private Date priceUpdateTime;

	// 寄卖库存
	private Float warehouse;

	// 供应商家里库存
	private Float unwarehouse;

	//0 非特价 1特价商品
	private Integer specialOffers;
	
	public Commodity(){}


	public Integer getSupplierId() {
		return supplierId;
	}

	public void setSupplierId(Integer supplierId) {
		this.supplierId = supplierId;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}
	
	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}
	
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	public String getHarYear() {
		return harYear;
	}

	public void setHarYear(String harYear) {
		this.harYear = harYear;
	}
	
	public String getOrigin() {
		return origin;
	}

	public void setOrigin(String origin) {
		this.origin = origin;
	}
	
	public String getSpec() {
		return spec;
	}

	public void setSpec(String spec) {
		this.spec = spec;
	}
	
	public Integer getCategoryId() {
		return categoryId;
	}

	public void setCategoryId(Integer categoryId) {
		this.categoryId = categoryId;
	}
	
	public String getPictureUrl() {
		return pictureUrl;
	}

	public void setPictureUrl(String pictureUrl) {
		this.pictureUrl = pictureUrl;
	}
	
	public String getDetail() {
		return detail;
	}

	public void setDetail(String detail) {
		this.detail = detail;
	}
	
	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}
	
	public String getAttribute() {
		return attribute;
	}

	public void setAttribute(String attribute) {
		this.attribute = attribute;
	}
	
	public Float getPrice() {
		return price;
	}

	public void setPrice(Float price) {
		this.price = price;
	}
	
	public Integer getUnit() {
		return unit;
	}

	public void setUnit(Integer unit) {
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
	
	public Date getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}

	public Integer getMinimumQuantity() {
		return minimumQuantity;
	}

	public void setMinimumQuantity(Integer minimumQuantity) {
		this.minimumQuantity = minimumQuantity;
	}

	public String getSlogan() {
		return slogan;
	}

	public void setSlogan(String slogan) {
		this.slogan = slogan;
	}

	public String getThumbnailUrl() {
		return thumbnailUrl;
	}

	public void setThumbnailUrl(String thumbnailUrl) {
		this.thumbnailUrl = thumbnailUrl;
	}

	public Date getPriceUpdateTime() {
		if (priceUpdateTime == null) priceUpdateTime = updateTime;
		return priceUpdateTime;
	}

	public void setPriceUpdateTime(Date priceUpdateTime) {
		this.priceUpdateTime = priceUpdateTime;
	}

	public String getProcess() {
		return process;
	}

	public void setProcess(String process) {
		this.process = process;
	}

	public String getExterior() {
		return exterior;
	}

	public void setExterior(String exterior) {
		this.exterior = exterior;
	}

	public String getExecutiveStandard() {
		return executiveStandard;
	}

	public void setExecutiveStandard(String executiveStandard) {
		this.executiveStandard = executiveStandard;
	}

	public Float getWarehouse() {
		return warehouse;
	}

	public void setWarehouse(Float warehouse) {
		this.warehouse = warehouse;
	}

	public Float getUnwarehouse() {
		return unwarehouse;
	}

	public void setUnwarehouse(Float unwarehouse) {
		this.unwarehouse = unwarehouse;
	}

	public Integer getSpecialOffers() {
		return specialOffers;
	}

	public void setSpecialOffers(Integer specialOffers) {
		this.specialOffers = specialOffers;
	}
}