package com.ms.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.ms.dao.ICommonDao;
import com.ms.dao.LogisticalDao;
import com.ms.dao.model.Logistical;
import com.ms.dao.vo.LogisticalVo;
import com.ms.service.LogisticalService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class LogisticalServiceImpl  extends AbsCommonService<Logistical> implements LogisticalService{

	@Autowired
	private LogisticalDao logisticalDao;


	@Override
	public PageInfo<LogisticalVo> findByParams(LogisticalVo logisticalVo,Integer pageNum,Integer pageSize) {
    PageHelper.startPage(pageNum, pageSize);
    	List<LogisticalVo>  list = logisticalDao.findByParams(logisticalVo);
        PageInfo page = new PageInfo(list);
        return page;
	}


	@Override
	public ICommonDao<Logistical> getDao() {
		return logisticalDao;
	}

}
