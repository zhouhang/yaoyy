package com.ms.dao.model;

import java.io.Serializable;
import java.util.Date;


public class Article  implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private Integer id;
	
	//标题
	private String title;
	
	private String content;
	
	//链接
	private String url;
	
	//状态 1启用(发布)，0禁用(草稿)
	private Integer status;
	
	//创建者
	private Integer createMem;
	
	private Date createTime;
	
	private Integer updateMem;
	
	private Date updateTime;
	
	private String descript;
	
	//点击率
	private Integer hits;
	
	//文章类别  1:平台CMS文章 2：药商头条
	private Integer type;
	
	public Article(){}
	
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
	
	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}
	
	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}
	
	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}
	
	public Integer getCreateMem() {
		return createMem;
	}

	public void setCreateMem(Integer createMem) {
		this.createMem = createMem;
	}
	
	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	
	public Integer getUpdateMem() {
		return updateMem;
	}

	public void setUpdateMem(Integer updateMem) {
		this.updateMem = updateMem;
	}
	
	public Date getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}
	
	public String getDescript() {
		return descript;
	}

	public void setDescript(String descript) {
		this.descript = descript;
	}
	
	public Integer getHits() {
		return hits;
	}

	public void setHits(Integer hits) {
		this.hits = hits;
	}
	
	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}
	
}