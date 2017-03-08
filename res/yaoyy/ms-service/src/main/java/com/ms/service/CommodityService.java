package com.ms.service;

import com.github.pagehelper.PageInfo;
import com.ms.dao.model.Commodity;
import com.ms.dao.vo.CommodityVo;
import com.ms.dao.vo.HistoryPriceVo;

import java.util.Collection;
import java.util.List;

public interface CommodityService extends ICommonService<Commodity>{

    public PageInfo<CommodityVo> findByParams(CommodityVo commodityVo,Integer pageNum,Integer pageSize);

    public List<CommodityVo> findByIds(String ids);

    public void save(CommodityVo commodity, Integer memId);

    public CommodityVo findById(Integer id);

    public List<Commodity>  searchComodity(CommodityVo commodityVo);

    public List<Commodity> findByName(String name);

    public PageInfo<CommodityVo> findVoByPage(int pageSize,int pageNum);

    public List<CommodityVo> findByCategoryId(Integer id);

    public void updateStatusByCategoryId(Commodity commodity);

    public void updateStatus(int status,int commodityId);

    public List<CommodityVo> findBySupplier(Integer supplierId);

    /**
     * 调价
     * @param commodityVo 现在更新的价格
     */
    public void updatePrice(Integer memId, CommodityVo commodityVo);

    /**
     * 添加寄卖库存
     * @param id
     * @param num
     */
    void addStock(Integer id, Integer num);
}
