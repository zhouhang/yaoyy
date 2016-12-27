package com.ms.service;

import com.github.pagehelper.PageInfo;
import com.ms.dao.model.Pick;
import com.ms.dao.vo.PickVo;

public interface PickService extends ICommonService<Pick>{

    public PageInfo<PickVo> findByParams(PickVo pickVo,Integer pageNum,Integer pageSize);

    public PickVo findVoById(Integer id);

    public void save(PickVo pickVo);

    /**
     *为用户生成订单
     * @param pickVo
     */
    public void createOrder(PickVo pickVo);


    /**
     * 更改订单状态
     * @param id
     * @param status
     */
    public void changeOrderStatus(Integer id,Integer status);
}
