package com.ms.dao;

import com.ms.dao.config.AutoMapper;
import com.ms.dao.model.Pick;
import com.ms.dao.model.Supplier;
import com.ms.dao.vo.PickVo;
import com.ms.dao.vo.SupplierOrderVo;

import java.util.List;
@AutoMapper
public interface PickDao extends ICommonDao<Pick>{

    public List<PickVo> findByParams(PickVo pickVo);

    public PickVo findVoById(Integer id);


    /**
     * 根据参数查询寄卖下单的订单
     * @param vo
     * @return
     */
    List<SupplierOrderVo> queryForSupplier(SupplierOrderVo vo);

}
