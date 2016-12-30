package com.ms.dao;

import com.ms.dao.config.AutoMapper;
import com.ms.dao.model.PayAccount;
import com.ms.dao.vo.PayAccountVo;

import java.util.List;
@AutoMapper
public interface PayAccountDao extends ICommonDao<PayAccount>{

    public List<PayAccountVo> findByParams(PayAccountVo payAccountVo);

}
