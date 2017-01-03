package com.ms.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.ms.dao.ICommonDao;
import com.ms.dao.AccountBillDao;
import com.ms.dao.model.AccountBill;
import com.ms.dao.vo.AccountBillVo;
import com.ms.dao.vo.PickVo;
import com.ms.service.AccountBillService;
import com.ms.service.PickService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class AccountBillServiceImpl  extends AbsCommonService<AccountBill> implements AccountBillService{

	@Autowired
	private AccountBillDao accountBillDao;

	@Autowired
	private PickService  pickService;


	@Override
	public PageInfo<AccountBillVo> findByParams(AccountBillVo accountBillVo,Integer pageNum,Integer pageSize) {
		pageNum = pageNum==null?1:pageNum;
		pageSize = pageSize==null?10:pageSize;
        PageHelper.startPage(pageNum, pageSize);
    	List<AccountBillVo>  list = accountBillDao.findByParams(accountBillVo);
        PageInfo page = new PageInfo(list);
        return page;
	}

	@Override
	public AccountBillVo findVoById(Integer id) {
		AccountBillVo accountBillVo=accountBillDao.findVoById(id);
		if(accountBillVo!=null){
			PickVo pickVo=pickService.findVoById(accountBillVo.getOrderId());
			accountBillVo.setPickVo(pickVo);
		}
		return accountBillVo;
	}


	@Override
	public ICommonDao<AccountBill> getDao() {
		return accountBillDao;
	}

}
