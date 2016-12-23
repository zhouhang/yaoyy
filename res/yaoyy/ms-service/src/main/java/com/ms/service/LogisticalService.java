package com.ms.service;

import com.github.pagehelper.PageInfo;
import com.ms.dao.model.Logistical;
import com.ms.dao.vo.LogisticalVo;

public interface LogisticalService extends ICommonService<Logistical>{

    public PageInfo<LogisticalVo> findByParams(LogisticalVo logisticalVo,Integer pageNum,Integer pageSize);
}
