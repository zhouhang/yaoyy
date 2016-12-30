package com.ms.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.ms.dao.ICommonDao;
import com.ms.dao.HistoryPriceDao;
import com.ms.dao.model.Commodity;
import com.ms.dao.model.HistoryPrice;
import com.ms.dao.vo.HistoryPriceVo;
import com.ms.service.CommodityService;
import com.ms.service.HistoryPriceService;
import com.ms.tools.utils.GsonUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.ZoneOffset;
import java.util.*;

@Service
public class HistoryPriceServiceImpl  extends AbsCommonService<HistoryPrice> implements HistoryPriceService{

	@Autowired
	private HistoryPriceDao historyPriceDao;

	@Autowired
	private CommodityService commodityService;


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
			SimpleDateFormat sdf = new SimpleDateFormat("MM.dd");
			dateR.add(sdf.format(his.getCreateTime()));
		});
		// 获取商品当前价格
		Commodity commodity = commodityService.findById(commodityId);
		SimpleDateFormat sdf = new SimpleDateFormat("MM.dd");
		if (dateR.contains(sdf.format(commodity.getPriceUpdateTime()))){
			value.set(value.size()-1,commodity.getPrice());
		} else {
			value.add(commodity.getPrice());
			dateR.add(sdf.format(commodity.getPriceUpdateTime()));
		}
		map.put("date", GsonUtil.toJson(dateR));
		map.put("value", GsonUtil.toJson(value));
		return map;
	}

	@Override
	@Transactional
	public Integer save(HistoryPrice historyPrice) {
		HistoryPrice oldPrice = historyPriceDao.duplicate(historyPrice.getCommodityId(),historyPrice.getCreateTime());
		if (oldPrice == null){
			create(historyPrice);
		} else {
			historyPrice.setId(oldPrice.getId());
			update(historyPrice);
		}
		return null;
	}

	@Override
	public ICommonDao<HistoryPrice> getDao() {
		return historyPriceDao;
	}

}
