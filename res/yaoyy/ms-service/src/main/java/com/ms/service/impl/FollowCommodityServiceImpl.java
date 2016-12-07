package com.ms.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.ms.dao.ICommonDao;
import com.ms.dao.FollowCommodityDao;
import com.ms.dao.model.FollowCommodity;
import com.ms.dao.vo.FollowCommodityVo;
import com.ms.service.FollowCommodityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class FollowCommodityServiceImpl  extends AbsCommonService<FollowCommodity> implements FollowCommodityService{

	@Autowired
	private FollowCommodityDao followCommodityDao;


	@Override
	public PageInfo<FollowCommodityVo> findByParams(FollowCommodityVo followCommodityVo,Integer pageNum,Integer pageSize) {
    PageHelper.startPage(pageNum, pageSize);
    	List<FollowCommodityVo>  list = followCommodityDao.findByParams(followCommodityVo);
        PageInfo page = new PageInfo(list);
        return page;
	}

	@Override
	@Transactional
	public void watch(Integer commodityId, Integer userId) {

	}

	@Override
	@Transactional
	public void unwatch(Integer followId, Integer userId) {

	}

	@Override
	public Integer count(Integer userId) {
		return null;
	}

	@Override
	public List<FollowCommodityVo> findCommodity(Integer userId) {
		return null;
	}

	@Override
	public ICommonDao<FollowCommodity> getDao() {
		return followCommodityDao;
	}

}
