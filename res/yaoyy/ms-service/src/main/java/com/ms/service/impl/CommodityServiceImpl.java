package com.ms.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.ms.dao.HistoryPriceDao;
import com.ms.dao.ICommonDao;
import com.ms.dao.CommodityDao;
import com.ms.dao.model.Commodity;
import com.ms.dao.model.FollowCommodity;
import com.ms.dao.model.Gradient;
import com.ms.dao.model.HistoryPrice;
import com.ms.dao.vo.CommodityVo;
import com.ms.dao.vo.HistoryPriceVo;
import com.ms.service.*;
import com.ms.tools.ClazzUtil;
import com.ms.tools.upload.PathConvert;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.stream.Stream;

@Service
public class CommodityServiceImpl extends AbsCommonService<Commodity> implements CommodityService {

    @Autowired
    private CommodityDao commodityDao;

    @Autowired
    private PathConvert pathConvert;

    @Autowired
    private HistoryPriceService historyPriceService;

    @Autowired
    private FollowCommodityService followCommodityService;

    //@Autowired
    //private CommoditySearchService commoditySearchService;

    /**
     * 商品图片保存路径
     */
    private String folderName = "commodity/";

    @Override
    public PageInfo<CommodityVo> findByParams(CommodityVo commodityVo, Integer pageNum, Integer pageSize) {
        if (pageNum == null || pageSize == null) {
            pageNum = 1;
            pageSize = 10;
        }
        PageHelper.startPage(pageNum, pageSize);
        List<CommodityVo> list = commodityDao.findByParams(commodityVo);
        PageInfo page = new PageInfo(list);
        return page;
    }

    @Override
    public List<CommodityVo> findByIds(String ids) {
        List<Integer> list = new ArrayList<>();
        for(String id :ids.split(",")){
            list.add(Integer.parseInt(id));
        }
        return commodityDao.findByIds(list);
    }




    @Override
    public ICommonDao<Commodity> getDao() {
        return commodityDao;
    }

    @Override
    @Transactional
    public void save(CommodityVo commodity,Integer memId) {

        commodity.setPictureUrl(pathConvert.saveFileFromTemp(commodity.getPictureUrl(),folderName));
        if (commodity.getId() == null) {
            commodity.setCreateTime(new Date());
            commodity.setUpdateTime(new Date());
            commodity.setPriceUpdateTime(new Date());
            commodityDao.create(commodity);
        } else {
            commodity.setUpdateTime(new Date());
            updatePrice(commodity,memId);
            commodityDao.update(commodity);
        }

        if (commodity.getGradient() != null) {
            commodity.getGradient().forEach(gradient -> {
                gradient.setCreateTime(new Date());
                gradient.setUpdateTime(new Date());
                gradient.setCommodityId(commodity.getId());
            });
        }
        //commoditySearchService.save(commodity);
    }

    @Override
    public CommodityVo findById(Integer id) {
        CommodityVo vo = new CommodityVo();
        vo.setId(id);
        List<CommodityVo> commodityVos=commodityDao.findByParams(vo);
        if(commodityVos.size()==0){
            return null;
        }
        vo = commodityVos.get(0);
        vo.setPictureUrl(pathConvert.getUrl(vo.getPictureUrl()));
        return vo;
    }

    @Override
    public List<Commodity> searchComodity(CommodityVo commodityVo) {
        return commodityDao.searchComodity(commodityVo);
    }

    @Override
    public List<Commodity> findByName(String name) {
        return commodityDao.findByName(name);
    }

    @Override
    public PageInfo<CommodityVo> findVoByPage(int pageSize, int pageNum) {
        PageHelper.startPage(pageNum, pageSize);
        List<CommodityVo> list = commodityDao.findVoByPage();
        list.forEach(c->{
            c.setPictureUrl(pathConvert.getUrl(c.getPictureUrl()));
        });
        PageInfo pageInfo = new PageInfo(list);
        return pageInfo;
    }

    @Override
    public List<CommodityVo> findByCategoryId(Integer id) {
        return commodityDao.findByCategoryId(id);
    }

    @Override
    @Transactional
    public void updateStatusByCategoryId(Commodity commodity) {
       commodityDao.updateStatusByCategoryId(commodity);
    }

    @Override
    @Transactional
    public void updateStatus(int status, int commodityId) {
        Commodity commodity = new Commodity();
        commodity.setStatus(status);
        commodity.setId(commodityId);
        commodityDao.updateStatusById(commodity);
    }

    @Override
    public List<CommodityVo> findBySupplier(Integer supplierId) {
        return commodityDao.findBySupplier(supplierId);
    }

    @Override
    @Transactional
    public void updatePrice(Integer memId, CommodityVo commodityVo) {
        commodityVo.setUpdateTime(new Date());
        updatePrice(commodityVo,memId);
        commodityDao.update(commodityVo);
    }

    /**
     * 更新历史价格
     * @param vo
     * @param memId
     */
    private void updatePrice(CommodityVo vo, Integer memId){
        Commodity oldCommodity= commodityDao.findById(vo.getId());
        if (oldCommodity==null){
            throw new RuntimeException("商品不存在");
        }
        // 比较当前价格和之前价格是否有变动
        if (!(vo.getPrice().floatValue() == oldCommodity.getPrice().floatValue())){
            // 以前的价格存为历史价格
            HistoryPriceVo historyPrice=new HistoryPriceVo();
            historyPrice.setCommodityId(oldCommodity.getId());
            historyPrice.setCreateId(memId);
            historyPrice.setPrice(oldCommodity.getPrice());
            historyPrice.setCreateTime(new Date());
            vo.setPriceUpdateTime(new Date());
            historyPriceService.save(historyPrice);
            // 商品价格变动时修改用户关注的商品状态
            followCommodityService.updateStatus(vo.getId());
        }
    }



    @Override
    @Transactional
    public int deleteById(int id) {
        //commoditySearchService.deleteByCommodityId(id);
        return super.deleteById(id);
    }


}
