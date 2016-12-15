package com.ms.dao;

import com.ms.dao.config.AutoMapper;
import com.ms.dao.model.HistoryPrice;
import com.ms.dao.vo.HistoryPriceVo;
import org.apache.ibatis.annotations.Param;

import java.util.Date;
import java.util.List;
@AutoMapper
public interface HistoryPriceDao extends ICommonDao<HistoryPrice>{

    public List<HistoryPriceVo> findByParams(HistoryPriceVo historyPriceVo);

    HistoryPrice duplicate(@Param("commodityId")Integer commodityId, @Param("createTime") Date createTime);
}
