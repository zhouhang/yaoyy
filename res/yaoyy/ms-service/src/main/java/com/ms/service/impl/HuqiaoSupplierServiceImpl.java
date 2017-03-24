package com.ms.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.ms.dao.ICommonDao;
import com.ms.dao.HuqiaoSupplierDao;
import com.ms.dao.model.HuqiaoSupplier;
import com.ms.dao.vo.HuqiaoSupplierVo;
import com.ms.service.HuqiaoSupplierService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class HuqiaoSupplierServiceImpl  extends AbsCommonService<HuqiaoSupplier> implements HuqiaoSupplierService{

	@Autowired
	private HuqiaoSupplierDao huqiaoSupplierDao;


	@Override
	public PageInfo<HuqiaoSupplierVo> findByParams(HuqiaoSupplierVo huqiaoSupplierVo,Integer pageNum,Integer pageSize) {
    PageHelper.startPage(pageNum, pageSize);
    	List<HuqiaoSupplierVo>  list = huqiaoSupplierDao.findByParams(huqiaoSupplierVo);
        PageInfo page = new PageInfo(list);
        return page;
	}


	@Override
	public ICommonDao<HuqiaoSupplier> getDao() {
		return huqiaoSupplierDao;
	}

}
