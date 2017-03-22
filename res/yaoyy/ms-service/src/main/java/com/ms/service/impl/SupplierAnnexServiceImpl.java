package com.ms.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.ms.dao.ICommonDao;
import com.ms.dao.SupplierAnnexDao;
import com.ms.dao.model.SupplierAnnex;
import com.ms.dao.vo.SupplierAnnexVo;
import com.ms.service.SupplierAnnexService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class SupplierAnnexServiceImpl  extends AbsCommonService<SupplierAnnex> implements SupplierAnnexService{

	@Autowired
	private SupplierAnnexDao supplierAnnexDao;


	@Override
	public PageInfo<SupplierAnnexVo> findByParams(SupplierAnnexVo supplierAnnexVo,Integer pageNum,Integer pageSize) {
    PageHelper.startPage(pageNum, pageSize);
    	List<SupplierAnnexVo>  list = supplierAnnexDao.findByParams(supplierAnnexVo);
        PageInfo page = new PageInfo(list);
        return page;
	}


	@Override
	public ICommonDao<SupplierAnnex> getDao() {
		return supplierAnnexDao;
	}

}
