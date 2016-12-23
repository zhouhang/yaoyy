package com.ms.service;

import com.github.pagehelper.PageInfo;
import com.ms.dao.model.OrderInvoice;
import com.ms.dao.vo.OrderInvoiceVo;

public interface OrderInvoiceService extends ICommonService<OrderInvoice>{

    public PageInfo<OrderInvoiceVo> findByParams(OrderInvoiceVo orderInvoiceVo,Integer pageNum,Integer pageSize);
}
