package com.ms.dao;

import com.ms.dao.config.AutoMapper;
import com.ms.dao.model.HuqiaoSupplier;
import com.ms.dao.vo.HuqiaoSupplierVo;

import java.util.List;
@AutoMapper
public interface HuqiaoSupplierDao extends ICommonDao<HuqiaoSupplier>{

    public List<HuqiaoSupplierVo> findByParams(HuqiaoSupplierVo huqiaoSupplierVo);

}
