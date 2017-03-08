package com.ms.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.ms.dao.ICommonDao;
import com.ms.dao.UserAnnexDao;
import com.ms.dao.model.UserAnnex;
import com.ms.dao.vo.UserAnnexVo;
import com.ms.service.UserAnnexService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class UserAnnexServiceImpl  extends AbsCommonService<UserAnnex> implements UserAnnexService{

	@Autowired
	private UserAnnexDao userAnnexDao;


	@Override
	public PageInfo<UserAnnexVo> findByParams(UserAnnexVo userAnnexVo,Integer pageNum,Integer pageSize) {
    PageHelper.startPage(pageNum, pageSize);
    	List<UserAnnexVo>  list = userAnnexDao.findByParams(userAnnexVo);
        PageInfo page = new PageInfo(list);
        return page;
	}


	@Override
	public ICommonDao<UserAnnex> getDao() {
		return userAnnexDao;
	}

}
