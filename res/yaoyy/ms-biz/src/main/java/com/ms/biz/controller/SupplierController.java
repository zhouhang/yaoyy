package com.ms.biz.controller;

import com.github.pagehelper.PageInfo;
import com.ms.dao.enums.AnnouncementUserTypeEnum;
import com.ms.dao.model.*;
import com.ms.dao.vo.*;
import com.ms.service.*;
import com.ms.service.enums.MessageEnum;
import com.ms.service.enums.RedisEnum;
import com.ms.tools.entity.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Author: koabs
 * 3/7/17.
 */
@Controller
@RequestMapping("/supplier")
public class SupplierController extends BaseController{

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

    @Autowired
    private ShippingAddressHistoryService shippingAddressHistoryService;

    @Autowired
    private UserDetailService userDetailService;


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
     * 供应商订单详情
     * @param id
     * @return
     */
    @RequestMapping(value = "orderDetail/{id}", method = RequestMethod.GET)
    public String orderDetail(@PathVariable("id") Integer id, ModelMap model) {
        User user = (User) httpSession.getAttribute(RedisEnum.USER_SESSION_BIZ.getValue());
        PickVo pickVo = pickService.findVoById(id);
        model.put("pickVo", pickVo);
        //收货地址
        ShippingAddressHistory shippingAddressHistory = null;
        if (pickVo.getAddrHistoryId() != null) {
            shippingAddressHistory = shippingAddressHistoryService.findById(pickVo.getAddrHistoryId());
        }
        model.put("shippingAddressHistory", shippingAddressHistory);

        //获取下单用户信息
        UserDetail userDetail = userDetailService.findByUserId(pickVo.getUserId());
        if (userDetail == null) {
            userDetail = new UserDetail();
        }
        model.put("userDetail", userDetail);
        return "supplier/order_detail";
    }

    /**
     * 修改发货时间
     * @param orderId
     * @param date
     * @return
     */
    @RequestMapping(value = "update/DeliverTime", method = RequestMethod.POST)
    @ResponseBody
    public Result updateDeliverTime(Integer orderId,Date date){
        Pick pick = new Pick();
        pick.setId(orderId);
        pick.setDeliveryDate(date);
        pickService.update(pick);
        return Result.success().msg("修改送货时间成功!");
    }

    /**
     * 修改订单状态为已发货
     * @return
     */
    @RequestMapping(value = "delivery", method = RequestMethod.POST)
    @ResponseBody
    public Result supplierDelivery(Integer orderId,Date date){
        User user = (User) httpSession.getAttribute(RedisEnum.USER_SESSION_BIZ.getValue());
        UserDetail supplier = userDetailService.findByUserId(user.getId());
        Pick pick = pickService.findVoById(orderId);
        LogisticalVo logisticalVo = new LogisticalVo();
        logisticalVo.setOrderId(pick.getId());
        logisticalVo.setShipDate(date);
        pickService.supplierDelivery(logisticalVo,supplier);
        return Result.success().msg("订单已发货!");

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
