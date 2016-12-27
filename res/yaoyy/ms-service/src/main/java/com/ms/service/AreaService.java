package com.ms.service;

import com.github.pagehelper.PageInfo;
import com.ms.dao.model.Area;
import com.ms.dao.vo.AreaVo;

import java.util.List;

public interface AreaService extends ICommonService<Area>{

    public PageInfo<AreaVo> findByParams(AreaVo areaVo,Integer pageNum,Integer pageSize);

    /**
     * 获取省,市,区的列表
     * null 值返回所有的省份列表
     * @return
     */
    public List<Area> findByParent(Integer parentId);

    /**
     * 根据ID 查询城市的省市区完整信息
     * @param id
     * @return
     */
    public AreaVo findVoById(Integer id);
}
