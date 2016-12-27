package com.ms.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.ms.dao.ICommonDao;
import com.ms.dao.ShippingAddressDao;
import com.ms.dao.model.Area;
import com.ms.dao.model.ShippingAddress;
import com.ms.dao.vo.AreaVo;
import com.ms.dao.vo.ShippingAddressVo;
import com.ms.service.AreaService;
import com.ms.service.ShippingAddressService;
import com.ms.tools.exception.ControllerException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class ShippingAddressServiceImpl  extends AbsCommonService<ShippingAddress> implements ShippingAddressService{

	@Autowired
	private ShippingAddressDao shippingAddressDao;


	@Autowired
	private AreaService areaService;

	@Override
	public PageInfo<ShippingAddressVo> findByParams(ShippingAddressVo shippingAddressVo,Integer pageNum,Integer pageSize) {
    PageHelper.startPage(pageNum, pageSize);
    	List<ShippingAddressVo>  list = shippingAddressDao.findByParams(shippingAddressVo);
        PageInfo page = new PageInfo(list);
        return page;
	}

	@Override
	public List<ShippingAddressVo> findByUserId(Integer userId) {
		ShippingAddressVo vo = new ShippingAddressVo();
		vo.setUserId(userId);
		List<ShippingAddressVo> list = shippingAddressDao.findByParams(vo);
		// 如果用户的收货地址只有一个设置为默认收货地址.
		if (list.size() == 1){
			list.get(0).setIsDefault(true);
		}

		list.forEach(addressVo ->{
			getFullAdd(addressVo);
		});

		return list;
	}

	@Override
	public ShippingAddressVo getDefault(Integer userId) {
		// 地址只有一个时不管是否设置默认收货地址都当做默认的收货地址
		ShippingAddressVo vo = new ShippingAddressVo();
		vo.setUserId(userId);
		vo.setIsDefault(true);
		List<ShippingAddressVo> list = shippingAddressDao.findByParams(vo);
		return getFullAdd(list.size()>0?list.get(0):null);
	}

	@Override
	@Transactional
	public Integer save(ShippingAddress sa) {

		if (sa.getId() != null) {
			// 设置默认地址的话 先把以前的默认地址清空
			if (sa.getIsDefault()) {
				shippingAddressDao.updateAllNotDefault(sa.getUserId());
			}
			super.update(sa);
		} else {
			// 检测已经存在的地址有没有超过5个 且新增的情况
			if (shippingAddressDao.getCountByUserId(sa.getUserId())>=5) {
				throw new ControllerException("用户保存的地址已经超过了5个,无法再继续添加.");
			}
			// 设置默认地址的话 先把以前的默认地址清空
			if (sa.getIsDefault()) {
				shippingAddressDao.updateAllNotDefault(sa.getUserId());
			}
			super.create(sa);
		}
		return sa.getId();
	}

	@Override
	public ShippingAddressVo findVoById(Integer addrId) {
		ShippingAddressVo vo = new ShippingAddressVo();
		vo.setId(addrId);
		List<ShippingAddressVo> list = shippingAddressDao.findByParams(vo);
		return getFullAdd(list.size()>0?list.get(0):null);
	}

	/**
	 * 获取地址全称
	 */
	private ShippingAddressVo getFullAdd(ShippingAddressVo shippingAddressVo){
		if (shippingAddressVo.getAreaId() != null) {
			AreaVo area = areaService.findVoById(shippingAddressVo.getAreaId());
			shippingAddressVo.setProvinceId(area.getProvinceId());
			shippingAddressVo.setCityId(area.getCityId());
			shippingAddressVo.setFullAdd( area.getProvince() + area.getCity() + area.getAreaname());
		}
		return shippingAddressVo;
	}

	@Override
	@Transactional
	public void delete(Integer userId, Integer addressId) {
		shippingAddressDao.delete(userId,addressId);
	}

	@Override
	public ICommonDao<ShippingAddress> getDao() {
		return shippingAddressDao;
	}

}
