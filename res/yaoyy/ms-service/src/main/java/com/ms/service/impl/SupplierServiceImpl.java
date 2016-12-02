package com.ms.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.ms.dao.ICommonDao;
import com.ms.dao.SupplierDao;
import com.ms.dao.model.Supplier;
import com.ms.dao.vo.SupplierVo;
import com.ms.service.SupplierService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class SupplierServiceImpl  extends AbsCommonService<Supplier> implements SupplierService{

	@Autowired
	private SupplierDao supplierDao;


	@Override
	public PageInfo<SupplierVo> findByParams(SupplierVo supplierVo,Integer pageNum,Integer pageSize) {
    PageHelper.startPage(pageNum, pageSize);
    	List<SupplierVo>  list = supplierDao.findByParams(supplierVo);
        PageInfo page = new PageInfo(list);
        return page;
	}


	@Override
	public ICommonDao<Supplier> getDao() {
		return supplierDao;
	}

}
