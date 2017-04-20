package com.ms.dao.model;

import java.io.Serializable;



public class ArticleTagBind  implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private Integer id;
	
	private Integer articleId;
	
	private Integer tagId;
	
	public ArticleTagBind(){}
	
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}
	
	public Integer getArticleId() {
		return articleId;
	}

	public void setArticleId(Integer articleId) {
		this.articleId = articleId;
	}
	
	public Integer getTagId() {
		return tagId;
	}

	public void setTagId(Integer tagId) {
		this.tagId = tagId;
	}
	
}