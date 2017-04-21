package com.ms.dao.vo;

import com.ms.dao.model.Article;

public class ArticleVo extends Article{


    /**
     * 标签Name字符串
     */
    private String tagStr;

    /**
     *标签Id字符串
     */
    private String tagIds;

    public String getTagIds() {
        return tagIds;
    }

    public void setTagIds(String tagIds) {
        this.tagIds = tagIds;
    }

    public String getTagStr() {
        return tagStr;
    }

    public void setTagStr(String tagStr) {
        this.tagStr = tagStr;
    }
}