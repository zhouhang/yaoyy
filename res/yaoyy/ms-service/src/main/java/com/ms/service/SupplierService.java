package com.ms.service;

import com.github.pagehelper.PageInfo;
import com.ms.dao.model.Supplier;
import com.ms.dao.vo.SupplierCertifyVo;
import com.ms.dao.vo.SupplierVo;
import me.chanjar.weixin.mp.bean.result.WxMpUser;

import java.util.List;

public interface SupplierService extends ICommonService<Supplier>{

    public PageInfo<SupplierVo> findByParams(SupplierVo supplierVo,Integer pageNum,Integer pageSize);

    public SupplierVo findVoById(Integer id);

    public void save(SupplierVo supplierVo);

    List<SupplierVo> search(String name);

    public PageInfo<SupplierVo> findVoByParams(SupplierVo supplierVo,Integer pageNum,Integer pageSize);

    /**
     * 前台供应商入驻
     * @param supplierVo
     */
    Boolean register(SupplierVo supplierVo);


    /**
     * 前台供应商注册
     * @param supplierVo
     * @return
     */
    Boolean join(SupplierVo supplierVo,WxMpUser wxMpUser);


    void certify(SupplierCertifyVo supplierCertifyVo);


}
