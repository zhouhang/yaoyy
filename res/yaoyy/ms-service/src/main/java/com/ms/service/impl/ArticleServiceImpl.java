package com.ms.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.google.common.base.Strings;
import com.ms.dao.ArticleTagBindDao;
import com.ms.dao.ArticleTagDao;
import com.ms.dao.ICommonDao;
import com.ms.dao.ArticleDao;
import com.ms.dao.model.Article;
import com.ms.dao.model.ArticleTag;
import com.ms.dao.model.ArticleTagBind;
import com.ms.dao.vo.ArticleTagVo;
import com.ms.dao.vo.ArticleVo;
import com.ms.service.ArticleService;
import com.ms.tools.ClazzUtil;
import com.ms.tools.upload.PathConvert;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;

@Service
public class ArticleServiceImpl  extends AbsCommonService<Article> implements ArticleService{

	@Autowired
	private ArticleDao articleDao;

	@Autowired
	private ArticleTagDao articleTagDao;

	@Autowired
	private ArticleTagBindDao bindDao;

	@Autowired
	private PathConvert pathConvert;

	/**
	 * 头条图片保存路径
	 */
	private String folderName = "headline/";

	@Override
	public PageInfo<ArticleVo> findByParams(ArticleVo articleVo,Integer pageNum,Integer pageSize) {
		if (pageNum == null || pageSize == null){
			pageNum = 1;
			pageSize = 10;
		}
    	PageHelper.startPage(pageNum, pageSize);
    	List<ArticleVo>  list = articleDao.findByParams(articleVo);
        PageInfo page = new PageInfo(list);
        return page;
	}

	@Override
	@Transactional
	public void changeStatus(Integer id, Integer status) {
		Article article  = new Article();
		article.setId(id);
		article.setStatus(status);
		update(article);
	}

	@Override
	@Transactional
	public Article save(Article article) {
		if (article.getStatus() == null) {
			article.setStatus(1);
		}
		article.setUpdateTime(new Date());
		if (article.getId() != null) {
			update(article);
		} else {
			article.setCreateTime(new Date());
			create(article);
		}
		return article;
	}

	@Override
	public ICommonDao<Article> getDao() {
		return articleDao;
	}

	@Override
	@Transactional
	public Article createTouTiao(ArticleVo article) {
		// type=2 表示头条文章
		article.setType(2);
		article.setUrl(pathConvert.saveFileFromTemp(article.getUrl(),folderName));
		Article sv = save(article);

		if (!Strings.isNullOrEmpty(article.getTagStr())) {
			//delete binding relationship
			bindDao.deleteByArticleId(sv.getId());

			String[] names = article.getTagStr().split(",|，");
			for (String name : names) {
				name = name.trim();
				// check tag if not exist create
				ArticleTag tag = articleTagDao.findByName(name);
				if (tag == null) {
					tag = new ArticleTag();
					tag.setName(name);
					tag.setStatus(1);
					tag.setSort(0);
					tag.setCreateTime(new Date());
					articleTagDao.create(tag);
				}
				ArticleTagBind bind = new ArticleTagBind();
				bind.setArticleId(sv.getId());
				bind.setTagId(tag.getId());
				bindDao.create(bind);
			}
		}
		return sv;
	}

	@Override
	@Transactional
	public Article createCMS(Article article) {
		// type=1 表示CRM文章
		article.setType(1);
		return save(article);
	}

	@Override
	public List<ArticleTagVo> tags() {
		ArticleTagVo tagVo = new ArticleTagVo();
		tagVo.setStatus(1);
		return articleTagDao.findByParams(tagVo);
	}

	@Override
	public PageInfo<ArticleVo> headlinesList(ArticleVo articleVo, Integer pageNum, Integer pageSize) {
		articleVo.setType(2);
		PageInfo<ArticleVo>  pageInfo = findByParams(articleVo, pageNum, pageSize);
		pageInfo.getList().forEach(article ->{
			article.setTagStr(bindDao.findTagsByArticleId(article.getId()));
			//c.setThumbnailUrl(pathConvert.getUrl(c.getThumbnailUrl()));
			article.setUrl(pathConvert.getUrl(article.getUrl()));
		});
		return pageInfo;
	}

	@Override
	public ArticleVo findVoById(Integer id) {
		Article article = findById(id);
		ArticleVo vo = new ArticleVo();
		ClazzUtil.copy(article,vo);
		vo.setTagStr(bindDao.findTagsByArticleId(article.getId()));
		return vo;
	}

	@Override
	public PageInfo<ArticleVo> headlinesListByTagId(Integer tagId, Integer pageNum, Integer pageSize) {
		if (pageNum == null || pageSize == null){
			pageNum = 1;
			pageSize = 10;
		}
		PageInfo<ArticleVo> page;
		if (tagId != null) {
			PageHelper.startPage(pageNum, pageSize);
			List<ArticleVo> list = articleDao.headlinesListByTagId(tagId);
			page = new PageInfo(list);
			page.getList().forEach(article -> {
				article.setTagStr(bindDao.findTagsByArticleId(article.getId()));
				article.setUrl(pathConvert.getUrl(article.getUrl()));
			});
		} else {
			ArticleVo vo = new ArticleVo();
			vo.setStatus(1);
			page = headlinesList(vo,pageNum,pageSize);
		}
		return page;
	}

	@Override
	public ArticleTag findTagByName(String name) {
		return articleTagDao.findByName(name);
	}
}
