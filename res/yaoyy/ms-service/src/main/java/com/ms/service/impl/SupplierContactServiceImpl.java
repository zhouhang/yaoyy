package com.ms.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.ms.dao.ICommonDao;
import com.ms.dao.SupplierContactDao;
import com.ms.dao.model.SupplierContact;
import com.ms.dao.vo.SupplierContactVo;
import com.ms.service.SupplierContactService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class SupplierContactServiceImpl  extends AbsCommonService<SupplierContact> implements SupplierContactService{

	@Autowired
	private SupplierContactDao supplierContactDao;


	@Override
	public PageInfo<SupplierContactVo> findByParams(SupplierContactVo supplierContactVo,Integer pageNum,Integer pageSize) {
    PageHelper.startPage(pageNum, pageSize);
    	List<SupplierContactVo>  list = supplierContactDao.findByParams(supplierContactVo);
        PageInfo page = new PageInfo(list);
        return page;
	}


	@Override
	public ICommonDao<SupplierContact> getDao() {
		return supplierContactDao;
	}

}
