package com.ms.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.ms.dao.ICommonDao;
import com.ms.dao.AreaDao;
import com.ms.dao.model.Area;
import com.ms.dao.vo.AreaVo;
import com.ms.service.AreaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class AreaServiceImpl  extends AbsCommonService<Area> implements AreaService{

	@Autowired
	private AreaDao areaDao;


	@Override
	public PageInfo<AreaVo> findByParams(AreaVo areaVo,Integer pageNum,Integer pageSize) {
    PageHelper.startPage(pageNum, pageSize);
    	List<AreaVo>  list = areaDao.findByParams(areaVo);
        PageInfo page = new PageInfo(list);
        return page;
	}

	@Override
	public List<Area> findByParent(Integer parentId) {
		List<Area> list = null;
		if (parentId == null) {
			list = areaDao.findByLevel(1);
		} else {
			list = areaDao.findByParent(parentId);
		}
		return list;
	}

	@Override
	public AreaVo findVoById(Integer id) {
		return areaDao.findVoById(id);
	}

	@Override
	public ICommonDao<Area> getDao() {
		return areaDao;
	}

}
