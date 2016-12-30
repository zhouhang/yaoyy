package com.ms.service;

import com.github.pagehelper.PageInfo;
import com.ms.dao.model.HistoryPrice;
import com.ms.dao.vo.HistoryPriceVo;

import java.util.List;
import java.util.Map;

public interface HistoryPriceService extends ICommonService<HistoryPrice>{

    public PageInfo<HistoryPriceVo> findByParams(HistoryPriceVo historyPriceVo,Integer pageNum,Integer pageSize);

    /**
     * 根据商品Id 查询进三个月的历史价格
     * @param commodityId
     * @return
     */
    public Map<String,String> findByCommodityId(Integer commodityId);

    Integer save(HistoryPrice historyPrice);
}
