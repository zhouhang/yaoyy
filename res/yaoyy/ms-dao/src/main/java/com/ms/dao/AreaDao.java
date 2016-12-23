package com.ms.dao;

import com.ms.dao.config.AutoMapper;
import com.ms.dao.model.Area;
import com.ms.dao.vo.AreaVo;

import java.util.List;
@AutoMapper
public interface AreaDao extends ICommonDao<Area>{

    public List<AreaVo> findByParams(AreaVo areaVo);

}
