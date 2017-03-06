package com.ms.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.ms.dao.ICommonDao;
import com.ms.dao.AnnouncementDao;
import com.ms.dao.model.Announcement;
import com.ms.dao.vo.AnnouncementVo;
import com.ms.dao.vo.SendSampleVo;
import com.ms.service.AnnouncementService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;

@Service
public class AnnouncementServiceImpl  extends AbsCommonService<Announcement> implements AnnouncementService{

	@Autowired
	private AnnouncementDao announcementDao;


	@Override
	public PageInfo<AnnouncementVo> findByParams(AnnouncementVo announcementVo,Integer pageNum,Integer pageSize) {
		pageNum = pageNum==null?1:pageNum;
		pageSize = pageSize==null?10:pageSize;
    	PageHelper.startPage(pageNum, pageSize);
    	List<AnnouncementVo>  list = announcementDao.findByParams(announcementVo);
        PageInfo page = new PageInfo(list);
        return page;
	}

	@Override
	public AnnouncementVo findDetailById(int id) {
		AnnouncementVo announcementVo=announcementDao.findDetailById(id);
		if(announcementVo==null){
			return null;
		}
		return announcementVo;
	}

	@Override
	@Transactional
	public void save(AnnouncementVo announcementVo) {
		announcementVo.setCreateTime(new Date());
		if (announcementVo.getId() == 0) {
			announcementDao.create(announcementVo);
		}else{
			announcementDao.update(announcementVo);
		}
	}


	@Override
	public ICommonDao<Announcement> getDao() {
		return announcementDao;
	}

}
