package com.ms.service;

import com.github.pagehelper.PageInfo;
import com.ms.dao.model.AccountBill;
import com.ms.dao.vo.AccountBillVo;

import java.util.List;

public interface AccountBillService extends ICommonService<AccountBill>{

    public PageInfo<AccountBillVo> findByParams(AccountBillVo accountBillVo,Integer pageNum,Integer pageSize);

    public AccountBillVo findVoById(Integer id);

    public void saveAccountBill(AccountBillVo accountBillVo);

    public AccountBillVo findVoByOrderId(Integer orderId);

    public PageInfo<AccountBillVo> findByUserId(Integer userId,Integer pageNum,Integer pageSize);
}
