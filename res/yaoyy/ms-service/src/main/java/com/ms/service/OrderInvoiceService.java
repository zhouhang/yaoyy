package com.ms.service;

import com.github.pagehelper.PageInfo;
import com.ms.dao.model.OrderInvoice;
import com.ms.dao.vo.OrderInvoiceVo;

public interface OrderInvoiceService extends ICommonService<OrderInvoice>{

    public PageInfo<OrderInvoiceVo> findByParams(OrderInvoiceVo orderInvoiceVo,Integer pageNum,Integer pageSize);

    /**
     * 根据订单Id 获取订单发票详情
     * @param orderId
     * @return
     */
    OrderInvoiceVo findByOrderId(Integer orderId);

    /**
     * 保存或者更新发票信息
     * @param invoice
     * @return
     */
    Integer save(OrderInvoice invoice);
}
