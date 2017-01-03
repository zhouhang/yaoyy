package com.ms.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.ms.dao.ICommonDao;
import com.ms.dao.PaymentDao;
import com.ms.dao.model.Payment;
import com.ms.dao.vo.PaymentVo;
import com.ms.service.PaymentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class PaymentServiceImpl  extends AbsCommonService<Payment> implements PaymentService{

	@Autowired
	private PaymentDao paymentDao;


	@Override
	public PageInfo<PaymentVo> findByParams(PaymentVo paymentVo,Integer pageNum,Integer pageSize) {
    PageHelper.startPage(pageNum, pageSize);
    	List<PaymentVo>  list = paymentDao.findByParams(paymentVo);
        PageInfo page = new PageInfo(list);
        return page;
	}

	@Override
	public PaymentVo getByOutTradeNo(String outTradeNo) {
		return paymentDao.getByOutTradeNo(outTradeNo);
	}


	@Override
	public ICommonDao<Payment> getDao() {
		return paymentDao;
	}

}
