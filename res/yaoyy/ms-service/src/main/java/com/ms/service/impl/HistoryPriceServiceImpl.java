package com.ms.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.ms.dao.ICommonDao;
import com.ms.dao.HistoryPriceDao;
import com.ms.dao.model.HistoryPrice;
import com.ms.dao.vo.HistoryPriceVo;
import com.ms.service.HistoryPriceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class HistoryPriceServiceImpl  extends AbsCommonService<HistoryPrice> implements HistoryPriceService{

	@Autowired
	private HistoryPriceDao historyPriceDao;


	@Override
	public PageInfo<HistoryPriceVo> findByParams(HistoryPriceVo historyPriceVo,Integer pageNum,Integer pageSize) {
    PageHelper.startPage(pageNum, pageSize);
    	List<HistoryPriceVo>  list = historyPriceDao.findByParams(historyPriceVo);
        PageInfo page = new PageInfo(list);
        return page;
	}


	@Override
	public ICommonDao<HistoryPrice> getDao() {
		return historyPriceDao;
	}

}
