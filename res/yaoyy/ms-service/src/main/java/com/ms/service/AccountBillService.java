package com.ms.service;

import com.github.pagehelper.PageInfo;
import com.ms.dao.model.AccountBill;
import com.ms.dao.vo.AccountBillVo;

public interface AccountBillService extends ICommonService<AccountBill>{

    public PageInfo<AccountBillVo> findByParams(AccountBillVo accountBillVo,Integer pageNum,Integer pageSize);
}
