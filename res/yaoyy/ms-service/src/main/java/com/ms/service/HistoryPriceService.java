package com.ms.service;

import com.github.pagehelper.PageInfo;
import com.ms.dao.model.HistoryPrice;
import com.ms.dao.vo.HistoryPriceVo;

public interface HistoryPriceService extends ICommonService<HistoryPrice>{

    public PageInfo<HistoryPriceVo> findByParams(HistoryPriceVo historyPriceVo,Integer pageNum,Integer pageSize);
}
