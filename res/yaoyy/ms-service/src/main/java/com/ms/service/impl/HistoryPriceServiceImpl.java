package com.ms.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.ms.dao.ICommonDao;
import com.ms.dao.HistoryPriceDao;
import com.ms.dao.model.HistoryPrice;
import com.ms.dao.vo.HistoryPriceVo;
import com.ms.service.HistoryPriceService;
import com.ms.tools.utils.GsonUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.ZoneOffset;
import java.util.*;

@Service
public class HistoryPriceServiceImpl  extends AbsCommonService<HistoryPrice> implements HistoryPriceService{

	@Autowired
	private HistoryPriceDao historyPriceDao;


	@Override
	public PageInfo<HistoryPriceVo> findByParams(HistoryPriceVo historyPriceVo,Integer pageNum,Integer pageSize) {
    PageHelper.startPage(pageNum, pageSize);
    	List<HistoryPriceVo>  list = historyPriceDao.findByParams(historyPriceVo);
        PageInfo page = new PageInfo(list);
        return page;
	}

	@Override
	public Map<String, String> findByCommodityId(Integer commodityId) {
		HistoryPriceVo historyPriceVo = new HistoryPriceVo();
		historyPriceVo.setCommodityId(commodityId);
		LocalDateTime dateTime = LocalDateTime.now();
		dateTime = dateTime.minusMonths(3);
		Date date = Date.from(dateTime.toInstant(ZoneOffset.UTC));
		historyPriceVo.setValidityDate(date);
		List<HistoryPriceVo>  list = historyPriceDao.findByParams(historyPriceVo);
		Map<String, String> map = new HashMap<>();
		List<Float> value = new ArrayList<>();
		List<String> dateR = new ArrayList<>();
		list.forEach(his -> {
			value.add(his.getPrice());
			SimpleDateFormat sdf = new SimpleDateFormat("MM.dd h:mm");
			dateR.add(sdf.format(his.getCreateTime()));
		});
		map.put("date", GsonUtil.toJson(dateR));
		map.put("value", GsonUtil.toJson(value));
		return map;
	}

	@Override
	public ICommonDao<HistoryPrice> getDao() {
		return historyPriceDao;
	}

}
