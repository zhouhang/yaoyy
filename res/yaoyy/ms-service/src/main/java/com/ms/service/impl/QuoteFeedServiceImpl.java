package com.ms.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.ms.dao.ICommonDao;
import com.ms.dao.QuoteFeedDao;
import com.ms.dao.model.QuoteFeed;
import com.ms.dao.vo.QuoteFeedVo;
import com.ms.service.QuoteFeedService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class QuoteFeedServiceImpl  extends AbsCommonService<QuoteFeed> implements QuoteFeedService{

	@Autowired
	private QuoteFeedDao quoteFeedDao;


	@Override
	public PageInfo<QuoteFeedVo> findByParams(QuoteFeedVo quoteFeedVo,Integer pageNum,Integer pageSize) {
		pageNum = pageNum==null?1:pageNum;
		pageSize = pageSize==null?10:pageSize;
        PageHelper.startPage(pageNum, pageSize);
    	List<QuoteFeedVo>  list = quoteFeedDao.findByParams(quoteFeedVo);
        PageInfo page = new PageInfo(list);
        return page;
	}


	@Override
	public ICommonDao<QuoteFeed> getDao() {
		return quoteFeedDao;
	}

}
