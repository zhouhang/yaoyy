package com.ms.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.ms.dao.ICommonDao;
import com.ms.dao.OrderInvoiceDao;
import com.ms.dao.model.OrderInvoice;
import com.ms.dao.vo.OrderInvoiceVo;
import com.ms.service.OrderInvoiceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class OrderInvoiceServiceImpl  extends AbsCommonService<OrderInvoice> implements OrderInvoiceService{

	@Autowired
	private OrderInvoiceDao orderInvoiceDao;


	@Override
	public PageInfo<OrderInvoiceVo> findByParams(OrderInvoiceVo orderInvoiceVo,Integer pageNum,Integer pageSize) {
    PageHelper.startPage(pageNum, pageSize);
    	List<OrderInvoiceVo>  list = orderInvoiceDao.findByParams(orderInvoiceVo);
        PageInfo page = new PageInfo(list);
        return page;
	}

	@Override
	public OrderInvoiceVo findByOrderId(Integer orderId) {
		return null;
	}

	@Override
	public Integer save(OrderInvoice invoice) {
		return null;
	}

	@Override
	public ICommonDao<OrderInvoice> getDao() {
		return orderInvoiceDao;
	}

}
