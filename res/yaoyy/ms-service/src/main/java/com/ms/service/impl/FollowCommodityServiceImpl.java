package com.ms.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.ms.dao.ICommonDao;
import com.ms.dao.FollowCommodityDao;
import com.ms.dao.model.Commodity;
import com.ms.dao.model.FollowCommodity;
import com.ms.dao.vo.FollowCommodityVo;
import com.ms.service.CommodityService;
import com.ms.service.FollowCommodityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Service
public class FollowCommodityServiceImpl  extends AbsCommonService<FollowCommodity> implements FollowCommodityService{

	@Autowired
	private FollowCommodityDao followCommodityDao;

	@Autowired
	private CommodityService commodityService;

	@Override
	public PageInfo<FollowCommodityVo> findByParams(FollowCommodityVo followCommodityVo,Integer pageNum,Integer pageSize) {
		if (pageNum == null || pageSize == null) {
			pageNum = 1;
			pageSize = 10;
		}
    	PageHelper.startPage(pageNum, pageSize);
    	List<FollowCommodityVo>  list = followCommodityDao.findByParams(followCommodityVo);
        PageInfo page = new PageInfo(list);
        return page;
	}

	@Override
	@Transactional
	public void watch(Integer commodityId, Integer userId) {
		//TODO: 需检查商品有没有意见被关注,或者设置联合主键
		Commodity commodity = commodityService.findById(commodityId);
		FollowCommodity follow = new FollowCommodity();
		follow.setUserId(userId);
		follow.setPrice(commodity.getPrice());
		follow.setCommodityId(commodityId);
		follow.setCreateTime(new Date());
		followCommodityDao.create(follow);
	}

	@Override
	@Transactional
	public void unwatch(Integer followId, Integer commodityId, Integer userId) {
		followCommodityDao.unwatch(followId,commodityId,userId);
	}

	@Override
	public Integer count(Integer userId) {
		return followCommodityDao.count(userId);
	}

	@Override
	public List<FollowCommodityVo> findCommodity(Integer userId) {
		FollowCommodityVo vo = new FollowCommodityVo();
		vo.setUserId(userId);
		return followCommodityDao.findByParams(vo);
	}

	@Override
	public List<Integer> findCommodityIds(Integer userId) {
		FollowCommodityVo vo = new FollowCommodityVo();
		vo.setUserId(userId);
		 List<FollowCommodityVo> list = followCommodityDao.findByParams(vo);
		List<Integer> followIds = new ArrayList<>();
		list.forEach(follow ->{followIds.add(follow.getCommodityId());});
		return followIds;
	}

	@Override
	public ICommonDao<FollowCommodity> getDao() {
		return followCommodityDao;
	}

}
