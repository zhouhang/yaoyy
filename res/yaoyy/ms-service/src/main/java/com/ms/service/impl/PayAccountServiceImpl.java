package com.ms.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.ms.dao.ICommonDao;
import com.ms.dao.PayAccountDao;
import com.ms.dao.model.PayAccount;
import com.ms.dao.vo.PayAccountVo;
import com.ms.service.PayAccountService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class PayAccountServiceImpl  extends AbsCommonService<PayAccount> implements PayAccountService{

	@Autowired
	private PayAccountDao payAccountDao;


	@Override
	public PageInfo<PayAccountVo> findByParams(PayAccountVo payAccountVo,Integer pageNum,Integer pageSize) {
    PageHelper.startPage(pageNum, pageSize);
    	List<PayAccountVo>  list = payAccountDao.findByParams(payAccountVo);
        PageInfo page = new PageInfo(list);
        return page;
	}


	@Override
	public ICommonDao<PayAccount> getDao() {
		return payAccountDao;
	}

}
