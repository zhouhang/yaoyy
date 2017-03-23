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
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
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
	public List<SupplierCommodityVo> findBySupplierId(Integer supplierId) {

		SupplierCommodityVo param=new SupplierCommodityVo();
		param.setSupplierId(supplierId);
		List<SupplierCommodityVo>  list = supplierCommodityDao.findByParams(param);

		return list;
	}

	@Override
	@Transactional
	public void save(SupplierCommodityVo supplierCommodityVo) {
		Date now =new Date();
		if(supplierCommodityVo.getId()==null){
			supplierCommodityVo.setCreateTime(now);
			supplierCommodityDao.create(supplierCommodityVo);
		}else{
			supplierCommodityDao.update(supplierCommodityVo);
		}
	}


	@Override
	public ICommonDao<SupplierCommodity> getDao() {
		return supplierCommodityDao;
	}

}
