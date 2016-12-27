package com.ms.dao;

import com.ms.dao.config.AutoMapper;
import com.ms.dao.model.PayRecord;
import com.ms.dao.vo.PayRecordVo;

import java.util.List;
@AutoMapper
public interface PayRecordDao extends ICommonDao<PayRecord>{

    public List<PayRecordVo> findByParams(PayRecordVo payRecordVo);

    public PayRecordVo findVoById(Integer id);

}
