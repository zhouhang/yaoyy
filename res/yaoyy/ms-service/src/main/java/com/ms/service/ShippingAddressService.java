package com.ms.service;

import com.github.pagehelper.PageInfo;
import com.ms.dao.model.ShippingAddress;
import com.ms.dao.vo.ShippingAddressVo;

import java.util.List;

public interface ShippingAddressService extends ICommonService<ShippingAddress>{

    public PageInfo<ShippingAddressVo> findByParams(ShippingAddressVo shippingAddressVo,Integer pageNum,Integer pageSize);

    /**
     *根据用户Id查询左右的收货地址
     * @return
     */
    public List<ShippingAddressVo> findByUserId(Integer userId);

    /**
     * 获取默认的收货地址
     * @param userId
     * @return
     */
    public ShippingAddressVo getDefault(Integer userId);

    /**
     * 保存或者更新用户地址
     * @param sa
     * @return
     */
    public Integer save(ShippingAddress sa);

    /**
     * 根据地址Id 获取地质详情
     * @param addrId
     * @return
     */
    public ShippingAddressVo findVoById(Integer addrId);

    public void delete(Integer userId, Integer addressId);
}
