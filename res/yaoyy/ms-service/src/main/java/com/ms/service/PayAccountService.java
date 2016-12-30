package com.ms.service;

import com.github.pagehelper.PageInfo;
import com.ms.dao.model.PayAccount;
import com.ms.dao.vo.PayAccountVo;

public interface PayAccountService extends ICommonService<PayAccount>{

    public PageInfo<PayAccountVo> findByParams(PayAccountVo payAccountVo,Integer pageNum,Integer pageSize);
}
