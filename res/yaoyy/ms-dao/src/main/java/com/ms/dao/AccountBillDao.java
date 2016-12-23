package com.ms.dao;


import com.ms.dao.config.AutoMapper;
import com.ms.dao.model.AccountBill;
import com.ms.dao.vo.AccountBillVo;

import java.util.List;
@AutoMapper
public interface AccountBillDao extends ICommonDao<AccountBill>{

    public List<AccountBillVo> findByParams(AccountBillVo accountBillVo);

}
