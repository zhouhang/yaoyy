package com.ms.dao;

import com.ms.dao.config.AutoMapper;
import com.ms.dao.model.CommodityBatch;
import com.ms.dao.vo.CommodityBatchVo;

import java.util.List;
@AutoMapper
public interface CommodityBatchDao extends ICommonDao<CommodityBatch>{

    public List<CommodityBatchVo> findByParams(CommodityBatchVo commodityBatchVo);

    Integer batchInsert(List<CommodityBatch> list);
}
