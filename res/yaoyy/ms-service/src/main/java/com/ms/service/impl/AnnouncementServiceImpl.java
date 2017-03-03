package com.ms.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.ms.dao.ICommonDao;
import com.ms.dao.AnnouncementDao;
import com.ms.dao.model.Announcement;
import com.ms.dao.vo.AnnouncementVo;
import com.ms.service.AnnouncementService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class AnnouncementServiceImpl  extends AbsCommonService<Announcement> implements AnnouncementService{

	@Autowired
	private AnnouncementDao announcementDao;


	@Override
	public PageInfo<AnnouncementVo> findByParams(AnnouncementVo announcementVo,Integer pageNum,Integer pageSize) {
    	PageHelper.startPage(pageNum, pageSize);
    	List<AnnouncementVo>  list = announcementDao.findByParams(announcementVo);
        PageInfo page = new PageInfo(list);
        return page;
	}


	@Override
	public ICommonDao<Announcement> getDao() {
		return announcementDao;
	}

}
