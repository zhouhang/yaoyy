package com.ms.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.ms.dao.ICommonDao;
import com.ms.dao.ShippingAddressHistoryDao;
import com.ms.dao.model.ShippingAddressHistory;
import com.ms.dao.vo.ShippingAddressHistoryVo;
import com.ms.service.ShippingAddressHistoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class ShippingAddressHistoryServiceImpl  extends AbsCommonService<ShippingAddressHistory> implements ShippingAddressHistoryService{

	@Autowired
	private ShippingAddressHistoryDao shippingAddressHistoryDao;


	@Override
	public PageInfo<ShippingAddressHistoryVo> findByParams(ShippingAddressHistoryVo shippingAddressHistoryVo,Integer pageNum,Integer pageSize) {
    PageHelper.startPage(pageNum, pageSize);
    	List<ShippingAddressHistoryVo>  list = shippingAddressHistoryDao.findByParams(shippingAddressHistoryVo);
        PageInfo page = new PageInfo(list);
        return page;
	}


	@Override
	public ICommonDao<ShippingAddressHistory> getDao() {
		return shippingAddressHistoryDao;
	}

}
