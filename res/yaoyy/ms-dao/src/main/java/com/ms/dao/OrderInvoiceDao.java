package com.ms.dao;

import com.ms.dao.config.AutoMapper;
import com.ms.dao.model.OrderInvoice;
import com.ms.dao.vo.OrderInvoiceVo;

import java.util.List;
@AutoMapper
public interface OrderInvoiceDao extends ICommonDao<OrderInvoice>{

    public List<OrderInvoiceVo> findByParams(OrderInvoiceVo orderInvoiceVo);

}
