package com.ms.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.ms.dao.ICommonDao;
import com.ms.dao.SupplierCommodityDao;
import com.ms.dao.model.SupplierCommodity;
import com.ms.dao.vo.SupplierCommodityVo;
import com.ms.service.SupplierCommodityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class SupplierCommodityServiceImpl  extends AbsCommonService<SupplierCommodity> implements SupplierCommodityService{

	@Autowired
	private SupplierCommodityDao supplierCommodityDao;


	@Override
	public PageInfo<SupplierCommodityVo> findByParams(SupplierCommodityVo supplierCommodityVo,Integer pageNum,Integer pageSize) {
    PageHelper.startPage(pageNum, pageSize);
    	List<SupplierCommodityVo>  list = supplierCommodityDao.findByParams(supplierCommodityVo);
        PageInfo page = new PageInfo(list);
        return page;
	}


	@Override
	public ICommonDao<SupplierCommodity> getDao() {
		return supplierCommodityDao;
	}

}
