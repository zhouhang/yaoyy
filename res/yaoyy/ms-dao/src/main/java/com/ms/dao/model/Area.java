package com.ms.dao.model;

import java.io.Serializable;



public class Area  implements Serializable {

	private static final long serialVersionUID = 1L;
	
	//ID
	private Integer id;
	
	//栏目名
	private String areaname;
	
	//父栏目
	private Integer parentid;
	
	private String shortname;
	
	private Integer areacode;
	
	private Integer zipcode;
	
	private String pinyin;
	
	private String lng;
	
	private String lat;
	
	private Boolean level;
	
	private String position;
	
	//排序
	private Integer sort;
	
	public Area(){}
	
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}
	
	public String getAreaname() {
		return areaname;
	}

	public void setAreaname(String areaname) {
		this.areaname = areaname;
	}
	
	public Integer getParentid() {
		return parentid;
	}

	public void setParentid(Integer parentid) {
		this.parentid = parentid;
	}
	
	public String getShortname() {
		return shortname;
	}

	public void setShortname(String shortname) {
		this.shortname = shortname;
	}
	
	public Integer getAreacode() {
		return areacode;
	}

	public void setAreacode(Integer areacode) {
		this.areacode = areacode;
	}
	
	public Integer getZipcode() {
		return zipcode;
	}

	public void setZipcode(Integer zipcode) {
		this.zipcode = zipcode;
	}
	
	public String getPinyin() {
		return pinyin;
	}

	public void setPinyin(String pinyin) {
		this.pinyin = pinyin;
	}
	
	public String getLng() {
		return lng;
	}

	public void setLng(String lng) {
		this.lng = lng;
	}
	
	public String getLat() {
		return lat;
	}

	public void setLat(String lat) {
		this.lat = lat;
	}
	
	public Boolean getLevel() {
		return level;
	}

	public void setLevel(Boolean level) {
		this.level = level;
	}
	
	public String getPosition() {
		return position;
	}

	public void setPosition(String position) {
		this.position = position;
	}
	
	public Integer getSort() {
		return sort;
	}

	public void setSort(Integer sort) {
		this.sort = sort;
	}
	
}