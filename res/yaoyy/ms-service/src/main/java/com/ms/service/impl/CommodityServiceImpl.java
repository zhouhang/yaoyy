package com.ms.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.ms.dao.HistoryPriceDao;
import com.ms.dao.ICommonDao;
import com.ms.dao.CommodityDao;
import com.ms.dao.enums.MsgIsMemberEnum;
import com.ms.dao.model.*;
import com.ms.dao.vo.CommodityVo;
import com.ms.dao.vo.HistoryPriceVo;
import com.ms.service.*;
import com.ms.service.enums.MessageEnum;
import com.ms.service.enums.MessageTemplateEnum;
import com.ms.service.enums.RedisEnum;
import com.ms.service.observer.MsgProducerEvent;
import com.ms.tools.ClazzUtil;
import com.ms.tools.upload.PathConvert;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpSession;
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

    @Autowired
    private ApplicationContext applicationContext;

    //@Autowired
    //private CommoditySearchService commoditySearchService;

    @Autowired
    private MessageService messageService;

    @Autowired
    HttpSession httpSession;

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
        // 分页插件 调用这句话表紧接着的查询要分页
        PageHelper.startPage(pageNum, pageSize);
        List<CommodityVo> list = commodityDao.findByParams(commodityVo);
        list.forEach(c->{
            c.setThumbnailUrl(pathConvert.getUrl(c.getThumbnailUrl()));
        });
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
    public List<CommodityVo> findByIds(List<Integer> list) {
        return commodityDao.findByIds(list);
    }


    @Override
    public ICommonDao<Commodity> getDao() {
        return commodityDao;
    }

    @Override
    @Transactional
    public void save(CommodityVo commodity,Integer memId) {
        Member mem= (Member) httpSession.getAttribute(RedisEnum.MEMBER_SESSION_BOSS.getValue());
        commodity.setPictureUrl(pathConvert.saveFileFromTemp(commodity.getPictureUrl(),folderName));
        Message message = new Message();
        if (commodity.getId() == null) {
            commodity.setCreateTime(new Date());
            commodity.setUpdateTime(new Date());
            commodity.setPriceUpdateTime(new Date());
            commodity.setWarehouse(0f);
            commodity.setUnwarehouse(0f);
            commodityDao.create(commodity);

            message.setUserId(commodity.getSupplierId());
            message.setContent(MessageTemplateEnum.SUPPLIER_COMMODITY_ADD_TEMPLATE.get().replace("{name}","管理员 " + mem.getName())
                    .replace("{commodity}", commodity.getName()).replace("{spec}",commodity.getSpec()));
        } else {

            //取出现在该商品数据
            CommodityVo com = findById(commodity.getId());
            message.setUserId(com.getSupplierId());
            //改库存数据
            if(  null != commodity.getUnwarehouse() && !com.getUnwarehouse().equals(commodity.getUnwarehouse())){
                message.setContent(MessageTemplateEnum.SUPPLIER_COMMODITY_STOCK_TEMPLATE.get().replace("{name}","管理员 " + mem.getName())
                        .replace("{commodity}", com.getName()).replace("{spec}",com.getSpec()).replace("{pre_stock}",com.getUnwarehouse().toString())
                        .replace("{stock}",commodity.getUnwarehouse().toString()));

            }
            //改价格数据
            if( commodity.getPrice() != null && !com.getPrice().equals(commodity.getPrice())){
                message.setContent(MessageTemplateEnum.SUPPLIER_COMMODITY_PRICE_TEMPLATE.get().replace("{name}","管理员 " + mem.getName())
                        .replace("{commodity}", com.getName()).replace("{spec}",com.getSpec()).replace("{pre_price}",com.getPrice().toString())
                        .replace("{price}",commodity.getPrice().toString()));

            }

            commodity.setUpdateTime(new Date());
            updatePrice(commodity,memId);
            commodityDao.update(commodity);

        }

        //发消息
        message.setType(MessageEnum.SUPPLIER_COMMODITY.get());
        message.setCreateTime(new Date());
        messageService.create(message);

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
        List<CommodityVo> list = commodityDao.findBySupplier(supplierId);
        list.forEach(c->{
            c.setThumbnailUrl(pathConvert.getUrl(c.getThumbnailUrl()));
        });
        return list;
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

    @Override
    @Transactional
    public void addStock(Integer id, Integer num) {
        CommodityVo commodity = findById(id);

        if (commodity.getWarehouse() == null){
            commodity.setWarehouse(Float.valueOf(num));
        } else {
            commodity.setWarehouse(commodity.getWarehouse() + num);
        }
        Commodity  commodity1 = new Commodity();
        commodity1.setId(commodity.getId());
        commodity1.setWarehouse(commodity.getWarehouse());
        update(commodity1);

        String content = "您的商品(" + commodity.getName() + commodity.getSpec()+")寄卖入库"+num+commodity.getUnitName();

        //添加库存消息
        MsgProducerEvent mp =new MsgProducerEvent(commodity.getSupplierId(),commodity.getId(), MessageEnum.SUPPLIER_COMMODITY_CONSIGNMENT, content, MsgIsMemberEnum.IS_NOT_MEMBER.getKey());
        applicationContext.publishEvent(mp);
    }

    @Override
    @Transactional
    public List<CommodityVo> findByParamsNoPage(CommodityVo commodityVo){
        return commodityDao.findByParams(commodityVo);
    }

	@Override
    @Transactional
	public void modStockOrPrice(CommodityVo commodityVo) {
        Message message = new Message();
        message.setUserId(commodityVo.getSupplierId());
        message.setType(MessageEnum.SUPPLIER_COMMODITY.get());

        Commodity  commodity = new Commodity();

        //取出现在该商品数据
        CommodityVo com = findById(commodityVo.getId());
        if (commodityVo.getUnwarehouse() != null){
            if (com.getUnwarehouse().equals(commodityVo.getUnwarehouse()))return;
            commodity.setId(commodityVo.getId());
            commodity.setUnwarehouse(commodityVo.getUnwarehouse());
			update(commodity);

            //发消息
            message.setContent(MessageTemplateEnum.SUPPLIER_COMMODITY_STOCK_TEMPLATE.get().replace("{name}","你")
            .replace("{commodity}", com.getName()).replace("{spec}",com.getSpec()).replace("{pre_stock}",com.getUnwarehouse().toString())
                    .replace("{stock}",commodityVo.getUnwarehouse().toString()));
            message.setCreateTime(new Date());
            messageService.create(message);

        } else if (commodityVo.getPrice() != null){
            if (com.getPrice().equals(commodityVo.getPrice()))return;
            commodity.setPrice(commodityVo.getPrice());
			updatePrice(commodityVo.getSupplierId(), commodityVo);

            //发消息
            message.setContent(MessageTemplateEnum.SUPPLIER_COMMODITY_PRICE_TEMPLATE.get().replace("{name}","你")
                    .replace("{commodity}", com.getName()).replace("{spec}",com.getSpec()).replace("{pre_price}",com.getPrice().toString())
                    .replace("{price}",commodityVo.getPrice().toString()));
            message.setCreateTime(new Date());
            messageService.create(message);
        }
        
    }

}
