package com.ms.biz.controller;

import com.github.pagehelper.PageInfo;
import com.ms.dao.enums.AnnouncementUserTypeEnum;
import com.ms.dao.model.Message;
import com.ms.dao.model.User;
import com.ms.dao.vo.AnnouncementVo;
import com.ms.dao.vo.CommodityVo;
import com.ms.dao.vo.MessageVo;
import com.ms.dao.vo.PickVo;
import com.ms.service.AnnouncementService;
import com.ms.service.CommodityService;
import com.ms.service.MessageService;
import com.ms.service.PickService;
import com.ms.service.enums.MessageEnum;
import com.ms.service.enums.RedisEnum;
import com.ms.tools.entity.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

/**
 * Author: koabs
 * 3/7/17.
 */
@Controller
@RequestMapping("/supplier")
public class SupplierController {

    @Autowired
    private CommodityService commodityService;

    @Autowired
    private AnnouncementService announcementService;

    @Autowired
    private MessageService messageService;

    @Autowired
    private PickService pickService;

    @Autowired
    private HttpSession httpSession;

    @RequestMapping(value = "/index", method = RequestMethod.GET)
    public String index(ModelMap model) {
        //获取登陆用户userId
        User user = (User) httpSession.getAttribute(RedisEnum.USER_SESSION_BIZ.getValue());
        //上架商品
        CommodityVo commodityVo = new CommodityVo();
        commodityVo.setSupplierId(user.getId());//supplier_id字段,如果是签约供应商则填的是userid,如果未签约则关联supplier表,与supplierid关联,感觉是巨坑啊
        commodityVo.setStatus(1);//只取上架商品
        List<CommodityVo> commodityVos = commodityService.findByParamsNoPage(commodityVo);
        model.put("commodities", commodityVos.size());
        //订单记录
        PickVo pickVo = new PickVo();
//        pickVo.setUserId(user.getId()); // 这里是去所有与供应商关联的订单所以应该填 SupplierId
        pickVo.setSupplierId(user.getId());
        List<PickVo> pickVos = pickService.findByParamsNoPage(pickVo);
        model.put("picks", pickVos.size());
        //寄卖数量
        Float sale = 0f;
        for (CommodityVo commodity:commodityVos){
            sale += commodity.getWarehouse()!=null?commodity.getWarehouse():0;
        }
        model.put("sale", sale);
        //网站公告
        AnnouncementVo announcementVo = new AnnouncementVo();
        List<Integer> userTypes = new ArrayList<Integer>();
        userTypes.add(AnnouncementUserTypeEnum.ALL.getKey());
        userTypes.add(AnnouncementUserTypeEnum.SUPPLIER.getKey());
        announcementVo.setUserTypes(userTypes);//0全体,1供应商
        PageInfo<AnnouncementVo> announcementVos = announcementService.findByParams(announcementVo, 0, 3);
        model.put("announcementVos", announcementVos.getList());
        //"我的消息"
        MessageVo messageVo = new MessageVo();
        messageVo.setUserId(user.getId());
        List<Integer> types = new ArrayList<Integer>();
        types.add(MessageEnum.SUPPLIER_SAMPLES.get());
        types.add(MessageEnum.SUPPLIER_COMMODITY.get());
        types.add(MessageEnum.SUPPLIER_ORDER.get());
        messageVo.setTypes(types);
        PageInfo<MessageVo> messageVos = messageService.findByParams(messageVo, 0, 3);
        model.put("messageVos", messageVos.getList());
        model.put("mynews", messageService.findByParamsNoPage(messageVo).size());

        return "supplier/index";
    }

    /**
     * 订单列表页面
     * @return
     */
    @RequestMapping(value = "order", method = RequestMethod.GET)
    public String order() {
        return "supplier/order_list";
    }

    /**
     * 供应商订单数据
     * @param pageNum
     * @param pageSize
     * @return
     */
    @RequestMapping(value = "order", method = RequestMethod.POST)
    @ResponseBody
    public Result orderData(Integer pageNum, Integer pageSize) {

        // 账期付款 账期信息获取: TODO:
        User user = (User) httpSession.getAttribute(RedisEnum.USER_SESSION_BIZ.getValue());
        PickVo vo = new PickVo();
        vo.setSupplierId(user.getId());
        PageInfo<PickVo> pageInfo = pickService.findByParams(vo, pageNum, pageSize);
        return Result.success().data(pageInfo);
    }


    /**
     * 寄卖商品列表和 寄卖商品跟踪消息
     * @return
     */
    @RequestMapping(value = "commodityTrace", method = RequestMethod.GET)
    public String commodityTrace(ModelMap model) {
        User user = (User) httpSession.getAttribute(RedisEnum.USER_SESSION_BIZ.getValue());
        List<CommodityVo> list = commodityService.findBySupplier(user.getId());
        model.put("list",list);
        return "/supplier/commodity_trace";
    }

    /**
     * 获取货物跟踪消息
     * @return
     */
    @RequestMapping(value = "commodityTrace", method = RequestMethod.POST)
    @ResponseBody
    public Result commodityTraceData(Integer pageNum,Integer pageSize) {
        User user = (User) httpSession.getAttribute(RedisEnum.USER_SESSION_BIZ.getValue());
        PageInfo<MessageVo> pageInfo = messageService.findSupplierCommodityTraceMsg(user.getId(),pageNum,pageSize);
        return Result.success().data(pageInfo);
    }

    /**
     * 商品调价页面
     * @return
     */
    @RequestMapping(value = "adjust", method = RequestMethod.GET)
    public String adjustment() {
        return "supplier/commodity_adjust";
    }

    /**
     * 获取商品数据
     * @return
     */
    @RequestMapping(value = "getCommodities", method = RequestMethod.POST)
    @ResponseBody
    public Result getCommodities(Integer pageNum) {
        User user = (User) httpSession.getAttribute(RedisEnum.USER_SESSION_BIZ.getValue());
        CommodityVo commodityVo = new CommodityVo();
        commodityVo.setSupplierId(user.getId());
        PageInfo<CommodityVo> commodityVos = commodityService.findByParams(commodityVo, pageNum, 5);
        return Result.success().data(commodityVos.getList());
    }

	/**
     * 修改商品库存或价格
     * @return
     */
    @RequestMapping(value = "modCommodity", method = RequestMethod.POST)
    @ResponseBody
    public Result modCommodity(CommodityVo commodityVo) {
        User user = (User) httpSession.getAttribute(RedisEnum.USER_SESSION_BIZ.getValue());
        commodityVo.setSupplierId(user.getId());
        commodityService.modStockOrPrice(commodityVo);
        return Result.success("修改成功");
    }


}
