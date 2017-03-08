package com.ms.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.ms.dao.ICommonDao;
import com.ms.dao.UserAnnexDao;
import com.ms.dao.model.UserAnnex;
import com.ms.dao.vo.UserAnnexVo;
import com.ms.service.UserAnnexService;
import com.ms.tools.FileUtil;
import com.ms.tools.upload.PathConvert;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;

@Service
public class UserAnnexServiceImpl  extends AbsCommonService<UserAnnex> implements UserAnnexService{

	@Autowired
	private UserAnnexDao userAnnexDao;

	@Autowired
	private PathConvert pathConvert;

	/**
	 * 商品图片保存路径
	 */
	private String folderName = "user/";


	@Override
	public PageInfo<UserAnnexVo> findByParams(UserAnnexVo userAnnexVo,Integer pageNum,Integer pageSize) {
    PageHelper.startPage(pageNum, pageSize);
    	List<UserAnnexVo>  list = userAnnexDao.findByParams(userAnnexVo);
        PageInfo page = new PageInfo(list);
        return page;
	}

	@Override
	public List<UserAnnexVo> findByParamsNoPage(UserAnnexVo userAnnexVo) {
		List<UserAnnexVo> userAnnexVos = userAnnexDao.findByParams(userAnnexVo);
		userAnnexVos.forEach(u->{
			u.setUrl(pathConvert.getUrl(u.getUrl()));
		});
		return userAnnexDao.findByParams(userAnnexVo);
	}

	@Override
	@Transactional
	public void save(UserAnnexVo userAnnexVo) {
		//保存用户附件表
		UserAnnex userAnnex = new UserAnnex();
		userAnnex.setUserId(userAnnexVo.getUserId());
		userAnnex.setUrl(pathConvert.saveFileFromTemp(userAnnexVo.getUrl(),folderName));
		userAnnex.setCreateTime(new Date());
		userAnnexDao.create(userAnnex);
	}

	@Override
	@Transactional
	public void deleteFileById(Integer annexId){
		UserAnnex userAnnex = userAnnexDao.findById(annexId);
		FileUtil.deleteFile(userAnnex.getUrl());
		userAnnexDao.deleteById(annexId);
	}

	@Override
	public ICommonDao<UserAnnex> getDao() {
		return userAnnexDao;
	}

}
