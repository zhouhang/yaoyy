package com.ms.dao;

import com.ms.dao.config.AutoMapper;
import com.ms.dao.model.Logistical;
import com.ms.dao.vo.LogisticalVo;

import java.util.List;
@AutoMapper
public interface LogisticalDao extends ICommonDao<Logistical>{

    public List<LogisticalVo> findByParams(LogisticalVo logisticalVo);

    public LogisticalVo findByOrderId(Integer orderId);

}
