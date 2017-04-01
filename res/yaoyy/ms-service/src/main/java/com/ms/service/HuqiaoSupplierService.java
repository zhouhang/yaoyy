package com.ms.service;

import com.github.pagehelper.PageInfo;
import com.ms.dao.model.HuqiaoSupplier;
import com.ms.dao.vo.HuqiaoSupplierVo;

public interface HuqiaoSupplierService extends ICommonService<HuqiaoSupplier>{

    public PageInfo<HuqiaoSupplierVo> findByParams(HuqiaoSupplierVo huqiaoSupplierVo, Integer pageNum, Integer pageSize);
}
