package com.ms.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.ms.dao.ICommonDao;
import com.ms.dao.QuotationDao;
import com.ms.dao.model.Quotation;
import com.ms.dao.vo.QuotationVo;
import com.ms.service.QuotationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class QuotationServiceImpl  extends AbsCommonService<Quotation> implements QuotationService{

	@Autowired
	private QuotationDao quotationDao;


	@Override
	public PageInfo<QuotationVo> findByParams(QuotationVo quotationVo,Integer pageNum,Integer pageSize) {
    PageHelper.startPage(pageNum, pageSize);
    	List<QuotationVo>  list = quotationDao.findByParams(quotationVo);
        PageInfo page = new PageInfo(list);
        return page;
	}


	@Override
	public ICommonDao<Quotation> getDao() {
		return quotationDao;
	}

}
