package com.ms.service;

import com.github.pagehelper.PageInfo;
import com.ms.dao.model.Area;
import com.ms.dao.vo.AreaVo;

public interface AreaService extends ICommonService<Area>{

    public PageInfo<AreaVo> findByParams(AreaVo areaVo,Integer pageNum,Integer pageSize);
}
