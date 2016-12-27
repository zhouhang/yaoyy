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
		OrderInvoiceVo vo = new OrderInvoiceVo();
		vo.setOrderId(orderId);
		List<OrderInvoiceVo> list = orderInvoiceDao.findByParams(vo);
		return list.size()>0?list.get(0):null;
	}

	@Override
	public Integer save(OrderInvoice invoice) {
		//检查订单Id 对应的发票是否已经存在
		//存在就更新,不存在就给订单创建新的发票
		//检查该订单属于属于当前用户
		if (invoice.getId()== null){
			super.create(invoice);
		} else {
			super.update(invoice);
		}
		return invoice.getId();
	}

	@Override
	public ICommonDao<OrderInvoice> getDao() {
		return orderInvoiceDao;
	}

}
