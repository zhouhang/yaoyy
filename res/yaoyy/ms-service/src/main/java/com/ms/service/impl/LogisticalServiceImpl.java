package com.ms.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.ms.dao.ICommonDao;
import com.ms.dao.LogisticalDao;
import com.ms.dao.model.Logistical;
import com.ms.dao.vo.LogisticalVo;
import com.ms.service.LogisticalService;
import com.ms.tools.upload.PathConvert;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;

@Service
public class LogisticalServiceImpl  extends AbsCommonService<Logistical> implements LogisticalService{

	@Autowired
	private LogisticalDao logisticalDao;
	@Autowired
	private PathConvert pathConvert;

	private String folderName = "logistical/";

	@Override
	public PageInfo<LogisticalVo> findByParams(LogisticalVo logisticalVo,Integer pageNum,Integer pageSize) {
    PageHelper.startPage(pageNum, pageSize);
    	List<LogisticalVo>  list = logisticalDao.findByParams(logisticalVo);
        PageInfo page = new PageInfo(list);
        return page;
	}

	@Override
	public LogisticalVo findByOrderId(Integer orderId) {
		LogisticalVo logisticalVo=logisticalDao.findByOrderId(orderId);
		if(logisticalVo!=null){
			logisticalVo.setPictureUrl(pathConvert.getUrl(logisticalVo.getPictureUrl()));
		}
		return logisticalVo;
	}

	@Override
	@Transactional
	public void save(LogisticalVo logisticalVo) {
		logisticalVo.setPictureUrl(pathConvert.saveFileFromTemp(logisticalVo.getPictureUrl(),folderName));
		logisticalVo.setCreateDate(new Date());
		logisticalDao.create(logisticalVo);
	}


	@Override
	public ICommonDao<Logistical> getDao() {
		return logisticalDao;
	}

}
