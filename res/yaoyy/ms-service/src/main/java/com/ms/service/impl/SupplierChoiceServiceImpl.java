package com.ms.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.ms.dao.ICommonDao;
import com.ms.dao.SupplierChoiceDao;
import com.ms.dao.model.SupplierChoice;
import com.ms.dao.vo.SupplierChoiceVo;
import com.ms.service.SupplierChoiceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class SupplierChoiceServiceImpl  extends AbsCommonService<SupplierChoice> implements SupplierChoiceService{

	@Autowired
	private SupplierChoiceDao supplierChoiceDao;


	@Override
	public PageInfo<SupplierChoiceVo> findByParams(SupplierChoiceVo supplierChoiceVo,Integer pageNum,Integer pageSize) {
    PageHelper.startPage(pageNum, pageSize);
    	List<SupplierChoiceVo>  list = supplierChoiceDao.findByParams(supplierChoiceVo);
        PageInfo page = new PageInfo(list);
        return page;
	}


	@Override
	public ICommonDao<SupplierChoice> getDao() {
		return supplierChoiceDao;
	}

}
