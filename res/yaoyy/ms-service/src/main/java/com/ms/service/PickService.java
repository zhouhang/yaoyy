package com.ms.service;

import com.github.pagehelper.PageInfo;
import com.ms.dao.model.Member;
import com.ms.dao.model.Pick;
import com.ms.dao.model.PickCommodity;
import com.ms.dao.vo.LogisticalVo;
import com.ms.dao.vo.PaymentVo;
import com.ms.dao.vo.PickVo;

import java.util.List;

public interface PickService extends ICommonService<Pick>{

    public PageInfo<PickVo> findByParams(PickVo pickVo,Integer pageNum,Integer pageSize);

    public PickVo findVoById(Integer id);

    /**
     * 保存用户提交的订单申请
     * @param pickVo
     */
    public void save(PickVo pickVo);

    /**
     * 为用户生成订单(客服确认订单)
     * @param pickVo
     */
    public void createOrder(PickVo pickVo);

    /**
     * 保存用户提交的订单确认信息
     * 收货地址,发票,备注等
     * @param pickVo
     */
    public void saveOrder(PickVo pickVo);

    /**
     * 更改订单状态
     * @param id
     * @param status
     */
    public void changeOrderStatus(Integer id,Integer status);

    /**
     * 前台用户取消订单
     * @param id
     * @param userId
     */
    public void cancel(Integer id, Integer userId);

    /**
     * 前台用户确认收货
     * @param id
     * @param userId
     */
    public void receipt(Integer id, Integer userId);


    /**
     * 更新商品数量
     * @param pickCommodities
     *
     */
    public void updateCommodityNum(List<PickCommodity> pickCommodities);


    /**
     * 确认发货
     * @param logisticalVo
     */
    public void delivery(LogisticalVo logisticalVo,Member mem);

    /**
     * 三方支付回调处理
     */

    public void handlePay(PaymentVo payment);



}
